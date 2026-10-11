# yiidb 查询练习

## 使用说明

这套练习根据提供的三个 SQL 文件编写，以一家模型商品销售公司的客户、员工、产品、订单及收款业务为场景。共 **60 道题**，按六个阶段递进，每题包括业务背景、查询目标、参考 SQL、语句解析、实际数据核对、易错点与继续练习。

数据库实际名称为 **`yiibaidb`**，不是文件标题中的 `yiidb`。请在教学数据库执行练习。建议使用 **MySQL 8.0 或更高版本**；第 46、47、49 及第 51–60 题使用 CTE、窗口函数或递归 CTE，其中第 57 题本身不依赖这些高级特性。其他题目主要使用传统查询语法。

**验证范围。** 已完整解析三个文件，并在 SQLite 本地验证库载入全部原始记录；60 道参考查询均已进行数据逻辑验证，外键引用亦已检查。本环境没有 MySQL 服务，未声称完成 MySQL 原生执行验证。验证时对 `YEAR`、`DATE_FORMAT`、`DATEDIFF`、`CONCAT`、`SUBSTRING`、`CHAR_LENGTH` 提供等价函数，对第 19 题把 `CAST ... AS SIGNED` 映射为 SQLite 整数类型。题中 SQL 按 MySQL 书写，可直接在已导入数据的 MySQL 8.0 中运行。

数值结果展示到两位小数；SQLite 的数值计算与 MySQL `DECIMAL` 的精度、舍入规则并非完全等同。涉及金额和比率的结果应在课堂 MySQL 环境复核。字符串的大小写、排序和 LIKE 行为还受数据库排序规则影响；题目用编号补充排序以减少歧义。结果核对仅适用于这份未修改的原始数据。

**学习方法。** 先只读题目并独立完成，尝试写出结果的“一行代表什么”，再展开参考答案。答案用可折叠区块与题目分开；支持 GitHub 风格 Markdown 的阅读器可直接使用。不支持折叠的编辑器仍能读取完整内容。

## 一 三个 SQL 文件的具体分析

### 1 建库脚本

`1. CREATE-YIIBAIDB.sql` 只有四行，依次删除已有 `yiibaidb`、创建同名数据库，并用 `USE` 选择数据库。

```sql
DROP DATABASE IF EXISTS `yiibaidb`;
CREATE DATABASE `yiibaidb`;
USE `yiibaidb`;
```

`IF EXISTS` 只避免“数据库不存在”的错误，不保护已有数据。重新运行第一行会删除原数据库及其中数据。脚本没有显式指定数据库字符集或排序规则，数据库级配置继承服务器设置；表级配置见下面的建表文件。

### 2 建表脚本

`2. CREATE-YIIBAIDB-TABLE.sql` 建立十张表。所有表使用 `InnoDB` 和表级 `DEFAULT CHARSET=utf8`；文件包含 `DROP TABLE IF EXISTS`，重复执行会重建表。`int(11)` 和 `smallint(6)` 中括号内的数字是历史显示宽度，不表示可存储十一位或六位数字。

文件开头设置 `SET FOREIGN_KEY_CHECKS=0`，以允许先建立引用尚未创建父表的表，**文件结尾没有恢复为 1**。同一连接后续导入时外键检查仍可能关闭；导入结束应恢复，并单独验证已有记录的引用完整性。重新开启检查不会自动回溯验证关闭检查期间插入的每一行。

`orderdetails` 的主键是 `(orderNumber, productCode)`；`payments` 的主键是 `(customerNumber, checkNumber)`。`items.id` 是自增主键，表定义的下一自增起点为 10。`tokens` 没有主键或唯一约束。表中只有 `products` 的部分字段带中文注释，其余字典解释依据字段、关系与实际值补充，不把推断写成数据库约束。

### 3 数据脚本

`3. INSERT_DATA_INTO_TABLEs.sql` 包含 3,874 条单行 INSERT，每条插入一条记录。语句没有显式列名，值严格依赖建表文件的字段顺序。改变表字段顺序后直接复用这些语句可能导入错误。字符串含 MySQL 的反斜杠转义，如 `\'`、`\r\n`；导入时需要保留原文，并注意 `NO_BACKSLASH_ESCAPES` SQL 模式会改变解释方式。

实际插入顺序为办公室、产品线、产品、员工、客户、付款、演示编号、订单、订单明细、字符串演示表。它有助于满足业务表的引用依赖；员工还存在对自身上级的引用，需要一并检查。

### 4 导入与版本确认

在 MySQL 图形客户端中，使用同一连接依次执行三个文件，再执行：

```sql
USE yiibaidb;
SET FOREIGN_KEY_CHECKS = 1;
SELECT VERSION() AS mysql_version;
SELECT @@SESSION.sql_mode AS sql_mode;
SELECT @@SESSION.foreign_key_checks AS foreign_key_checks;
```

建表与数据文件没有各自的 `USE` 语句，若换了连接，需要重新选库。遇到 `No database selected` 时先核对当前库；遇到 `ONLY_FULL_GROUP_BY` 错误时，检查输出列是否都已分组或聚合，不要首先关闭该模式。本练习的聚合查询显式列出分组键。

## 二 样本数据概览

| 表 | 记录数 | 一行代表什么 |
| --- | --- | --- |
| customers | 122 | 客户主档；一行是一家公司或客户账户。 |
| employees | 23 | 员工主档；一行是一位员工，reportsTo 描述直属上级。 |
| offices | 7 | 办公室主档；一行是一个办公地点。 |
| productlines | 7 | 产品分类主档；一行是一条产品线。 |
| products | 110 | 产品主档；一行是一个可销售的模型商品。 |
| orders | 326 | 订单头；一行是一张订单，不含逐件产品或订单金额。 |
| orderdetails | 2996 | 订单明细；一行是某张订单中的一个产品。 |
| payments | 273 | 付款流水；一行是某客户的一笔付款。 |
| items | 9 | 独立演示表；一行是一个带数字后缀的编号。 |
| tokens | 1 | 独立字符串演示表；无主键，不保证字符串唯一。 |

订单下单日期为 **2013-01-06 至 2015-05-31**，付款日期为 **2013-01-16 至 2015-06-09**。样本不是三个完整年度；2015 年尤其不能直接与完整 2014 年进行年度同比。高级活跃度题固定使用 `2015-06-10`，不使用当前日期，以保证课堂结果可复现。

订单状态如下。中文仅用于解释，查询条件必须使用原始英文字符串：

| status 实际值 | 说明 | 订单数 |
| --- | --- | --- |
| Cancelled | 已取消 | 6 |
| Disputed | 争议中 | 3 |
| In Process | 处理中 | 6 |
| On Hold | 暂停 | 4 |
| Resolved | 已解决 | 4 |
| Shipped | 已发货 | 303 |

### 空值与数据质量观察

这些是样本事实，不是未来数据的保证：

- 22 位客户未分配销售员工；24 位客户没有订单。两组数量和含义不同。
- 14 张订单没有发货日期，246 张订单没有备注；缺少发货日期不等于全部“等待发货”。
- 73 位客户没有 state，100 位客户没有 addressLine2，7 位客户没有 postalCode。
- creditLimit 在结构上可为空，但此次 122 条客户记录都填写了数值，零额度不是 NULL。
- 最高负责人 reportsTo 为空，样本中只有一人；递归展开可覆盖全部 23 位员工。
- 产品线的 htmlDescription、image 全部为空；textDescription 均有值。
- 本次载入未发现八组声明外键的孤立引用，主键未出现重复；这不是对生产系统数据质量的承诺。
- 北京办公室的 territory 存为 NA，不能自行解释为“亚洲”；区域代码与地理常识不一致时应核查原数据。
- 有一款产品没有出现在任何订单明细中；第 39 题可找到它。

金额字段没有声明币种。练习称“金额”或“金额单位”，不直接标成美元或人民币。数据库也没有税费、退款、汇率、发票、送达日期、历史成本、付款分配表。相关分析必须注明这些限制。

## 三 完整数据字典

说明：PK 为主键，FK 为外键；“允许空”来自建表约束，“样本空值数”来自当前数据。复合主键中的一个字段单独不保证唯一。字符串字段长度按原定义保留。

### customers

客户主档；一行是一家公司或客户账户。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| customerNumber | int(11) | 否 | PK | 0 | 客户编号；客户主档的标识，在订单和付款表中表示所属客户 |
| customerName | varchar(50) | 否 | — | 0 | 客户公司名称 |
| contactLastName | varchar(50) | 否 | — | 0 | 联系人姓 |
| contactFirstName | varchar(50) | 否 | — | 0 | 联系人名 |
| phone | varchar(50) | 否 | — | 0 | 联络电话，按文本保存 |
| addressLine1 | varchar(50) | 否 | — | 0 | 地址第一行 |
| addressLine2 | varchar(50) | 是 | — | 100 | 地址第二行，可未填写 |
| city | varchar(50) | 否 | — | 0 | 城市 |
| state | varchar(50) | 是 | — | 73 | 州或省，可未填写 |
| postalCode | varchar(15) | 是 | — | 7 | 邮政编码，按文本保存以保留前导零与字母 |
| country | varchar(50) | 否 | — | 0 | 国家名称或代码，以实际值为准 |
| salesRepEmployeeNumber | int(11) | 是 | FK → employees.employeeNumber | 22 | 负责该客户的销售员工编号，可未分配 |
| creditLimit | decimal(10,2) | 是 | — | 0 | 客户授信额度，不等于已收款或剩余额度 |
主键：`customerNumber`。

### employees

员工主档；一行是一位员工，reportsTo 描述直属上级。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| employeeNumber | int(11) | 否 | PK | 0 | 员工编号 |
| lastName | varchar(50) | 否 | — | 0 | 员工姓 |
| firstName | varchar(50) | 否 | — | 0 | 员工名 |
| extension | varchar(10) | 否 | — | 0 | 电话分机号 |
| email | varchar(100) | 否 | — | 0 | 员工电子邮件地址 |
| officeCode | varchar(10) | 否 | FK → offices.officeCode | 0 | 办公室编号，按文本保存 |
| reportsTo | int(11) | 是 | FK → employees.employeeNumber | 1 | 直属上级员工编号；最高负责人为空 |
| jobTitle | varchar(50) | 否 | — | 0 | 岗位名称 |
主键：`employeeNumber`。

### offices

办公室主档；一行是一个办公地点。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| officeCode | varchar(10) | 否 | PK | 0 | 办公室编号，按文本保存 |
| city | varchar(50) | 否 | — | 0 | 城市 |
| phone | varchar(50) | 否 | — | 0 | 联络电话，按文本保存 |
| addressLine1 | varchar(50) | 否 | — | 0 | 地址第一行 |
| addressLine2 | varchar(50) | 是 | — | 2 | 地址第二行，可未填写 |
| state | varchar(50) | 是 | — | 3 | 州或省，可未填写 |
| country | varchar(50) | 否 | — | 0 | 国家名称或代码，以实际值为准 |
| postalCode | varchar(15) | 否 | — | 0 | 邮政编码，按文本保存以保留前导零与字母 |
| territory | varchar(10) | 否 | — | 0 | 业务区域代码，样本包含 NA、EMEA、APAC |
主键：`officeCode`。

### productlines

产品分类主档；一行是一条产品线。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| productLine | varchar(50) | 否 | PK | 0 | 产品线名称，也是分类主表的主键 |
| textDescription | varchar(4000) | 是 | — | 0 | 产品线纯文本描述 |
| htmlDescription | mediumtext | 是 | — | 7 | 产品线 HTML 描述，样本均为空 |
| image | mediumblob | 是 | — | 7 | 产品线图片二进制数据，样本均为空 |
主键：`productLine`。

### products

产品主档；一行是一个可销售的模型商品。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| productCode | varchar(15) | 否 | PK | 0 | 产品代码，产品表主键，在明细中引用产品 |
| productName | varchar(70) | 否 | — | 0 | 产品名称 |
| productLine | varchar(50) | 否 | FK → productlines.productLine | 0 | 产品线名称，也是分类主表的主键 |
| productScale | varchar(10) | 否 | — | 0 | 模型比例，例如 1:10 |
| productVendor | varchar(50) | 否 | — | 0 | 产品供应商名称，没有单独供应商主表 |
| productDescription | text | 否 | — | 0 | 产品详细说明 |
| quantityInStock | smallint(6) | 否 | — | 0 | 当前记录的库存件数，不包含历史库存流水 |
| buyPrice | decimal(10,2) | 否 | — | 0 | 产品主档当前进价，用于估算成本 |
| MSRP | decimal(10,2) | 否 | — | 0 | 建议零售价，不等于本次成交价 |
主键：`productCode`。`productCode` 默认值为 `''`，其余非空字段未提供默认值；不应依赖空字符串代码创建业务商品。

### orders

订单头；一行是一张订单，不含逐件产品或订单金额。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| orderNumber | int(11) | 否 | PK | 0 | 订单编号 |
| orderDate | date | 否 | — | 0 | 下单日期 |
| requiredDate | date | 否 | — | 0 | 要求日期；没有进一步说明是期望发货还是送达日期 |
| shippedDate | date | 是 | — | 14 | 已记录的发货日期，可为空 |
| status | varchar(15) | 否 | — | 0 | 当前订单状态，不是状态历史 |
| comments | text | 是 | — | 246 | 订单备注，可为空 |
| customerNumber | int(11) | 否 | FK → customers.customerNumber | 0 | 客户编号；客户主档的标识，在订单和付款表中表示所属客户 |
主键：`orderNumber`。

### orderdetails

订单明细；一行是某张订单中的一个产品。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| orderNumber | int(11) | 否 | 复合 PK；FK → orders.orderNumber | 0 | 订单编号 |
| productCode | varchar(15) | 否 | 复合 PK；FK → products.productCode | 0 | 产品代码，产品表主键，在明细中引用产品 |
| quantityOrdered | int(11) | 否 | — | 0 | 该明细订购件数 |
| priceEach | decimal(10,2) | 否 | — | 0 | 该明细实际成交单价 |
| orderLineNumber | smallint(6) | 否 | — | 0 | 订单内展示行号，未被定义为唯一键 |
主键：`orderNumber, productCode`。结构没有把 `orderLineNumber` 定义成订单内唯一字段，也没有 CHECK 约束保证数量大于零。不要把业务习惯当作数据库已经强制的规则。

### payments

付款流水；一行是某客户的一笔付款。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| customerNumber | int(11) | 否 | 复合 PK；FK → customers.customerNumber | 0 | 客户编号；客户主档的标识，在订单和付款表中表示所属客户 |
| checkNumber | varchar(50) | 否 | 复合 PK | 0 | 付款凭证号，与客户编号共同唯一；不是订单编号 |
| paymentDate | date | 否 | — | 0 | 付款日期 |
| amount | decimal(10,2) | 否 | — | 0 | 该笔付款金额 |
主键：`customerNumber, checkNumber`。付款按客户关联，没有订单外键。不能凭相同客户编号把一笔付款分配到每一张订单。

### items

独立演示表；一行是一个带数字后缀的编号。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| id | int(11) | 否 | PK；自增 | 0 | 演示记录编号，自增主键 |
| item_no | varchar(255) | 否 | — | 0 | 演示编号，样本采用 A-数字 格式 |
主键：`id`。当前 id 为 1–9；item_no 为 A-1、A-2、A-3、A-4、A-5、A-10、A-11、A-20、A-30。item_no 没有唯一约束。

### tokens

独立字符串演示表；无主键，不保证字符串唯一。


| 字段 | SQL 类型 | 允许空 | 键及约束 | 样本空值数 | 业务解释 |
| --- | --- | --- | --- | --- | --- |
| s | varchar(6) | 是 | — | 0 | 演示字符串，样本为 abcdef |
主键：无。当前 s 为 `abcdef`；允许空，也允许重复行。它是字符串练习素材，不是登录令牌系统。

## 四 表关系与查询口径

### 1 外键关系


| 外键字段 | 引用字段 | 关系 |
| --- | --- | --- |
| customers.salesRepEmployeeNumber | employees.employeeNumber | 多对一；上级/负责人可空 |
| employees.reportsTo | employees.employeeNumber | 多对一；上级/负责人可空 |
| employees.officeCode | offices.officeCode | 多对一 |
| orderdetails.orderNumber | orders.orderNumber | 多对一 |
| orderdetails.productCode | products.productCode | 多对一 |
| orders.customerNumber | customers.customerNumber | 多对一 |
| payments.customerNumber | customers.customerNumber | 多对一 |
| products.productLine | productlines.productLine | 多对一 |

`items` 与 `tokens` 不属于销售业务关联链。外键未声明 ON DELETE CASCADE 或 ON UPDATE CASCADE，不能假设删除客户会自动清理订单。产品名、客户名、邮箱、办公室城市及供应商名都没有唯一约束，业务关联应优先使用主外键。

### 2 两条关键查询路径

- 查销售产品：客户 → 订单 → 订单明细 → 产品 → 产品线。订单头提供日期和状态，明细提供数量及成交单价。
- 查销售组织：客户 → 销售员工 → 办公室。员工 → 上级员工为自连接。
- 查付款：客户 → 付款；付款没有继续连到订单的明确键。

### 3 必须先确定结果粒度

一个订单有多条明细，一个客户有多张订单和多笔付款。连接后不能盲目 COUNT(*)；若要订单数量，通常先按订单聚合或 COUNT(DISTINCT orderNumber)。订单明细与付款同时连接到客户，会形成多对多行组合并重复计算两边金额，应分别汇总至客户粒度再关联。

本练习中，**订购金额**包含全部状态订单；题目明确写“已发货金额”时，只选择 `status = 'Shipped'`。该口径是教学分析定义，不代替会计收入确认。当前进价估算差额不是历史真实毛利，订单金额减付款也不是已验证应收账款。

### 4 查询逻辑顺序

理解 SQL 时，可按 `FROM / JOIN → WHERE → GROUP BY → HAVING → 窗口计算 → SELECT → ORDER BY → LIMIT` 梳理。它是帮助理解结果的逻辑顺序，不代表优化器的实际物理执行顺序。窗口结果通常需要外层查询筛选；WHERE 不能引用同层窗口别名。

## 五 练习路线与目录


| 阶段 | 题号 | 目标 |
| --- | --- | --- |
| 阶段一 基础查询与结果控制 | 01–10 | 掌握字段选择、排序、去重、分页 |
| 阶段二 条件筛选与表达式 | 11–20 | 正确处理条件、日期、空值、表达式 |
| 阶段三 聚合统计与分组筛选 | 21–30 | 区分行、组、件数和金额 |
| 阶段四 多表关联与业务核对 | 31–40 | 理解主外键、左连接及连接后粒度 |
| 阶段五 子查询与综合汇总 | 41–50 | 掌握存在性判断、分组后再关联 |
| 阶段六 窗口函数与递归分析 | 51–60 | 保留明细分析、排名、时间和层级 |

### 阶段一 基础查询与结果控制

- 第 01 题 查看产品目录
- 第 02 题 建立客户通讯录
- 第 03 题 查看员工岗位
- 第 04 题 整理办公室分布
- 第 05 题 查看产品线说明
- 第 06 题 核对订单登记信息
- 第 07 题 查看付款流水
- 第 08 题 去重查看客户国家
- 第 09 题 查看建议零售价最高的十个产品
- 第 10 题 分页浏览客户

### 阶段二 条件筛选与表达式

- 第 11 题 筛选美国客户
- 第 12 题 筛选信用额度较高的客户
- 第 13 题 筛选欧洲两国客户
- 第 14 题 筛选中等价格产品
- 第 15 题 查询指定年度订单
- 第 16 题 检索名称含 Ferrari 的产品
- 第 17 题 查找未记录发货日期的订单
- 第 18 题 估算建议售价与进价的差额
- 第 19 题 对演示编号进行自然排序
- 第 20 题 输出完整联系人姓名

### 阶段三 聚合统计与分组筛选

- 第 21 题 统计客户总数
- 第 22 题 按国家统计客户
- 第 23 题 统计产品线规模与库存
- 第 24 题 找出客户数至少五人的国家
- 第 25 题 按状态统计订单
- 第 26 题 统计年度订单规模
- 第 27 题 统计客户累计付款
- 第 28 题 计算每张订单的明细金额
- 第 29 题 筛选平均成交单价较高的产品
- 第 30 题 统计产品线的价格范围

### 阶段四 多表关联与业务核对

- 第 31 题 把订单与客户名称关联
- 第 32 题 查询员工办公地点
- 第 33 题 显示每位员工的直属上级
- 第 34 题 列出所有客户及销售负责人
- 第 35 题 查看一张订单的产品明细
- 第 36 题 汇总已发货订单的产品线金额
- 第 37 题 统计全部客户的订单数
- 第 38 题 查找从未下单的客户
- 第 39 题 查找从未被订购的产品
- 第 40 题 核查超过要求日期的发货

### 阶段五 子查询与综合汇总

- 第 41 题 查找进价高于全体平均的产品
- 第 42 题 查找高于所属产品线平均价的产品
- 第 43 题 筛选有付款记录的客户
- 第 44 题 筛选没有付款的下单客户
- 第 45 题 查找从未订购摩托车产品的客户
- 第 46 题 找出金额高于平均订单金额的订单
- 第 47 题 找出每位客户最大的订单
- 第 48 题 查看已发货销售额最高的十位客户
- 第 49 题 比较客户订单金额与付款合计
- 第 50 题 查找订购全部产品线的客户

### 阶段六 窗口函数与递归分析

- 第 51 题 按授信额度生成客户排名
- 第 52 题 选取每条产品线最贵的三个产品
- 第 53 题 查询每位客户最近的一张订单
- 第 54 题 计算每位客户的下单间隔
- 第 55 题 计算每位客户累计付款
- 第 56 题 比较逐月已发货订单金额
- 第 57 题 估算已发货商品成本与差额
- 第 58 题 递归生成员工组织层级
- 第 59 题 把演示字符串逐字符展开
- 第 60 题 建立客户活跃度与价值概览

## 六 60 道递进查询练习

## 阶段一 基础查询与结果控制

### 第 01 题 查看产品目录

**业务背景**：销售人员接到客户询价，需要先知道公司提供哪些模型产品。

**查询目标**：列出产品代码、名称和产品线，按代码排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName, productLine
FROM products
ORDER BY productCode;
```

**语句解析**：SELECT 明确选择展示字段；FROM 指定产品表；ORDER BY 使目录顺序稳定。返回一行代表一个产品。

**原始数据核对**：返回 **110 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | productLine |
| --- | --- | --- |
| S10_1678 | 1969 Harley Davidson Ultimate Chopper | Motorcycles |
| S10_1949 | 1952 Alpine Renault 1300 | Classic Cars |
| S10_2016 | 1996 Moto Guzzi 1100i | Motorcycles |

**易错点**：查询结果默认没有可靠顺序，不能把插入顺序当作排序。

</details>

**继续练习**：再增加 productScale 字段，说明它与 productLine 的区别。

### 第 02 题 建立客户通讯录

**业务背景**：客服要联系客户公司，不需要下载地址和信用额度等全部信息。

**查询目标**：列出客户编号、公司名称和电话。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName, phone
FROM customers
ORDER BY customerNumber;
```

**语句解析**：客户编号用于识别记录，公司名称用于展示，phone 是联络号码。显式字段列表比 SELECT * 更适合报表。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | phone |
| --- | --- | --- |
| 103 | Atelier graphique | 40.32.2555 |
| 112 | Signal Gift Stores | 7025551838 |
| 114 | Australian Collectors, Co. | 03 9520 4555 |

**易错点**：phone 是字符串，不能转成数字，否则可能丢失加号、空格或前导零。

</details>

**继续练习**：补充联系人姓与名，比较公司名称和联系人姓名的用途。

### 第 03 题 查看员工岗位

**业务背景**：人事要核对现有组织中的员工和岗位。

**查询目标**：按员工编号列出姓、名和岗位。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT employeeNumber, lastName, firstName, jobTitle
FROM employees
ORDER BY employeeNumber;
```

**语句解析**：employees 保存员工资料，jobTitle 表示岗位。一个员工编号只对应一行员工记录。

**原始数据核对**：返回 **23 行**。以下为前 3 行；这是结果样例，不是完整结果。


| employeeNumber | lastName | firstName | jobTitle |
| --- | --- | --- | --- |
| 1002 | Murphy | Diane | President |
| 1056 | Patterson | Mary | VP Sales |
| 1076 | Firrelli | Jeff | VP Marketing |

**易错点**：销售客户数量不能从 employees 的行数推导。

</details>

**继续练习**：只保留负责销售的岗位，先查看实际岗位名称再写条件。

### 第 04 题 整理办公室分布

**业务背景**：行政部门要了解公司在不同城市的办公地点。

**查询目标**：列出办公室编号、城市、国家和区域。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT officeCode, city, country, territory
FROM offices
ORDER BY officeCode;
```

**语句解析**：officeCode 是办公室主键，city 和 country 是地点，territory 是数据里保存的业务区域代码。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。


| officeCode | city | country | territory |
| --- | --- | --- | --- |
| 1 | San Francisco | USA | NA |
| 2 | Boston | USA | NA |
| 3 | NYC | USA | NA |

**易错点**：不要按国家自行修正 territory；原数据中 Beijing 的 territory 为 NA，应保留并核查。

</details>

**继续练习**：筛选 territory 为 EMEA 的办公室。

### 第 05 题 查看产品线说明

**业务背景**：运营要编写分类导航，先获取每类产品的文字介绍。

**查询目标**：列出产品线及其纯文本说明。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productLine, textDescription
FROM productlines
ORDER BY productLine;
```

**语句解析**：productlines 中每行是一条产品线。textDescription 与 htmlDescription 是不同字段，前者可直接作为文字资料。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。

为控制篇幅，下面的 textDescription 仅显示前 95 个字符。SQL 本身返回完整说明。


| productLine | textDescription |
| --- | --- |
| Classic Cars | Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are lo… |
| Motorcycles | Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle leg… |
| Planes | Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, off… |

**易错点**：样本中 htmlDescription 和 image 全部为空，选择它们不会得到实际说明或图片。

</details>

**继续练习**：增加 CHAR_LENGTH(textDescription)，比较各分类说明的长度。

### 第 06 题 核对订单登记信息

**业务背景**：订单专员要查看所有已登记订单及其日期状态。

**查询目标**：展示订单号、下单日期、要求日期和状态。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT orderNumber, orderDate, requiredDate, status
FROM orders
ORDER BY orderNumber;
```

**语句解析**：orders 是订单头表，一个订单号对应一行；订单包含哪些产品存放在 orderdetails。

**原始数据核对**：返回 **326 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | orderDate | requiredDate | status |
| --- | --- | --- | --- |
| 10100 | 2013-01-06 | 2013-01-13 | Shipped |
| 10101 | 2013-01-09 | 2013-01-18 | Shipped |
| 10102 | 2013-01-10 | 2013-01-18 | Shipped |

**易错点**：订单头没有订单总额字段，不能假定存在 amount。

</details>

**继续练习**：增加 customerNumber，观察订单如何归属到客户。

### 第 07 题 查看付款流水

**业务背景**：财务需要按时间浏览收到的付款。

**查询目标**：列出付款客户、凭证号、日期和金额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
ORDER BY paymentDate, customerNumber, checkNumber;
```

**语句解析**：payments 的粒度是客户的一笔付款，复合主键为客户编号与凭证号。日期相同时用主键补充排序，结果可重复核对。

**原始数据核对**：返回 **273 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | checkNumber | paymentDate | amount |
| --- | --- | --- | --- |
| 363 | IS232033 | 2013-01-16 | 10223.83 |
| 128 | DI925118 | 2013-01-28 | 10549.01 |
| 181 | GQ132144 | 2013-01-30 | 5494.78 |

**易错点**：payments 没有 orderNumber，付款不能直接归属某一订单。

</details>

**继续练习**：改为按客户、日期排序，说明两种顺序分别适用于什么工作。

### 第 08 题 去重查看客户国家

**业务背景**：国际业务团队要列出已覆盖的国家，而不是重复显示每位客户。

**查询目标**：返回不同国家名称并排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT DISTINCT country
FROM customers
ORDER BY country;
```

**语句解析**：DISTINCT 对选中列组合去重。这里只有 country，因此一个国家最多出现一次。

**原始数据核对**：返回 **28 行**。以下为前 3 行；这是结果样例，不是完整结果。


| country |
| --- |
| Australia |
| Austria |
| Belgium |

**易错点**：同时选择 customerNumber 会使去重对象改变，无法得到国家清单。

</details>

**继续练习**：用 COUNT(DISTINCT country) 计算覆盖国家数量。

### 第 09 题 查看建议零售价最高的十个产品

**业务背景**：销售希望先展示高价产品。

**查询目标**：按 MSRP 降序选取十个产品，同价按代码排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName, MSRP
FROM products
ORDER BY MSRP DESC, productCode
LIMIT 10;
```

**语句解析**：DESC 表示降序；LIMIT 在排序后限制行数。productCode 用作同价时的稳定次序。

**原始数据核对**：返回 **10 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | MSRP |
| --- | --- | --- |
| S10_1949 | 1952 Alpine Renault 1300 | 214.30 |
| S12_1108 | 2001 Ferrari Enzo | 207.80 |
| S12_1099 | 1968 Ford Mustang | 194.57 |

**易错点**：这只是按建议价格选十个产品，不是按实际销售额选畅销品。

</details>

**继续练习**：改为查看最低价十个产品，并解释需要改变哪一处。

### 第 10 题 分页浏览客户

**业务背景**：后台每页展示十位客户，工作人员要打开第二页。

**查询目标**：按客户编号排序，跳过十行后取十行。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName
FROM customers
ORDER BY customerNumber
LIMIT 10 OFFSET 10;
```

**语句解析**：OFFSET 是跳过的行数，第一页从零开始。第二页的偏移量为 (2 - 1) × 10。

**原始数据核对**：返回 **10 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName |
| --- | --- |
| 141 | Euro+ Shopping Channel |
| 144 | Volvo Model Replicas, Co |
| 145 | Danish Wholesale Imports |

**易错点**：没有 ORDER BY 的分页会出现不稳定顺序；大量偏移也可能降低效率。

</details>

**继续练习**：写第三页，并讨论为何不能把 OFFSET 写成页码。

## 阶段二 条件筛选与表达式

### 第 11 题 筛选美国客户

**业务背景**：美国客服团队只处理本国客户。

**查询目标**：列出 country 为 USA 的客户。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName, city
FROM customers
WHERE country = 'USA'
ORDER BY customerNumber;
```

**语句解析**：WHERE 在结果输出前筛选记录。USA 必须按数据中的实际字符串填写。

**原始数据核对**：返回 **36 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | city |
| --- | --- | --- |
| 112 | Signal Gift Stores | Las Vegas |
| 124 | Mini Gifts Distributors Ltd. | San Rafael |
| 129 | Mini Wheels Co. | San Francisco |

**易错点**：不能把 USA 想当然写成 United States；先核对数据。

</details>

**继续练习**：加入城市条件，找出 USA 且 city 为 NYC 的客户。

### 第 12 题 筛选信用额度较高的客户

**业务背景**：销售经理按授信规模准备重点客户名单。

**查询目标**：选择信用额度至少 100000 的客户，并按额度降序排列。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName, creditLimit
FROM customers
WHERE creditLimit >= 100000
ORDER BY creditLimit DESC, customerNumber;
```

**语句解析**：creditLimit 是授信额度，比较时使用数值。>= 包含等于阈值的客户。

**原始数据核对**：返回 **25 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | creditLimit |
| --- | --- | --- |
| 141 | Euro+ Shopping Channel | 227600 |
| 124 | Mini Gifts Distributors Ltd. | 210500 |
| 298 | Vida Sport, Ltd | 141300 |

**易错点**：信用额度不是付款累计金额，也不是剩余可用额度。

</details>

**继续练习**：分别比较 > 和 >= 的业务含义。

### 第 13 题 筛选欧洲两国客户

**业务背景**：市场活动面向法国和德国客户。

**查询目标**：找出 France 或 Germany 的客户。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName, country
FROM customers
WHERE country IN ('France', 'Germany')
ORDER BY country, customerNumber;
```

**语句解析**：IN 表示与列表中的任一值匹配，等价于同字段多个 OR 条件。

**原始数据核对**：返回 **25 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | country |
| --- | --- | --- |
| 103 | Atelier graphique | France |
| 119 | La Rochelle Gifts | France |
| 146 | Saveley & Henriot, Co. | France |

**易错点**：IN 不是字符串包含搜索。

</details>

**继续练习**：再加入 UK，比较 IN 与三个 OR 条件的可读性。

### 第 14 题 筛选中等价格产品

**业务背景**：促销活动只考虑建议价 50 到 100 的产品。

**查询目标**：使用 BETWEEN 筛选 MSRP，并按价格、代码排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName, MSRP
FROM products
WHERE MSRP BETWEEN 50 AND 100
ORDER BY MSRP, productCode;
```

**语句解析**：BETWEEN 包含左右端点；本题等价于 MSRP >= 50 AND MSRP <= 100。

**原始数据核对**：返回 **51 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | MSRP |
| --- | --- | --- |
| S18_4668 | 1939 Cadillac Limousine | 50.31 |
| S24_1628 | 1966 Shelby Cobra 427 S/C | 50.31 |
| S18_1367 | 1936 Mercedes-Benz 500K Special Roadster | 53.91 |

**易错点**：不要把 BETWEEN 理解为开区间。

</details>

**继续练习**：改写成两个比较条件，并核对返回结果是否一致。

### 第 15 题 查询指定年度订单

**业务背景**：经营分析要研究 2014 年的下单情况。

**查询目标**：查询 2014 全年的订单，用日期区间表达范围。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT orderNumber, orderDate, status
FROM orders
WHERE orderDate >= '2014-01-01' AND orderDate < '2015-01-01'
ORDER BY orderDate, orderNumber;
```

**语句解析**：左闭右开区间能明确表示完整年度，也便于未来字段从 DATE 改成 DATETIME。条件直接作用于字段，便于利用日期索引。

**原始数据核对**：返回 **151 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | orderDate | status |
| --- | --- | --- |
| 10208 | 2014-01-02 | Shipped |
| 10209 | 2014-01-09 | Shipped |
| 10210 | 2014-01-12 | Shipped |

**易错点**：原始日期在 2013–2015 年，不能套用常见教学样本的 2003 年。

</details>

**继续练习**：改查 2014 年第三季度，写出起止边界。

### 第 16 题 检索名称含 Ferrari 的产品

**业务背景**：客户记得车型品牌，却不知道产品代码。

**查询目标**：使用 LIKE 搜索名称中包含 Ferrari 的产品。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName
FROM products
WHERE productName LIKE '%Ferrari%'
ORDER BY productCode;
```

**语句解析**：% 匹配任意长度的字符，前后都有 % 表示任意位置包含。

**原始数据核对**：返回 **2 行**。以下为前 2 行；这是结果样例，不是完整结果。


| productCode | productName |
| --- | --- |
| S12_1108 | 2001 Ferrari Enzo |
| S18_3232 | 1992 Ferrari 360 Spider red |

**易错点**：LIKE 的大小写行为受排序规则影响；包含搜索通常不易利用普通前缀索引。

</details>

**继续练习**：比较 Ferrari%、%Ferrari 与 %Ferrari% 的含义。

### 第 17 题 查找未记录发货日期的订单

**业务背景**：物流团队要核查还没有发货日期记录的订单。

**查询目标**：选择 shippedDate 为空的订单，保留状态供核查。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT orderNumber, orderDate, status, shippedDate
FROM orders
WHERE shippedDate IS NULL
ORDER BY orderNumber;
```

**语句解析**：NULL 表示未提供值，应使用 IS NULL。把状态一起显示，可区分处理中、暂停和取消等情况。

**原始数据核对**：返回 **14 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | orderDate | status | shippedDate |
| --- | --- | --- | --- |
| 10167 | 2013-10-23 | Cancelled | NULL |
| 10248 | 2014-05-07 | Cancelled | NULL |
| 10260 | 2014-06-16 | Cancelled | NULL |

**易错点**：shippedDate 为空不等于一定需要立即发货；Cancelled 等状态要另行判断。

</details>

**继续练习**：统计这些记录按 status 如何分布。

### 第 18 题 估算建议售价与进价的差额

**业务背景**：商品经理需要初步比较价格空间。

**查询目标**：计算 MSRP 减 buyPrice，以及相对 MSRP 的差额比例。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName,
       ROUND(MSRP - buyPrice, 2) AS suggested_spread,
       ROUND(100.0 * (MSRP - buyPrice) / NULLIF(MSRP, 0), 2) AS spread_pct
FROM products
ORDER BY suggested_spread DESC, productCode;
```

**语句解析**：AS 为计算列命名；NULLIF 防止分母为零。100.0 使百分比表达明确，ROUND 控制展示精度。

**原始数据核对**：返回 **110 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | suggested_spread | spread_pct |
| --- | --- | --- | --- |
| S10_1949 | 1952 Alpine Renault 1300 | 115.72 | 54.00 |
| S12_1108 | 2001 Ferrari Enzo | 112.21 | 54.00 |
| S10_4698 | 2003 Harley-Davidson Eagle Drag Bike | 102.64 | 53.00 |

**易错点**：这是按建议价与当前进价估计的空间，不是订单真实毛利，也没有运费税费。

</details>

**继续练习**：改以 buyPrice 作分母，解释加价率与毛利率为什么不同。

### 第 19 题 对演示编号进行自然排序

**业务背景**：演示表的 A-10 按字符串排序可能排在 A-2 前面，需要按后缀数字排序。

**查询目标**：取出 item_no 的数字后缀并转为整数排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT id, item_no
FROM items
ORDER BY CAST(SUBSTRING(item_no, 3, 255) AS SIGNED), id;
```

**语句解析**：本样本全部采用 A-数字格式，SUBSTRING 从第三个字符截取，CAST 转为整数。转型后 2 小于 10，符合编号直觉。

**原始数据核对**：返回 **9 行**。以下为前 3 行；这是结果样例，不是完整结果。


| id | item_no |
| --- | --- |
| 1 | A-1 |
| 2 | A-2 |
| 3 | A-3 |

**易错点**：这个表达式依赖当前编号格式；不能直接用于前缀长度不固定的编号。

</details>

**继续练习**：去掉 CAST 再排序，记录 A-10 和 A-2 的相对位置。

### 第 20 题 输出完整联系人姓名

**业务背景**：客服导出时希望把分开的姓名合成一个展示列，同时给缺失州信息一个提示。

**查询目标**：使用 CONCAT 和 COALESCE 输出联系人与州。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber,
       CONCAT(contactFirstName, ' ', contactLastName) AS contact_name,
       COALESCE(state, '未填写') AS state_display
FROM customers
ORDER BY customerNumber;
```

**语句解析**：CONCAT 将名、空格和姓拼接；COALESCE 返回第一个非 NULL 值。这里只改变展示，不修改原数据。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | contact_name | state_display |
| --- | --- | --- |
| 103 | Carine  Schmitt | 未填写 |
| 112 | Jean King | NV |
| 114 | Peter Ferguson | Victoria |

**易错点**：空字符串不等于 NULL，COALESCE 不会替换空字符串。

</details>

**继续练习**：改写为 COALESCE(NULLIF(state, ''), '未填写')，解释新增 NULLIF 的作用。

## 阶段三 聚合统计与分组筛选

### 第 21 题 统计客户总数

**业务背景**：经理需要知道客户主档规模。

**查询目标**：分别统计全部客户、已分配销售的客户和信用额度已填写的客户。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT COUNT(*) AS customer_count,
       COUNT(salesRepEmployeeNumber) AS assigned_count,
       COUNT(creditLimit) AS credit_recorded_count
FROM customers;
```

**语句解析**：COUNT(*) 统计行；COUNT(字段) 忽略 NULL。三个数反映不同数据口径。

**原始数据核对**：返回 **1 行**。以下为前 1 行；这是结果样例，不是完整结果。


| customer_count | assigned_count | credit_recorded_count |
| --- | --- | --- |
| 122 | 100 | 122 |

**易错点**：不能用 COUNT(salesRepEmployeeNumber) 代表客户总数。

</details>

**继续练习**：用总数减已分配数，核对未分配销售的客户数量。

### 第 22 题 按国家统计客户

**业务背景**：市场部按国家安排客户覆盖资源。

**查询目标**：每个国家返回客户数量，数量相同按国家名排序。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC, country;
```

**语句解析**：GROUP BY 将同国家客户归为一组，COUNT(*) 对组计数。结果粒度由客户变成国家。

**原始数据核对**：返回 **28 行**。以下为前 3 行；这是结果样例，不是完整结果。


| country | customer_count |
| --- | --- |
| USA | 36 |
| Germany | 13 |
| France | 12 |

**易错点**：不要选择未分组、未聚合的 customerName。

</details>

**继续练习**：增加 AVG(creditLimit)，讨论这是客户平均授信而非国家总收入。

### 第 23 题 统计产品线规模与库存

**业务背景**：采购想知道每条产品线的商品数和库存总量。

**查询目标**：按产品线统计产品数及 quantityInStock 合计。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productLine, COUNT(*) AS product_count,
       SUM(quantityInStock) AS stock_units
FROM products
GROUP BY productLine
ORDER BY productLine;
```

**语句解析**：COUNT(*) 统计不同产品记录数，SUM 统计库存件数。两种数量的单位不同。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productLine | product_count | stock_units |
| --- | --- | --- |
| Classic Cars | 38 | 219183 |
| Motorcycles | 13 | 69401 |
| Planes | 12 | 62287 |

**易错点**：库存是当前样本快照，不能推导历史库存变化。

</details>

**继续练习**：增加 MIN(quantityInStock) 和 MAX(quantityInStock)。

### 第 24 题 找出客户数至少五人的国家

**业务背景**：市场活动只覆盖客户基础达到阈值的国家。

**查询目标**：筛选客户数量不少于五的国家。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY customer_count DESC, country;
```

**语句解析**：HAVING 筛选分组后的统计值；WHERE 筛选分组前的原始行。

**原始数据核对**：返回 **6 行**。以下为前 3 行；这是结果样例，不是完整结果。


| country | customer_count |
| --- | --- |
| USA | 36 |
| Germany | 13 |
| France | 12 |

**易错点**：不能在 WHERE 中直接写 COUNT(*) >= 5。

</details>

**继续练习**：先用 WHERE 去掉 USA，再比较 HAVING 后结果的变化。

### 第 25 题 按状态统计订单

**业务背景**：运营经理要看订单处于哪些流程状态。

**查询目标**：统计每个状态的订单数量。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC, status;
```

**语句解析**：一个订单头只统计一次，状态值按原数据分组。状态是当前记录，不是状态变迁日志。

**原始数据核对**：返回 **6 行**。以下为前 3 行；这是结果样例，不是完整结果。


| status | order_count |
| --- | --- |
| Shipped | 303 |
| Cancelled | 6 |
| In Process | 6 |

**易错点**：不能从当前状态分布计算历史各阶段停留时间。

</details>

**继续练习**：计算每个状态占全部订单的百分比。

### 第 26 题 统计年度订单规模

**业务背景**：经营部门需要按年比较订单量。

**查询目标**：按 YEAR(orderDate) 汇总订单数。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT YEAR(orderDate) AS order_year, COUNT(*) AS order_count
FROM orders
GROUP BY YEAR(orderDate)
ORDER BY order_year;
```

**语句解析**：YEAR 提取年份，分组后每年一行。用于汇总是可读的；筛选单年时仍优先日期范围。

**原始数据核对**：返回 **3 行**。以下为前 3 行；这是结果样例，不是完整结果。


| order_year | order_count |
| --- | --- |
| 2013 | 111 |
| 2014 | 151 |
| 2015 | 64 |

**易错点**：2015 年样本只到 5 月，不能直接当完整年度与 2014 比增长。

</details>

**继续练习**：再展示各年 MIN(orderDate) 和 MAX(orderDate)，检验覆盖期。

### 第 27 题 统计客户累计付款

**业务背景**：财务要按客户核对已记录收款。

**查询目标**：返回每个付款客户的笔数和累计金额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, COUNT(*) AS payment_count,
       ROUND(SUM(amount), 2) AS paid_amount
FROM payments
GROUP BY customerNumber
ORDER BY paid_amount DESC, customerNumber;
```

**语句解析**：先按客户分组，再累加实际付款金额。未出现在 payments 的客户不会在本结果中出现。

**原始数据核对**：返回 **98 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | payment_count | paid_amount |
| --- | --- | --- |
| 141 | 13 | 715738.98 |
| 124 | 9 | 584188.24 |
| 114 | 4 | 180585.07 |

**易错点**：没有付款行不等于客户主档不存在，需要 LEFT JOIN 才能补齐全部客户。

</details>

**继续练习**：增加最早和最晚付款日期。

### 第 28 题 计算每张订单的明细金额

**业务背景**：订单表没有总额字段，业务报表需要由数量乘实际单价计算。

**查询目标**：每张订单汇总行数、订购件数和订单金额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT orderNumber, COUNT(*) AS line_count,
       SUM(quantityOrdered) AS total_units,
       ROUND(SUM(quantityOrdered * priceEach), 2) AS order_amount
FROM orderdetails
GROUP BY orderNumber
ORDER BY orderNumber;
```

**语句解析**：一行明细金额为数量 × priceEach；订单金额等于明细金额之和。COUNT(*) 是行数，SUM(quantityOrdered) 是件数。

**原始数据核对**：返回 **326 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | line_count | total_units | order_amount |
| --- | --- | --- | --- |
| 10100 | 4 | 151 | 10223.83 |
| 10101 | 4 | 142 | 10549.01 |
| 10102 | 2 | 80 | 5494.78 |

**易错点**：不要用 products.MSRP 或 buyPrice 代替成交单价。

</details>

**继续练习**：查询订单 10100 的逐行金额，再核对合计。

### 第 29 题 筛选平均成交单价较高的产品

**业务背景**：商品部门先做成交单价概览，找出平均行单价超过 100 的产品。

**查询目标**：按产品统计 AVG(priceEach) 与数量加权平均价，筛选前者超过 100。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode,
       ROUND(AVG(priceEach), 2) AS avg_line_price,
       ROUND(SUM(quantityOrdered * priceEach) * 1.0 / NULLIF(SUM(quantityOrdered), 0), 2) AS weighted_price
FROM orderdetails
GROUP BY productCode
HAVING AVG(priceEach) > 100
ORDER BY avg_line_price DESC, productCode;
```

**语句解析**：AVG 对每条明细单价等权平均；加权均价使用金额合计除件数合计。阈值作用于未四舍五入的平均数。

**原始数据核对**：返回 **40 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | avg_line_price | weighted_price |
| --- | --- | --- |
| S10_1949 | 197.31 | 197.73 |
| S12_1108 | 187.10 | 187.20 |
| S12_1099 | 172.45 | 173.13 |

**易错点**：如果两次成交数量不同，普通平均价不代表每件实际平均售价；本题含全部状态。

</details>

**继续练习**：只统计已发货订单，说明需要增加哪张表。

### 第 30 题 统计产品线的价格范围

**业务背景**：销售需要按分类了解价格层次。

**查询目标**：统计每条产品线建议价的最小值、最大值和平均值。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productLine, MIN(MSRP) AS min_msrp, MAX(MSRP) AS max_msrp,
       ROUND(AVG(MSRP), 2) AS avg_msrp
FROM products
GROUP BY productLine
ORDER BY productLine;
```

**语句解析**：MIN 和 MAX 得到组内极值，AVG 得到产品记录等权均值。每条产品线一行。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productLine | min_msrp | max_msrp | avg_msrp |
| --- | --- | --- | --- |
| Classic Cars | 35.36 | 214.30 | 118.02 |
| Motorcycles | 40.23 | 193.66 | 97.18 |
| Planes | 49.66 | 157.69 | 89.52 |

**易错点**：平均建议价不按销量加权，不是该产品线实际收入除销量。

</details>

**继续练习**：增加 MAX(MSRP) - MIN(MSRP) 观察价格跨度。

## 阶段四 多表关联与业务核对

### 第 31 题 把订单与客户名称关联

**业务背景**：订单专员只看到客户编号，希望在清单中显示公司名称。

**查询目标**：关联订单与客户，展示订单号、名称、日期和状态。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT o.orderNumber, c.customerName, o.orderDate, o.status
FROM orders AS o
JOIN customers AS c ON c.customerNumber = o.customerNumber
ORDER BY o.orderNumber;
```

**语句解析**：ON 指定订单外键与客户主键相等。每个订单有一个客户，因此正常情况下行数与订单数一致。

**原始数据核对**：返回 **326 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | customerName | orderDate | status |
| --- | --- | --- | --- |
| 10100 | Online Diecast Creations Co. | 2013-01-06 | Shipped |
| 10101 | Blauer See Auto, Co. | 2013-01-09 | Shipped |
| 10102 | Vitachrome Inc. | 2013-01-10 | Shipped |

**易错点**：漏写关联条件会产生笛卡尔积。

</details>

**继续练习**：再展示 c.country，并只查询 France 的订单。

### 第 32 题 查询员工办公地点

**业务背景**：人事要把员工与办公地点一起导出。

**查询目标**：关联 employees 与 offices，列出姓名、岗位和办公室城市。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS employee_name,
       e.jobTitle, o.officeCode, o.city, o.country
FROM employees AS e
JOIN offices AS o ON o.officeCode = e.officeCode
ORDER BY e.employeeNumber;
```

**语句解析**：officeCode 将员工关联到办公室。city 属于 offices，字段别名避免来源含糊。

**原始数据核对**：返回 **23 行**。以下为前 3 行；这是结果样例，不是完整结果。


| employeeNumber | employee_name | jobTitle | officeCode | city | country |
| --- | --- | --- | --- | --- | --- |
| 1002 | Diane Murphy | President | 1 | San Francisco | USA |
| 1056 | Mary Patterson | VP Sales | 1 | San Francisco | USA |
| 1076 | Jeff Firrelli | VP Marketing | 1 | San Francisco | USA |

**易错点**：客户城市不能替代员工办公室城市。

</details>

**继续练习**：统计每个办公室的员工数，确保零员工办公室也可显示。

### 第 33 题 显示每位员工的直属上级

**业务背景**：新员工希望知道汇报对象，最高负责人也要保留。

**查询目标**：对 employees 自连接，展示员工姓名和上级姓名。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS employee_name,
       m.employeeNumber AS manager_number,
       CONCAT(m.firstName, ' ', m.lastName) AS manager_name
FROM employees AS e
LEFT JOIN employees AS m ON m.employeeNumber = e.reportsTo
ORDER BY e.employeeNumber;
```

**语句解析**：同一张表使用 e 和 m 两个别名表示员工与经理。LEFT JOIN 保留 reportsTo 为空的最高负责人。

**原始数据核对**：返回 **23 行**。以下为前 3 行；这是结果样例，不是完整结果。


| employeeNumber | employee_name | manager_number | manager_name |
| --- | --- | --- | --- |
| 1002 | Diane Murphy | NULL | NULL |
| 1056 | Mary Patterson | 1002 | Diane Murphy |
| 1076 | Jeff Firrelli | 1002 | Diane Murphy |

**易错点**：INNER JOIN 会让没有上级的员工消失；CONCAT 任一参数为 NULL 时结果为 NULL。

</details>

**继续练习**：用 COALESCE 将空经理姓名显示为 最高负责人。

### 第 34 题 列出所有客户及销售负责人

**业务背景**：客户经理要检查分配情况，未分配客户不能漏掉。

**查询目标**：客户左连接员工，显示负责人，空值显示未分配。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName,
       COALESCE(CONCAT(e.firstName, ' ', e.lastName), '未分配') AS sales_rep
FROM customers AS c
LEFT JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
ORDER BY c.customerNumber;
```

**语句解析**：customers 是保留侧；没有负责人仍输出一行。COALESCE 只用于可读展示。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | sales_rep |
| --- | --- | --- |
| 103 | Atelier graphique | Gerard Hernandez |
| 112 | Signal Gift Stores | Leslie Thompson |
| 114 | Australian Collectors, Co. | Andy Fixter |

**易错点**：在 WHERE 中筛选 e.jobTitle 会排除空匹配客户，可能改变 LEFT JOIN 的意图。

</details>

**继续练习**：找出所有未分配客户，并核对是否有 22 行。

### 第 35 题 查看一张订单的产品明细

**业务背景**：客服处理订单 10100，需要读懂产品名称而非仅看代码。

**查询目标**：关联明细和产品，计算该订单每行金额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT d.orderLineNumber, d.productCode, p.productName,
       d.quantityOrdered, d.priceEach,
       ROUND(d.quantityOrdered * d.priceEach, 2) AS line_amount
FROM orderdetails AS d
JOIN products AS p ON p.productCode = d.productCode
WHERE d.orderNumber = 10100
ORDER BY d.orderLineNumber, d.productCode;
```

**语句解析**：产品表提供名称，明细表提供本次数量和价格。按行号排序用于还原订单展示。

**原始数据核对**：返回 **4 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderLineNumber | productCode | productName | quantityOrdered | priceEach | line_amount |
| --- | --- | --- | --- | --- | --- |
| 1 | S24_3969 | 1936 Mercedes Benz 500k Roadster | 49 | 35.29 | 1729.21 |
| 2 | S18_2248 | 1911 Ford Town Car | 50 | 55.09 | 2754.50 |
| 3 | S18_1749 | 1917 Grand Touring Sedan | 30 | 136 | 4080.00 |

**易错点**：复合主键是订单号与产品代码，不是订单号与行号。

</details>

**继续练习**：把各行 line_amount 相加，与第 28 题的订单金额核对。

### 第 36 题 汇总已发货订单的产品线金额

**业务背景**：经营分析只把状态为 Shipped 的订单纳入本练习销售口径。

**查询目标**：订单、明细与产品三表关联，按产品线汇总金额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT p.productLine,
       ROUND(SUM(d.quantityOrdered * d.priceEach), 2) AS shipped_sales
FROM orders AS o
JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
JOIN products AS p ON p.productCode = d.productCode
WHERE o.status = 'Shipped'
GROUP BY p.productLine
ORDER BY shipped_sales DESC, p.productLine;
```

**语句解析**：先筛选已发货订单，再按明细计价，最后按产品线分组。这个口径仅用于练习，并非完整收入确认政策。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productLine | shipped_sales |
| --- | --- |
| Classic Cars | 3623600.63 |
| Vintage Cars | 1643172.49 |
| Motorcycles | 1084927.13 |

**易错点**：若直接统计全部 orderdetails，会包含取消或处理中订单。

</details>

**继续练习**：比较按下单日期与发货日期归月时的区别。

### 第 37 题 统计全部客户的订单数

**业务背景**：客户经理希望看客户下单活跃度，也要列出零订单客户。

**查询目标**：客户左连接订单，统计每位客户的订单数。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS order_count
FROM customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY order_count DESC, c.customerNumber;
```

**语句解析**：COUNT(o.orderNumber) 忽略没有匹配订单时的 NULL。GROUP BY 同时列出输出的客户编号与名称。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | order_count |
| --- | --- | --- |
| 141 | Euro+ Shopping Channel | 26 |
| 124 | Mini Gifts Distributors Ltd. | 17 |
| 114 | Australian Collectors, Co. | 5 |

**易错点**：COUNT(*) 会把左连接产生的占位行算成一张订单。

</details>

**继续练习**：筛选订单数为零的客户，使用 HAVING。

### 第 38 题 查找从未下单的客户

**业务背景**：销售希望联系注册后还没有下单的客户。

**查询目标**：用 LEFT JOIN 与 IS NULL 查找无订单客户。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName
FROM customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
WHERE o.orderNumber IS NULL
ORDER BY c.customerNumber;
```

**语句解析**：无匹配行时，订单主键为空；实际订单主键不可为 NULL，因此可以作为可靠判定字段。

**原始数据核对**：返回 **24 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName |
| --- | --- |
| 125 | Havel & Zbyszek Co |
| 168 | American Souvenirs Inc |
| 169 | Porto Imports Co. |

**易错点**：不要用可能为空的 orders.comments 作为有无订单的判断。

</details>

**继续练习**：用 NOT EXISTS 改写并核对结果。

### 第 39 题 查找从未被订购的产品

**业务背景**：商品部要识别没有出现在任何订单明细中的产品。

**查询目标**：产品左连接明细，输出未匹配产品。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT p.productCode, p.productName
FROM products AS p
LEFT JOIN orderdetails AS d ON d.productCode = p.productCode
WHERE d.productCode IS NULL
ORDER BY p.productCode;
```

**语句解析**：以 products 为保留侧，检查明细中的产品代码是否为空。本题订购指所有状态订单中出现过。

**原始数据核对**：返回 **1 行**。以下为前 1 行；这是结果样例，不是完整结果。


| productCode | productName |
| --- | --- |
| S18_3233 | 1985 Toyota Supra |

**易错点**：从未订购不等于从未完成销售；若研究已发货销售，必须筛选状态。

</details>

**继续练习**：改查从未出现在 Shipped 订单中的产品。

### 第 40 题 核查超过要求日期的发货

**业务背景**：物流要找出已有发货日期且晚于客户要求日期的订单。

**查询目标**：比较 shippedDate 和 requiredDate，计算晚发天数。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT o.orderNumber, c.customerName, o.requiredDate, o.shippedDate,
       DATEDIFF(o.shippedDate, o.requiredDate) AS late_days
FROM orders AS o
JOIN customers AS c ON c.customerNumber = o.customerNumber
WHERE o.shippedDate > o.requiredDate
ORDER BY late_days DESC, o.orderNumber;
```

**语句解析**：DATE 字段可直接比较；DATEDIFF 的第一个日期减第二个日期。NULL 发货日期不会通过大于条件。

**原始数据核对**：返回 **1 行**。以下为前 1 行；这是结果样例，不是完整结果。


| orderNumber | customerName | requiredDate | shippedDate | late_days |
| --- | --- | --- | --- | --- |
| 10165 | Dragon Souveniers, Ltd. | 2013-10-31 | 2013-12-26 | 56 |

**易错点**：这里判定的是发货晚于要求日期，不是送达晚于承诺日期，库中没有送达日期。

</details>

**继续练习**：改为平均发货周期 DATEDIFF(shippedDate, orderDate)。

## 阶段五 子查询与综合汇总

### 第 41 题 查找进价高于全体平均的产品

**业务背景**：采购要关注成本高于商品平均水平的产品。

**查询目标**：通过标量子查询筛选 buyPrice 高于总体平均值的产品。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
ORDER BY buyPrice DESC, productCode;
```

**语句解析**：括号中的子查询返回一个平均值，外层每个产品与它比较。

**原始数据核对**：返回 **54 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | buyPrice |
| --- | --- | --- |
| S10_4962 | 1962 LanciaA Delta 16V | 103.42 |
| S18_2238 | 1998 Chrysler Plymouth Prowler | 101.51 |
| S10_1949 | 1952 Alpine Renault 1300 | 98.58 |

**易错点**：不要对外层产品逐行重新改变平均口径；这里比较的是全体产品均值。

</details>

**继续练习**：改为 MSRP 高于全体 MSRP 平均值。

### 第 42 题 查找高于所属产品线平均价的产品

**业务背景**：不同产品线价格差异大，商品经理希望做分类内比较。

**查询目标**：使用相关子查询比较产品 MSRP 与本产品线平均值。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT p.productCode, p.productName, p.productLine, p.MSRP
FROM products AS p
WHERE p.MSRP > (
    SELECT AVG(p2.MSRP) FROM products AS p2
    WHERE p2.productLine = p.productLine
)
ORDER BY p.productLine, p.MSRP DESC, p.productCode;
```

**语句解析**：子查询引用外层 p.productLine，因此平均值随产品所属分类变化。

**原始数据核对**：返回 **56 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | productLine | MSRP |
| --- | --- | --- | --- |
| S10_1949 | 1952 Alpine Renault 1300 | Classic Cars | 214.30 |
| S12_1108 | 2001 Ferrari Enzo | Classic Cars | 207.80 |
| S12_1099 | 1968 Ford Mustang | Classic Cars | 194.57 |

**易错点**：漏掉 p2.productLine = p.productLine 会退化成总体平均。

</details>

**继续练习**：用产品线聚合表 JOIN 改写，并比较结果。

### 第 43 题 筛选有付款记录的客户

**业务背景**：客服准备向已有付款行为的客户发送回访信息。

**查询目标**：使用 EXISTS 判断客户是否至少有一笔付款。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName
FROM customers AS c
WHERE EXISTS (SELECT 1 FROM payments AS p WHERE p.customerNumber = c.customerNumber)
ORDER BY c.customerNumber;
```

**语句解析**：EXISTS 只关心子查询是否存在行，不要求返回实际金额。一个客户即使付款多次也只返回一次。

**原始数据核对**：返回 **98 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName |
| --- | --- |
| 103 | Atelier graphique |
| 112 | Signal Gift Stores |
| 114 | Australian Collectors, Co. |

**易错点**：直接 JOIN payments 会把多次付款客户重复显示，除非另行去重或分组。

</details>

**继续练习**：使用 NOT EXISTS 找出从未付款客户。

### 第 44 题 筛选没有付款的下单客户

**业务背景**：财务需要核查已有订单但没有任何付款记录的客户。

**查询目标**：同时满足有订单和没有付款两个存在性条件。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName
FROM customers AS c
WHERE EXISTS (SELECT 1 FROM orders AS o WHERE o.customerNumber = c.customerNumber)
  AND NOT EXISTS (SELECT 1 FROM payments AS p WHERE p.customerNumber = c.customerNumber)
ORDER BY c.customerNumber;
```

**语句解析**：两个子查询独立使用客户编号关联，分别判断订单与付款是否存在。

**原始数据核对**：返回 **0 行**。该样本没有满足条件的记录。空结果可以是正确答案，应先核对条件与原始数据，不要为了获得结果而擅自改变题意。

**易错点**：没有付款记录不能直接判定违约；还要核对订单状态、账期和收款完整性。

</details>

**继续练习**：只把 Shipped 订单计入有订单条件。

### 第 45 题 查找从未订购摩托车产品的客户

**业务背景**：营销希望寻找尚未购买摩托车品类的客户。

**查询目标**：用 NOT EXISTS 排除明细中出现 Motorcycles 的客户。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM orders AS o
    JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
    JOIN products AS p ON p.productCode = d.productCode
    WHERE o.customerNumber = c.customerNumber AND p.productLine = 'Motorcycles'
)
ORDER BY c.customerNumber;
```

**语句解析**：子查询完整连接客户订单、订单明细和产品分类，再判断指定分类是否存在。

**原始数据核对**：返回 **67 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName |
| --- | --- |
| 112 | Signal Gift Stores |
| 125 | Havel & Zbyszek Co |
| 128 | Blauer See Auto, Co. |

**易错点**：本题也包含从未下单客户，不能自动解释为只买过其他分类的客户。

</details>

**继续练习**：增加有订单的 EXISTS，只保留已下过单但没订摩托车的客户。

### 第 46 题 找出金额高于平均订单金额的订单

**业务背景**：运营要识别大额订单，平均值应该基于订单总额。

**查询目标**：先汇总订单，再与这些订单金额的平均值比较。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH order_totals AS (
    SELECT orderNumber, SUM(quantityOrdered * priceEach) AS order_amount
    FROM orderdetails GROUP BY orderNumber
)
SELECT orderNumber, ROUND(order_amount, 2) AS order_amount
FROM order_totals
WHERE order_amount > (SELECT AVG(order_amount) FROM order_totals)
ORDER BY order_amount DESC, orderNumber;
```

**语句解析**：CTE 将订单粒度的聚合命名，后面可重复使用。平均的是订单金额，不是明细行金额。

**原始数据核对**：返回 **168 行**。以下为前 3 行；这是结果样例，不是完整结果。


| orderNumber | order_amount |
| --- | --- |
| 10165 | 67392.85 |
| 10287 | 61402.00 |
| 10310 | 61234.67 |

**易错点**：直接 AVG(quantityOrdered * priceEach) 得到平均行金额，会改变问题。

</details>

**继续练习**：只在 Shipped 订单集合内求平均并筛选。

### 第 47 题 找出每位客户最大的订单

**业务背景**：客户经理需要查看客户最重要的一笔订单，同金额订单全部保留。

**查询目标**：先汇总订单金额，再与同客户最大金额比较。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH order_totals AS (
    SELECT o.customerNumber, o.orderNumber,
           SUM(d.quantityOrdered * d.priceEach) AS order_amount
    FROM orders AS o JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
    GROUP BY o.customerNumber, o.orderNumber
)
SELECT t.customerNumber, t.orderNumber, ROUND(t.order_amount, 2) AS order_amount
FROM order_totals AS t
WHERE t.order_amount = (
    SELECT MAX(t2.order_amount) FROM order_totals AS t2
    WHERE t2.customerNumber = t.customerNumber
)
ORDER BY t.customerNumber, t.orderNumber;
```

**语句解析**：相关子查询求每位客户的最高订单金额，等于最大值的所有订单都会保留。

**原始数据核对**：返回 **98 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | orderNumber | order_amount |
| --- | --- | --- |
| 103 | 10123 | 14571.44 |
| 112 | 10278 | 33347.88 |
| 114 | 10120 | 45864.03 |

**易错点**：LIMIT 1 不能在整份查询中代表每个客户各取一单。

</details>

**继续练习**：用 DENSE_RANK 改写，保持并列结果不丢失。

### 第 48 题 查看已发货销售额最高的十位客户

**业务背景**：经营部门按已发货金额确定重点客户。

**查询目标**：按客户累计 Shipped 订单金额，取前十。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName,
       ROUND(SUM(d.quantityOrdered * d.priceEach), 2) AS shipped_sales
FROM customers AS c
JOIN orders AS o ON o.customerNumber = c.customerNumber
JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerNumber, c.customerName
ORDER BY shipped_sales DESC, c.customerNumber
LIMIT 10;
```

**语句解析**：客户、订单、明细连接后，每条明细归到所属客户；先过滤状态再汇总。

**原始数据核对**：返回 **10 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | shipped_sales |
| --- | --- | --- |
| 141 | Euro+ Shopping Channel | 668770.46 |
| 124 | Mini Gifts Distributors Ltd. | 584188.24 |
| 114 | Australian Collectors, Co. | 180585.07 |

**易错点**：排序前不能 LIMIT 明细，否则金额会不完整；此题按十行取，不保留第十名全部并列。

</details>

**继续练习**：改为前十个金额名次并保留并列客户。

### 第 49 题 比较客户订单金额与付款合计

**业务背景**：财务要做客户层面的金额概览，两种明细需分别汇总以避免倍增。

**查询目标**：显示所有客户的订单总额、付款总额及两者差额。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH sales AS (
    SELECT o.customerNumber, SUM(d.quantityOrdered * d.priceEach) AS ordered_amount
    FROM orders AS o JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
    GROUP BY o.customerNumber
), paid AS (
    SELECT customerNumber, SUM(amount) AS paid_amount
    FROM payments GROUP BY customerNumber
)
SELECT c.customerNumber, c.customerName,
       ROUND(COALESCE(s.ordered_amount, 0), 2) AS ordered_amount,
       ROUND(COALESCE(p.paid_amount, 0), 2) AS paid_amount,
       ROUND(COALESCE(s.ordered_amount, 0) - COALESCE(p.paid_amount, 0), 2) AS amount_gap
FROM customers AS c
LEFT JOIN sales AS s ON s.customerNumber = c.customerNumber
LEFT JOIN paid AS p ON p.customerNumber = c.customerNumber
ORDER BY c.customerNumber;
```

**语句解析**：两个 CTE 先统一到客户粒度，再各关联一次。COALESCE 补零，保留无订单或无付款的客户。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | ordered_amount | paid_amount | amount_gap |
| --- | --- | --- | --- | --- |
| 103 | Atelier graphique | 22314.36 | 22314.36 | 0.00 |
| 112 | Signal Gift Stores | 80180.98 | 80180.98 | 0.00 |
| 114 | Australian Collectors, Co. | 180585.07 | 180585.07 | 0.00 |

**易错点**：直接把订单明细和付款明细同时 JOIN 会出现多对多倍增；差额不是会计应收余额，未处理取消、税费、退款或付款分配。

</details>

**继续练习**：用客户 103 对比错误 JOIN 与本题结果，解释重复路径。

### 第 50 题 查找订购全部产品线的客户

**业务背景**：客户研究希望找到品类覆盖最广的客户。

**查询目标**：统计客户订购过的不同产品线数，与产品线主表总数比较。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT c.customerNumber, c.customerName,
       COUNT(DISTINCT p.productLine) AS line_count
FROM customers AS c
JOIN orders AS o ON o.customerNumber = c.customerNumber
JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
JOIN products AS p ON p.productCode = d.productCode
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT p.productLine) = (SELECT COUNT(*) FROM productlines)
ORDER BY c.customerNumber;
```

**语句解析**：DISTINCT 使同分类多次订购只计一次，产品线总数从主表获取，避免写死为七。

**原始数据核对**：返回 **4 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | line_count |
| --- | --- | --- |
| 131 | Land of Toys Inc. | 7 |
| 141 | Euro+ Shopping Channel | 7 |
| 353 | Reims Collectables | 7 |

**易错点**：若将订购定义为已完成销售，需要加 Shipped 条件；本题使用全部订单。

</details>

**继续练习**：将条件改为至少四个不同产品线。

## 阶段六 窗口函数与递归分析

### 第 51 题 按授信额度生成客户排名

**业务背景**：经理要查看授信排名，并比较并列时三种排名函数的效果。

**查询目标**：同时输出 ROW_NUMBER、RANK、DENSE_RANK。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, customerName, creditLimit,
       ROW_NUMBER() OVER (ORDER BY creditLimit DESC, customerNumber) AS row_no,
       RANK() OVER (ORDER BY creditLimit DESC) AS credit_rank,
       DENSE_RANK() OVER (ORDER BY creditLimit DESC) AS dense_credit_rank
FROM customers
ORDER BY creditLimit DESC, customerNumber;
```

**语句解析**：ROW_NUMBER 每行唯一；RANK 并列后跳号；DENSE_RANK 并列后不跳号。后两者只按额度决定并列，展示顺序另加客户编号。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | creditLimit | row_no | credit_rank | dense_credit_rank |
| --- | --- | --- | --- | --- | --- |
| 141 | Euro+ Shopping Channel | 227600 | 1 | 1 | 1 |
| 124 | Mini Gifts Distributors Ltd. | 210500 | 2 | 2 | 2 |
| 298 | Vida Sport, Ltd | 141300 | 3 | 3 | 3 |

**易错点**：把 customerNumber 加进 RANK 的窗口排序会打破额度相同的并列。

</details>

**继续练习**：筛选 dense_credit_rank <= 3，需要外层查询或 CTE。

### 第 52 题 选取每条产品线最贵的三个产品

**业务背景**：分类页面需要每类展示最多三个商品，严格控制行数。

**查询目标**：使用 ROW_NUMBER 按产品线分区，选每组前三行。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH ranked AS (
    SELECT productCode, productName, productLine, MSRP,
           ROW_NUMBER() OVER (PARTITION BY productLine ORDER BY MSRP DESC, productCode) AS rn
    FROM products
)
SELECT productCode, productName, productLine, MSRP, rn
FROM ranked WHERE rn <= 3
ORDER BY productLine, rn;
```

**语句解析**：PARTITION BY 将产品线分开排名；代码处理同价稳定次序；外层 WHERE 对窗口结果筛选。

**原始数据核对**：返回 **21 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productCode | productName | productLine | MSRP | rn |
| --- | --- | --- | --- | --- |
| S10_1949 | 1952 Alpine Renault 1300 | Classic Cars | 214.30 | 1 |
| S12_1108 | 2001 Ferrari Enzo | Classic Cars | 207.80 | 2 |
| S12_1099 | 1968 Ford Mustang | Classic Cars | 194.57 | 3 |

**易错点**：同一层 WHERE 中不能直接使用窗口函数或其别名。

</details>

**继续练习**：改成 DENSE_RANK 只按 MSRP 排名，比较并列时行数是否超过三。

### 第 53 题 查询每位客户最近的一张订单

**业务背景**：客服打开客户列表时只想附最近订单，日期并列取订单号较大者。

**查询目标**：窗口分组排名后每位客户取 rn 等于一。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH recent AS (
    SELECT customerNumber, orderNumber, orderDate, status,
           ROW_NUMBER() OVER (PARTITION BY customerNumber ORDER BY orderDate DESC, orderNumber DESC) AS rn
    FROM orders
)
SELECT customerNumber, orderNumber, orderDate, status
FROM recent WHERE rn = 1
ORDER BY customerNumber;
```

**语句解析**：窗口以客户分组，日期降序定位最近一单，订单号作同日决胜规则。

**原始数据核对**：返回 **98 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | orderNumber | orderDate | status |
| --- | --- | --- | --- |
| 103 | 10345 | 2014-11-25 | Shipped |
| 112 | 10346 | 2014-11-29 | Shipped |
| 114 | 10347 | 2014-11-29 | Shipped |

**易错点**：MAX(orderDate) 与 MAX(orderNumber) 独立聚合可能来自不同记录。

</details>

**继续练习**：增加无订单客户，思考 recent.rn = 1 应放在 ON 还是 WHERE。

### 第 54 题 计算每位客户的下单间隔

**业务背景**：客户运营希望知道复购订单之间相隔多久。

**查询目标**：LAG 获取同客户上张订单日期，再计算间隔天数。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH timeline AS (
    SELECT customerNumber, orderNumber, orderDate,
           LAG(orderDate) OVER (PARTITION BY customerNumber ORDER BY orderDate, orderNumber) AS previous_date
    FROM orders
)
SELECT customerNumber, orderNumber, orderDate, previous_date,
       DATEDIFF(orderDate, previous_date) AS gap_days
FROM timeline
ORDER BY customerNumber, orderDate, orderNumber;
```

**语句解析**：LAG 取得当前排序中上一行的值；第一张订单没有上一行，因此间隔为 NULL。同日两单间隔为零。

**原始数据核对**：返回 **326 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | orderNumber | orderDate | previous_date | gap_days |
| --- | --- | --- | --- | --- |
| 103 | 10123 | 2013-05-20 | NULL | NULL |
| 103 | 10298 | 2014-09-27 | 2013-05-20 | 495 |
| 103 | 10345 | 2014-11-25 | 2014-09-27 | 59 |

**易错点**：NULL 不表示零天；不能把首次下单当作当天复购。

</details>

**继续练习**：只统计非空 gap_days 的客户平均下单间隔。

### 第 55 题 计算每位客户累计付款

**业务背景**：财务要沿时间看到付款如何累计。

**查询目标**：按客户分区，使用显式 ROWS 窗口累计 amount。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT customerNumber, checkNumber, paymentDate, amount,
       ROUND(SUM(amount) OVER (
           PARTITION BY customerNumber ORDER BY paymentDate, checkNumber
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2) AS cumulative_paid
FROM payments
ORDER BY customerNumber, paymentDate, checkNumber;
```

**语句解析**：窗口从分区首行到当前行累加，每一笔付款仍保留。凭证号保证同日付款顺序稳定。

**原始数据核对**：返回 **273 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | checkNumber | paymentDate | amount | cumulative_paid |
| --- | --- | --- | --- | --- |
| 103 | JM555205 | 2013-06-05 | 14571.44 | 14571.44 |
| 103 | HQ336336 | 2014-10-19 | 6066.78 | 20638.22 |
| 103 | OM314933 | 2014-12-18 | 1676.14 | 22314.36 |

**易错点**：省略窗口边界可能采用 RANGE 的同值扩展行为，和逐笔累计不同。

</details>

**继续练习**：把每位客户最后一笔累计值与第 27 题汇总核对。

### 第 56 题 比较逐月已发货订单金额

**业务背景**：经营分析需要看月度变化，口径按下单月份归属。

**查询目标**：先汇总月销售，再 LAG 比较上月金额并计算变化率。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH monthly AS (
    SELECT DATE_FORMAT(o.orderDate, '%Y-%m') AS order_month,
           SUM(d.quantityOrdered * d.priceEach) AS sales
    FROM orders AS o JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
    WHERE o.status = 'Shipped'
    GROUP BY DATE_FORMAT(o.orderDate, '%Y-%m')
), compared AS (
    SELECT order_month, sales, LAG(sales) OVER (ORDER BY order_month) AS previous_sales
    FROM monthly
)
SELECT order_month, ROUND(sales, 2) AS sales,
       ROUND(previous_sales, 2) AS previous_sales,
       ROUND(100.0 * (sales - previous_sales) / NULLIF(previous_sales, 0), 2) AS change_pct
FROM compared ORDER BY order_month;
```

**语句解析**：先把明细汇总为月份，再对月结果做窗口计算。首月没有前值，变化率为 NULL；分母为零也返回 NULL。

**原始数据核对**：返回 **29 行**。以下为前 3 行；这是结果样例，不是完整结果。


| order_month | sales | previous_sales | change_pct |
| --- | --- | --- | --- |
| 2013-01 | 116692.77 | NULL | NULL |
| 2013-02 | 128403.64 | 116692.77 | 10.04 |
| 2013-03 | 160517.14 | 128403.64 | 25.01 |

**易错点**：LAG 取上一条记录，不自动补缺失月份。本样本月份连续，但扩展数据应先补日历；2015-05 是样本截尾月，比较需核查完整度。

</details>

**继续练习**：补齐日历并把无订单月份显示为零，再计算月份变化。

### 第 57 题 估算已发货商品成本与差额

**业务背景**：商品经理要按产品线估算价格与当前进价的差额。

**查询目标**：按已发货明细计算金额、当前进价估算成本和差额比例。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
SELECT p.productLine,
       ROUND(SUM(d.quantityOrdered * d.priceEach), 2) AS sales,
       ROUND(SUM(d.quantityOrdered * p.buyPrice), 2) AS estimated_cost,
       ROUND(SUM(d.quantityOrdered * (d.priceEach - p.buyPrice)), 2) AS estimated_spread,
       ROUND(100.0 * SUM(d.quantityOrdered * (d.priceEach - p.buyPrice)) /
             NULLIF(SUM(d.quantityOrdered * d.priceEach), 0), 2) AS spread_pct
FROM orders AS o
JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
JOIN products AS p ON p.productCode = d.productCode
WHERE o.status = 'Shipped'
GROUP BY p.productLine
ORDER BY estimated_spread DESC, p.productLine;
```

**语句解析**：金额按成交单价，成本按当前 products.buyPrice 乘数量，差额率按产品线总额计算。

**原始数据核对**：返回 **7 行**。以下为前 3 行；这是结果样例，不是完整结果。


| productLine | sales | estimated_cost | estimated_spread | spread_pct |
| --- | --- | --- | --- | --- |
| Classic Cars | 3623600.63 | 2187961.01 | 1435639.62 | 39.62 |
| Vintage Cars | 1643172.49 | 969878.76 | 673293.73 | 40.98 |
| Motorcycles | 1084927.13 | 630063.16 | 454863.97 | 41.93 |

**易错点**：缺少历史成本和费用，本题只能称估算差额，不能报告为会计真实毛利；不能平均逐行百分比代替总体比率。

</details>

**继续练习**：按供应商汇总同一组指标。

### 第 58 题 递归生成员工组织层级

**业务背景**：人事需要从最高负责人向下查看全部汇报层级。

**查询目标**：递归 CTE 从 reportsTo 为空的员工开始，逐层找到下属。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH RECURSIVE org AS (
    SELECT employeeNumber, firstName, lastName, reportsTo, 0 AS depth
    FROM employees WHERE reportsTo IS NULL
    UNION ALL
    SELECT e.employeeNumber, e.firstName, e.lastName, e.reportsTo, org.depth + 1
    FROM employees AS e JOIN org ON e.reportsTo = org.employeeNumber
    WHERE org.depth < 20
)
SELECT employeeNumber, CONCAT(firstName, ' ', lastName) AS employee_name,
       reportsTo, depth
FROM org ORDER BY depth, employeeNumber;
```

**语句解析**：锚点查询找根节点；UNION ALL 后递归部分把当前员工当经理寻找下一层下属。根深度为零，深度上限防止无限展开。

**原始数据核对**：返回 **23 行**。以下为前 3 行；这是结果样例，不是完整结果。


| employeeNumber | employee_name | reportsTo | depth |
| --- | --- | --- | --- |
| 1002 | Diane Murphy | NULL | 0 |
| 1056 | Mary Patterson | 1002 | 1 |
| 1076 | Jeff Firrelli | 1002 | 1 |

**易错点**：外键只证明上级存在，不保证无环；深度限制可能截断结果，不能替代环检测。

</details>

**继续练习**：比较结果行数与 employees 总数，解释少行时应检查什么。

### 第 59 题 把演示字符串逐字符展开

**业务背景**：字符串处理课程需要把 abcdef 变成按位置排列的字符行。

**查询目标**：递归生成位置，再从 tokens.s 提取每个字符。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH RECURSIVE positions AS (
    SELECT 1 AS pos
    UNION ALL
    SELECT pos + 1 FROM positions
    WHERE pos < (SELECT COALESCE(MAX(CHAR_LENGTH(s)), 0) FROM tokens)
)
SELECT t.s, n.pos, SUBSTRING(t.s, n.pos, 1) AS character_value
FROM tokens AS t JOIN positions AS n ON n.pos <= CHAR_LENGTH(t.s)
ORDER BY t.s, n.pos;
```

**语句解析**：位置序列长度来自实际字符串长度，SUBSTRING 使用从一开始的位置。当前 tokens 只有 abcdef 一行。

**原始数据核对**：返回 **6 行**。以下为前 3 行；这是结果样例，不是完整结果。


| s | pos | character_value |
| --- | --- | --- |
| abcdef | 1 | a |
| abcdef | 2 | b |
| abcdef | 3 | c |

**易错点**：tokens 没有主键；扩展到重复字符串时，结果可能完全重复，不能假定 s 唯一。

</details>

**继续练习**：讨论 CHAR_LENGTH 与 LENGTH 处理中文字符时为何可能不同。

### 第 60 题 建立客户活跃度与价值概览

**业务背景**：客户经理在历史样本截止后的固定日期做分析，准备确定回访对象。

**查询目标**：以 2015-06-10 为基准，按已发货订单计算最近下单、订单数和金额，并加入付款合计。

<details>
<summary>展开参考 SQL 与解析</summary>

```sql
WITH shipped AS (
    SELECT o.customerNumber, MAX(o.orderDate) AS last_order_date,
           COUNT(DISTINCT o.orderNumber) AS order_count,
           SUM(d.quantityOrdered * d.priceEach) AS sales
    FROM orders AS o JOIN orderdetails AS d ON d.orderNumber = o.orderNumber
    WHERE o.status = 'Shipped' AND o.orderDate <= '2015-06-10'
    GROUP BY o.customerNumber
), paid AS (
    SELECT customerNumber, SUM(amount) AS paid_amount
    FROM payments WHERE paymentDate <= '2015-06-10'
    GROUP BY customerNumber
)
SELECT c.customerNumber, c.customerName, s.last_order_date,
       DATEDIFF('2015-06-10', s.last_order_date) AS days_since_last_order,
       COALESCE(s.order_count, 0) AS shipped_order_count,
       ROUND(COALESCE(s.sales, 0), 2) AS shipped_sales,
       ROUND(COALESCE(p.paid_amount, 0), 2) AS paid_amount,
       CASE WHEN s.customerNumber IS NULL THEN '无已发货订单'
            WHEN DATEDIFF('2015-06-10', s.last_order_date) > 180 THEN '超过180天未下单'
            ELSE '180天内有下单' END AS activity_label
FROM customers AS c
LEFT JOIN shipped AS s ON s.customerNumber = c.customerNumber
LEFT JOIN paid AS p ON p.customerNumber = c.customerNumber
ORDER BY shipped_sales DESC, c.customerNumber;
```

**语句解析**：shipped 和 paid 分别汇总到客户粒度，防止金额倍增。连接明细后用 COUNT(DISTINCT orderNumber) 计订单；固定日期保证历史练习可复现。CASE 先处理没有已发货订单的客户，再按 180 天阈值分类。

**原始数据核对**：返回 **122 行**。以下为前 3 行；这是结果样例，不是完整结果。


| customerNumber | customerName | last_order_date | days_since_last_order | shipped_order_count | shipped_sales | paid_amount | activity_label |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 141 | Euro+ Shopping Channel | 2015-05-03 | 38 | 22 | 668770.46 | 715738.98 | 180天内有下单 |
| 124 | Mini Gifts Distributors Ltd. | 2015-03-23 | 79 | 16 | 584188.24 | 584188.24 | 180天内有下单 |
| 114 | Australian Collectors, Co. | 2014-11-29 | 193 | 5 | 180585.07 | 180585.07 | 超过180天未下单 |

**易错点**：不要用今天日期解释旧样本活跃度；未下单不等于永久流失，付款也未分配至已发货订单。此报表包含 RFM 基础指标，但没有打分模型。

</details>

**继续练习**：给出合理分层阈值，增加客户国家和销售负责人，并说明业务依据。

## 七 教师核对与课堂建议

### 1 核对用基准查询

以下查询可确认导入数量。它们是环境检查，不计入上述 60 道正式题目：

```sql
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'offices', COUNT(*) FROM offices
UNION ALL SELECT 'productlines', COUNT(*) FROM productlines
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'orderdetails', COUNT(*) FROM orderdetails
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'items', COUNT(*) FROM items
UNION ALL SELECT 'tokens', COUNT(*) FROM tokens;
```

使用原始字符串与 Python Decimal 独立累计得到：全部订单明细金额 **9,604,190.61**，全部付款金额 **8,853,839.23**。这两个数属于不同业务集合，不应据其差值判断欠款。可以在 MySQL 中用下面语句复核精确金额：

```sql
SELECT SUM(quantityOrdered * priceEach) AS all_order_amount FROM orderdetails;
SELECT SUM(amount) AS all_paid_amount FROM payments;
```

### 2 建议课时与评分

每阶段可安排一次课内练习与一次讲评。先选五道讲解，再让学生独立完成余题；每题的继续练习可用于分层作业。建议每题按“理解业务与粒度 20%、SQL 正确性 50%、结果核对 20%、解释与边界 10%”评分，不要求与参考 SQL 完全相同。

有效的不同写法应满足同一字段范围、状态口径、并列处理和排序规则。例如 LEFT JOIN 的反连接与 NOT EXISTS 都可回答无订单客户，但不能用 COUNT(*) 错算零订单客户。高级题中，正确指出字段不足或业务口径限制应得到认可。

### 3 常见错误与纠正方向


| 错误 | 原因 | 纠正 |
| --- | --- | --- |
| NULL = NULL 或字段 = NULL | NULL 比较不返回普通真值 | 使用 IS NULL / IS NOT NULL |
| 左连接后 COUNT(*) 当订单数 | 无匹配也有占位行 | 统计右表非空主键 |
| 按国家分组还选客户名 | 一个组包含多个名称 | 聚合或调整结果粒度 |
| 订单与付款直接同时连接 | 同客户两侧多行相乘 | 分别聚合后关联 |
| 用 MSRP 求订单金额 | 建议价与成交价不同 | 数量 × orderdetails.priceEach |
| 所有历史数据配今天日期 | 会把旧样本全部判为很久未活跃 | 使用固定基准日 |
| LAG 自动认为上个自然月 | 实际是上一条排序记录 | 补完整日历再分析 |
| SELECT 窗口别名写进同层 WHERE | 窗口结果尚不可用 | 增加 CTE 或派生表 |
| 第 44 题返回零行就说 SQL 错 | 样本确实没有该组合 | 核对有订单客户是否均有付款 |
| 把估算差额称真实利润 | 没有历史成本与费用 | 明确估算口径与缺失字段 |

## 八 MySQL 官方参考

参考用于核对语法与引擎规则；业务字段和结果均以本次提供文件为依据。

- [MySQL 8.0 窗口函数说明](https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html)
- [MySQL 8.0 CTE 与递归查询](https://dev.mysql.com/doc/refman/8.0/en/with.html)
- [MySQL 8.0 外键约束及外键检查](https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html)

---

编写及数据核对日期：2026-10-11。查询参考答案保留英文列别名，便于复制运行与比对；业务说明采用中文。数据库实际名称始终为 `yiibaidb`。
