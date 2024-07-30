本文档是林肯老师为自己的学生准备的 SQL 集训营文档集合,里面包含了 SQL 的基础知识和常用操作,可以作为案头必备,也可以作为学习手册.真心希望大家都能通过该文档获取知识,薪水加加.

希望大家在兔年都能突突突,冒蓝光!加油!.

![phI6z3](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/phI6z3.png)

[TOC]

# SQL 的学习路径脑图和常用 SQL 语句

![SQL学习路径](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/SQL学习路径.jpg)

![1.基础查询](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/1.基础查询.jpg)

![2.字符串、数字、日期时间](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/2.字符串、数字、日期时间.jpg)

![3.聚合数据查询](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/3.聚合数据查询.jpg)

![4.子查询](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/4.子查询.jpg)

![5.联接、组合查询](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/5.联接、组合查询.jpg)

![6.高级查询](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/6.高级查询.jpg)

![7.更新数据](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/7.更新数据.jpg)



本笔记为阿里云天池龙珠计划 SQL 训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql

# Task00：为什么要学习 SQL

学习 SQL 的意义，就在于你学会以后，将掌握数据分析应聘中的 SQL 能力，并找到一份数据分析工作。

![xnM0p3](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/xnM0p3.png)

![SDrZI6](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/SDrZI6.png)

在数据分析的招聘中，SQL 是必考的能力之一。为什么公司要考察应聘者的 SQL 能力呢？

Excel 对十万条以内的数据处理起来没有问题，但是大数据时代从来就不缺数据，很多公司的数据都放在数据库中，这时候就需要学习操作数据库的语言 SQL。

如果你未来想成为数据分析师的你，就需要掌握以下内容：

* 1）会利用 SQL 操作开关系数据库 MySQL 进行查询
* 2）数据库的分组、聚合、排序
* 3）存储过程
* 4）对于增删改、约束、索引、数据库范式均大致了解即可，不需要深入

最常见的考 SQL 的方法给你一个虚拟的数据库表结构，然后让你按给出的条件查询出数据，并用手写的形式写出在纸上。所以面试前把常用的 SQL 语句记清楚就行了。


## 如何购买一个可以使用的云数据库.

通过[网址](https://www.aliyun.com/minisite/goods?userCode=orje4xat&share_source=copy_link) 注册阿里云.

1. 必须是新用户,新用户,新用户
2. 用一个跟之前你登录阿里云不一样的账户.
3. 完成实名认证.

![2JQMIa](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/2JQMIa.png)

也可以通过[链接](https://www.aliyun.com/database/dbfirstbuy)来注册.

本笔记为阿里云天池龙珠计划 SQL 训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql

# Task01：初识数据库与 SQL

[TOC]

本章主要对数据库进行基本介绍，考虑易用性及普及度，课程主要使用**MySQL**进行介绍。

SQL 训练营页面地址：[https://tianchi.aliyun.com/specials/promotion/aicampsql](https://tianchi.aliyun.com/specials/promotion/aicampsql?spm=5176.21852664.0.0.459e2e40OvggyN)  

天池龙珠计划训练营地址：https://tianchi.aliyun.com/specials/promotion/aicamps

## 一、初识数据库

数据库是将大量数据保存起来，通过计算机加工而成的可以 进行高效访问的数据集合。该数据集合称为数据库（Database，DB）。用来管理数据库的计算机系统称为数据库管理系统（Database Management System，DBMS）。

### 1.1 DBMS 的种类

DBMS 主要通过数据的保存格式（数据库的种类）来进行分类，现阶段主要有以下 5 种类型.

* 层次数据库（Hierarchical Database，HDB）
* 关系数据库（Relational Database，RDB）

  这种类型的 DBMS 称为关系数据库管理系统（Relational Database Management System，RDBMS）。比较具有代表性的 RDBMS 有如下 5 种。
    - Oracle Database：甲骨文公司的 RDBMS
    - SQL Server：微软公司的 RDBMS
    - DB2：IBM 公司的 RDBMS
    - PostgreSQL：开源的 RDBMS
    - MySQL：开源的 RDBMS
* 面向对象数据库（Object Oriented Database，OODB）
* XML 数据库（XML Database，XMLDB）
* 键值存储系统（Key-Value Store，KVS），举例：MongoDB

本课程将向大家介绍使用 SQL 语言的数据库管理系统，也就是关系数据库管理系统（RDBMS）的操作方法。

### 1.2 RDBMS 的常见系统结构

使用 RDBMS 时，最常见的系统结构就是客户端 / 服务器类型（C/S 类型）这种结构（如下图）

![tOR1Ku](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/tOR1Ku.jpg)

### 1.3 数据库安装（必须学习）

本次学习大家可以选择使用阿里云数据库服务器或者本地安装数据库进行学习，在下面对应的学习教程中也给告诉了大家如何创建本次学习需要的数据库表和数据，所以大家必须使用一个方式安装数据库，才能完成后面学习。

「Windows10 专业版下安装 Docker.pdf」，点击链接保存，或者复制本段内容，打开「阿里云盘」APP ，无需下载极速在线查看，视频原画倍速播放。
链接：https://www.aliyundrive.com/s/GFqQ8ETaA1E

#### 1.3.1 阿里云 MySQL 服务器使用介绍

节约篇幅，具体相关介绍以及给大家写到 pdf 里了，大家点击链接即可进入查看： 
 
[阿里云 MySQL 服务器使用介绍.pdf](http://tianchi-media.oss-cn-beijing.aliyuncs.com/dragonball/SQL/other/%E9%98%BF%E9%87%8C%E4%BA%91MySQL%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%BD%BF%E7%94%A8%E4%BB%8B%E7%BB%8D.pdf?spm=5176.21852664.0.0.459e2e40OvggyN&file=%E9%98%BF%E9%87%8C%E4%BA%91MySQL%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%BD%BF%E7%94%A8%E4%BB%8B%E7%BB%8D.pdf)  

**优点：**操作使用方便，未来趋势（数据上云），导入、导出数据方便，运行速度快。  
**缺点：**~~ 需要付费购买，不过现在对开发者有优惠活动，基础版本 1 核 1G，存储空间 20G 的，目前优惠价半年只需 9.9 元，一杯奶茶钱不到。~~ 2023 年 01 月 02 日这个优惠已经取消掉了.

#### 1.3.2 本地 MySQL 环境搭建方法介绍

节约篇幅，具体相关介绍以及给大家写到 pdf 里了，大家点击链接即可进入查看：  

[本地 MySQL 环境搭建方法介绍.pdf](http://tianchi-media.oss-cn-beijing.aliyuncs.com/dragonball/SQL/other/%E6%9C%AC%E5%9C%B0MySQL%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA%E6%96%B9%E6%B3%95%E4%BB%8B%E7%BB%8D.pdf)  

**优点：**免费，增强动手能力。  
**缺点：**安装、配置麻烦，数据导入、导出耗时长。

## 二、初识 SQL

### 2.1 概念介绍

#### 2.1.1 数据库基本概念

数据库是一个以某种有组织的方式存储的数据集合。数据库 (database) 是保存有组织的数据的容器。数据库管理系统 (DBMS) 是一种数据库软件，MySQL 是一种 DBMS，即它是一种数据库软件，作者使用的数据库管理系统是 MySQL，除做特别说明外，作者使用的所有数据库软件都为 MySQL。

![3FW1l8](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/3FW1l8.jpg)
表(table) 某种特定类型数据的结构化清单，是一种结构化的文件，可用来存储某种特定类型的数据。

模式(schema) 关于数据库和表的布局及特性的信息。

![KPAAYa](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/KPAAYa.jpg)

数据库中存储的表结构类似于 Excel 中的行和列，在数据库中，**行称为记录**，它相当于一条记录，**列称为字段**，它代表了表中存储的数据项目。

行和列交汇的地方称为**单元格**，一个单元格中只能输入一条记录。

![Ev8crF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Ev8crF.jpg)
主键 (primary key) 一列(或一组列)，其值能够唯一标识表中每一行。表中的任何列都可以作为主键，只要它满足以下条件：

* 任意两行都不具有相同的主键值;
* 每一行都必须具有一个主键值(主键列不允许 NULL 值);
* 主键列中的值不允许修改或更新;
* 主键值不能重用(如果某行从表中删除，它的主键不能赋给以后的新行)

![EtQKUx](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/EtQKUx.jpg)

#### 2.1.2 什么是 SQL

SQL 是结构化查询语言 (Structured Query Language) 的缩写。SQL 是为操作数据库而开发的语言。国际标准化组织（ISO）为 SQL 制定了相应的标准，以此为基准的 SQL 称为标准 SQL（相关信息请参考专栏——标准 SQL 和特定的 SQL）。

SQL 语句的优点

* SQL 不是某个特定数据库供应商专有的语言。几乎所有重要的 DBMS 都支持 SQL，所以，学习此语言使你几乎能与所有数据库打交道;
* SQL 简单易学。它的语句全都是由描述性很强的英语单词组成，而且这些单词的数目不多;
* SQL 尽管看上去很简单，但它实际上是一种强有力的语言，灵活使用其语言元素，可以进行非常复杂和高级的数据库操作。

完全基于标准 SQL 的 RDBMS 很少，通常需要根据不同的 RDBMS 来编写特定的 SQL 语句，原则上，本课程介绍的是标准 SQL 的书写方式。

根据对 RDBMS 赋予的指令种类的不同，SQL 语句可以分为以下三类.

* DDL

    DDL（Data Definition Language，数据定义语言） 用来创建或者删除存储数据用的数据库以及数据库中的表等对象。DDL 包含以下几种指令。

    * CREATE ： 创建数据库和表等对象
    
    * DROP ： 删除数据库和表等对象
    
    * ALTER ： 修改数据库和表等对象的结构

* DML

    DML（Data Manipulation Language，数据操纵语言） 用来查询或者变更表中的记录。DML 包含以下几种指令。

    * SELECT ：查询表中的数据
    
    * INSERT ：向表中插入新数据
    
    * UPDATE ：更新表中的数据
    
    * DELETE ：删除表中的数据

* DCL

    DCL（Data Control Language，数据控制语言） 用来确认或者取消对数据库中的数据进行的变更。除此之外，还可以对 RDBMS 的用户是否有权限操作数据库中的对象（数据库表等）进行设定。DCL 包含以下几种指令。

    * COMMIT ： 确认对数据库中的数据进行的变更
    
    * ROLLBACK ： 取消对数据库中的数据进行的变更
    
    * GRANT ： 赋予用户操作权限
    
    * REVOKE ： 取消用户的操作权限

实际使用的 SQL 语句当中有 90% 属于 DML，本课程会以 DML 为中心进行讲解。

#### 2.1.3 SQL 数据类型

数据类型 (datatype) 所容许的数据的类型。每个表列都有相应的数据类型，它限制(或容许) 该列中存储的数据，常见的数据类型有字符串、数值、日期和时间、二进制数据类型。

![lY9mQi](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/lY9mQi.jpg)
* 字符串数据类型


| 数据类型   | 说明                                                                                          |
|------------|-----------------------------------------------------------------------------------------------|
| CHAR       | 1～255 个字符的定长串。它的长度必须在创建时指定，否则 MySQL 假定为 CHAR（1）                           |
| ENUM       | 接受最多 64K 个串组成的一个预定义集合的某个串                                                    |
| LONGTEXT   | 与TEXT相同，但最大长度为 4 GB                                                                   |
| MEDIUMTEXT | 与TEXT相同，但最大长度为 16K                                                                    |
| SET        | 接受最多 64 个串组成的一个预定义集合的零个或多个串                                               |
| TEXT       | 最大长度为 64K 的变长文本                                                                       |
| TINYTEXT   | 与TEXT相同，但最大长度为 255 字节                                                                |
| VARCHAR    | 长度可变，最多不超过 255 字节。如果在创建时指定为VARCHAR（n），则可存储 0 到 n 个字符的变长串（其中n≤255） |


* 数值数据类型


| 数据类型        | 说明                                                                                              |
|-----------------|---------------------------------------------------------------------------------------------------|
| BIT             | 位字段，1～64位。（在MySQL5之前，BIT在功能上等价于 TINYINT)                                            |
| BIGINT          | 整数值，支持 -9223372036854775808～9223372036854775807（如果是UNSIGNED，为0～18446744073709551615）的数 |
| BOOLEAN（或BOOL） | 布尔标志，或者为0或者为1，主要用于开／关（on/off）标志                                                 |
| DECIMAL（或DEC）  | 精度可变的浮点值                                                                                  |
| DOUBLE          | 双精度浮点值                                                                                      |
| FLOAT           | 单精度浮点值                                                                                      |
| INT（或INTEGER）  | 整数值，支持－2147483648～2147483647（如果是UNSIGNED，为0～4294967295）的数                              |
| MEDIUMINT       | 整数值，支持－8388608～8388607（如果是UNSIGNED，为0～ 16777215）的数                                     |
| REAL            | 4字节的浮点值                                                                                     |
| SMALLINT        | 整数值，支持－32768～32767（如果是UNSIGNED，为0～65535）的数                                             |
| TINYINT         | 整数值，支持－128～127（如果为UNSIGNED，为0～255）的数                                                   |


* 日期和时间数据类型


| 数据类型  | 说 明                                                                       |
|-----------|-----------------------------------------------------------------------------|
| DATE      | 表示1000-01-01～9999-12-31的日期，格式为 YYYY-MM-DD                           |
| DATETIME  | DATE和TIME的组合                                                            |
| TIMESTAMP | 功能和DATETIME相同（但范围较小）                                              |
| TIME      | 格式为HH:MM:SS                                                              |
| YEAR      | 用2位数字表示，范围是70（1970年）～69（2069年），用4位数字表示，范围是1901年～2155年 |


* 二进制数据类型


| 数据类型   | 说 明                 |
|------------|-----------------------|
| BLOB       | Blob最大长度为64KB    |
| MEDIUMBLOB | Blob最大长度为16MB    |
| LONGBLOB   | Blob最大长度为4 GB    |
| TINYBLOB   | Blob最大长度为255字节 |
 

### 2.2 SQL 的基本书写规则

* SQL 语句要以分号 **;** 结尾
* SQL 不区分关键字的大小写，但是插入到表中的数据是区分大小写的
* Windows 系统默认不区分表名及字段名的大小写
* Linux / Mac 默认严格区分表名及字段名的大小写(其实有的时候也不区分，但是最好是按照一定的规则来书写)
* 本教程已统一调整表名及字段名的为小写，以方便初学者学习使用。
* 常数的书写方式是固定的

    'abc', 1234, '26 Jan 2010', '10/01/26', '2010-01-26'…

* 单词需要用半角空格或者换行来分隔

SQL 语句的单词之间需使用半角空格或换行符来进行分隔，且不能使用全角空格作为单词的分隔符，否则会发生错误，出现无法预期的结果。

请大家认真查阅《附录 1 - SQL 语法规范》，养成规范的书写习惯。

### 2.3 数据库的创建（ CREATE DATABASE 语句）

语法：

```sql
CREATE DATABASE < 数据库名称 > ;
```

创建本课程使用的数据库

```sql
CREATE DATABASE shop;
```

选择使用新创建的数据库

```sql
use shop;
```

一种更为专业和工程的做法：

**设置数据库编码**

```sql
CREATE DATABASE dbname DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

**设置数据表编码**

```sql
CREATE TABLE 'author' (
    'authorid' char(20) NOT NULL,
    'name' char(20) NOT NULL,
    'age' char(20) NOT NULL,
    'country' char(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
```

MySQL 中两种数据库引擎   
ENGINE = MyISAM   
ENGINE = InnoDB

### MySQL 存储引擎 MyISAM 与 InnoDB 如何选择？

虽然 MySQL 里的存储引擎不只是 MyISAM 与 InnoDB 这两个，但常用的就是它俩了。

下面我们分别来看两种存储引擎的区别。

* 一、InnoDB 支持事务，MyISAM 不支持，这一点是非常之重要。事务是一种高级的处理方式，如在一些列增删改中只要哪个出错还可以回滚还原，而 MyISAM 就不可以了。
* 二、MyISAM 适合查询以及插入为主的应用，InnoDB 适合频繁修改以及涉及到安全性较高的应用
* 三、InnoDB 支持外键，MyISAM 不支持
* 四、MySQL 在 5.1 之前版本默认存储引擎是 MyISAM，5.1 之后版本默认存储引擎是 InnoDB
* 五、InnoDB 不支持 FULLTEXT 类型的索引
* 六、InnoDB 中不保存表的行数，如 `select count(*) from table` 时，InnoDB 需要扫描一遍整个表来计算有多少行，但是 MyISAM 只要简单的读出保存好的行数即可。注意的是，当 count(*)语句包含 where 条件时 MyISAM 也需要扫描整个表
* 七、对于自增长的字段，InnoDB 中必须包含只有该字段的索引，但是在 MyISAM 表中可以和其他字段一起建立联合索引
* 八、清空整个表时，InnoDB 是一行一行的删除，效率非常慢。MyISAM 则会重建表
* 九、InnoDB 支持行锁（某些情况下还是锁整表，如 `update table set a=1 where user like '%lee%'`)

### 2.4 表的创建（ CREATE TABLE 语句）

语法：

```sql
CREATE TABLE < 表名 >( 
    < 列名 1> < 数据类型 > < 该列所需约束 > ,
    < 列名 2> < 数据类型 > < 该列所需约束 > ,
    < 列名 3> < 数据类型 > < 该列所需约束 > ,
    < 列名 4> < 数据类型 > < 该列所需约束 > ,
    .
    .
    .
    < 该表的约束 1> , < 该表的约束 2> ,……);
```

创建本课程用到的商品表

```sql
CREATE TABLE product(
     product_id CHAR(4) NOT NULL, 
     product_name VARCHAR(100) NOT NULL, 
     product_type VARCHAR(32) NOT NULL, 
     sale_price INTEGER, 
     purchase_price INTEGER, 
     regist_date DATE, 
     PRIMARY KEY(product_id)
);
```

### 2.5 命名规则

* 只能使用半角英文字母、数字、下划线（_）作为数据库、表和列的名称
* 名称必须以半角英文字母开头

商品表和 product 表列名的对应关系


| 商品表中的列名 | Product表定义的列名 |
|----------------|---------------------|
| 商品编号       | product_id          |
| 商品名称       | product_name        |
| 商品种类       | product_type        |
| 销售单价       | sale_price          |
| 进货单价       | purchase_price      |
| 登记日期       | regist_date         |


### 2.6 数据类型的指定

数据库创建的表，所有的列都必须指定数据类型，每一列都不能存储与该列数据类型不符的数据。

五种最基本的数据类型

* INTEGER 型

    用来指定存储整数的列的数据类型（数字型），不能存储小数。

* CHAR 型

    用来存储定长字符串，当列中存储的字符串长度达不到最大长度的时候，使用半角空格进行补足，由于会浪费存储空间，所以一般不使用。

* VARCHAR 型

    用来存储可变长度字符串，定长字符串在字符数未达到最大长度时会用半角空格补足，但可变长字符串不同，即使字符数未达到最大长度，也不会用半角空格补足。

* DATE 型

    用来指定存储日期（年月日）的列的数据类型（日期型）。
    
* float 

    浮点小数。

### 2.7 约束的设置

约束是除了数据类型之外，对列中存储的数据进行限制或者追加条件的功能。

`NOT NULL` 是非空约束，即该列必须输入数据。

`PRIMARY KEY` 是主键约束，代表该列是唯一值，可以通过该列取出特定的行的数据。 

![PPdzX6](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/PPdzX6.png)

### 2.8 表的删除和更新 (ALTER 、UPDATE)

#### 2.8.1 删除表和表中的列的语法

```sql
DROP TABLE < 表名 > ;
```
    
**删除 product 表**
    
```sql
DROP TABLE product;
```

* 添加列的 ALTER TABLE 语句

```sql
ALTER TABLE < 表名 > ADD COLUMN < 列的定义 >;
```
    
**添加一列可以存储 100 位的可变长字符串的 product_name_pinyin 列**
    
```sql
ALTER TABLE product ADD COLUMN product_name_pinyin VARCHAR(100);
``` 
    
* 删除列的 ALTER TABLE 语句

```sql
ALTER TABLE < 表名 > DROP COLUMN < 列名 >;
```
    
**删除 product_name_pinyin 列**
    
```sql
ALTER TABLE product DROP COLUMN product_name_pinyin;
```    
    
ALTER TABLE 语句和 DROP TABLE 语句一样，执行之后无法恢复。误添的列可以通过 ALTER TABLE 语句删除，或者将表全部删除之后重新再创建。

#### 2.8.2 清空表内容

```sql
TRUNCATE TABLE TABLE_NAME;
```
    
优点：相比 drop/delete，truncate 用来清除数据时，速度最快。
    
#### 2.8.3 数据的更新

基本语法：

```sql
    UPDATE < 表名 >
    SET < 列名 > = < 表达式 > [, < 列名 2>=< 表达式 2>...] 
    WHERE < 条件 >  -- 可选，非常重要。
    ORDER BY 子句   -- 可选
    LIMIT 子句      -- 可选
```

> 使用 update 时要注意添加 where 条件，否则将会将所有的行按照语句修改

```sql
    -- 修改所有的注册时间
    UPDATE product
    SET regist_date = '2009-10-10';
    -- 仅修改部分商品的单价
    UPDATE product
    SET sale_price = sale_price * 10
    WHERE product_type = '厨房用具';
```

使用 UPDATE 也可以将列更新为 NULL（该更新俗称为 NULL 清空）。此时只需要将赋值表达式右边的值直接写为 NULL 即可。

```sql
    -- 将商品编号为 0008 的数据（圆珠笔）的登记日期更新为 NULL  
    UPDATE product
    SET regist_date = NULL
    WHERE product_id = '0008';  
```

和 INSERT 语句一样， UPDATE 语句也可以将 NULL 作为一个值来使用。**但是，只有未设置 NOT NULL 约束和主键约束的列才可以清空为 NULL。** 如果将设置了上述约束的列更新为 NULL，就会出错，这点与 INSERT 语句相同。

* 多列更新

UPDATE 语句的 SET 子句支持同时将多个列作为更新对象。

```sql
    -- 基础写法，一条 UPDATE 语句只更新一列
    UPDATE product
    SET sale_price = sale_price * 10
    WHERE product_type = '厨房用具';
    
    UPDATE product
    SET purchase_price = purchase_price / 2
    WHERE product_type = '厨房用具';
```

该写法可以得到正确结果，但是代码较为繁琐。可以采用合并的方法来简化代码。

```sql
    -- 合并后的写法
    UPDATE product
    SET sale_price = sale_price * 10,
        purchase_price = purchase_price / 2
    WHERE product_type = '厨房用具';  
```

需要明确的是，SET 子句中的列不仅可以是两列，还可以是三列或者更多。

### 2.9 向 product 表中插入数据 (INSERT)

为了学习 `INSERT` 语句用法，我们首先创建一个名为 `productins` 的表，建表语句如下：

```sql
CREATE TABLE productins(
    product_id     CHAR(4)      NOT NULL,
    product_name   VARCHAR(100) NOT NULL,
    product_type   VARCHAR(32)  NOT NULL,
    sale_price     INTEGER      DEFAULT 0,
    purchase_price INTEGER ,
    regist_date    DATE ,
    PRIMARY KEY (product_id)
); 
```

基本语法：

```sql
INSERT INTO < 表名 > (列 1, 列 2, 列 3, ……) VALUES (值 1, 值 2, 值 3, ……);  
```

对表进行全列 `INSERT` 时，可以省略表名后的列清单。
这时 `VALUES` 子句的值会默认按照从左到右的顺序赋给每一列。

```sql
-- 包含列清单
INSERT INTO productins (
    product_id, 
    product_name, 
    product_type, 
    sale_price, 
    purchase_price, 
    regist_date)
VALUES (
    '0005', 
    '高压锅', 
    '厨房用具', 
    6800, 
    5000, 
    '2009-01-15'
);
-- 省略列清单
INSERT INTO productins 
VALUES (
    '0005', 
    '高压锅', 
    '厨房用具', 
    6800, 
    5000, 
    '2009-01-15'
);  
```

原则上，执行一次 `INSERT` 语句会插入一行数据。插入多行时，通常需要循环执行相应次数的 `INSERT` 语句。其实很多 `RDBMS` 都支持一次插入多行数据

```sql
-- 通常的 INSERT
INSERT INTO productins 
VALUES (
'0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO productins 
VALUES (
'0003', '运动 T 恤', '衣服', 4000, 2800, NULL);
INSERT INTO productins 
VALUES (
'0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');

-- 多行 INSERT （ DB2、SQL、SQL Server、 PostgreSQL 和 MySQL 多行插入）
INSERT INTO productins 
VALUES 
('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
('0003', '运动 T 恤', '衣服', 4000, 2800, NULL),
('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');  


-- Oracle 中的多行 INSERT
INSERT ALL INTO productins 
VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11')
INTO productins 
VALUES ('0003', '运动 T 恤', '衣服', 4000, 2800, NULL)
INTO productins 
VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20')
SELECT * FROM DUAL;  
-- DUAL 是 Oracle 特有（安装时的必选项）的一种临时表 A。
-- 因此“SELECT * FROM DUAL” 部分也只是临时性的，并没有实际意义。  
```

INSERT 语句中想给某一列赋予 `NULL` 值时，可以直接在 `VALUES` 子句的值清单中写入 `NULL`。想要插入 `NULL` 的列一定不能设置 `NOT NULL` 约束。

```sql
INSERT INTO productins (
    product_id, 
    product_name, 
    product_type, 
    sale_price, 
    purchase_price, 
    regist_date) 
VALUES (
    '0006', 
    '叉子', 
    '厨房用具', 
    500, 
    NULL, 
    '2009-09-20'
);  
```

还可以向表中插入**默认值（初始值）**。

可以通过在创建表的 ` CREATE TABLE ` 语句中设置 `DEFAULT` 约束来设定默认值。

```sql
CREATE TABLE productins(
    product_id CHAR(4) NOT NULL,
    （略）
    sale_price INTEGER
    （略）	DEFAULT 0, -- 销售单价的默认值设定为 0;
    PRIMARY KEY (product_id)
);  
```

可以使用 `INSERT … SELECT ` 语句从其他表复制数据。

```sql
-- 将商品表中的数据复制到商品复制表中
INSERT INTO productcopy (
    product_id, 
    product_name, 
    product_type, 
    sale_price, 
    purchase_price, 
    regist_date
)
SELECT 
    product_id, 
    product_name, 
    product_type, 
    sale_price, 
    purchase_price, 
    regist_date
FROM Product;  
```

> 本课程用表插入数据 sql 如下：
```sql
    - DML ：插入数据
    START TRANSACTION;
    INSERT INTO product 
        VALUES('0001', 'T 恤衫', '衣服', 1000, 500, '2009-09-20');
    INSERT INTO product 
        VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
    INSERT INTO product 
        VALUES('0003', '运动 T 恤', '衣服', 4000, 2800, NULL);
    INSERT INTO product 
        VALUES('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
    INSERT INTO product 
        VALUES('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
    INSERT INTO product 
        VALUES('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
    INSERT INTO product 
        VALUES('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
    INSERT INTO product 
        VALUES('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
    COMMIT;
```

### 2.10 自动增长属性

![SMjooi](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/SMjooi.png)

![TtH4XH](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/TtH4XH.png)

```sql

CREATE TABLE ai_test(
    ai_id int not null AUTO_INCREMENT,
    ai_unique varchar(20) not null,
    PRIMARY KEY(ai_id),
    CONSTRAINT ai_unique_ui UNIQUE (ai_unique)
)

INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'125');
INSERT INTO ai_test VALUES (0,'126');
INSERT INTO ai_test VALUES (0,'127');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'128');

```

```sql
CREATE TABLE students_new(
    student id int not null AUTO INCREMENT,
    student_name varchar(20) not null,
    student age int not null,
    student weight float not null DEFAULT 99.9, 
    PRIMARY KEY(student_id)
```


```sql

INSERT INTO students_new(student_name,student_age) VALUES('王菲',19);

INSERT INTO students_new(student_id,student_name,student_age,student_weight) VALUES(5,'张玉婷',22,109.99);

INSERT INTO students_new(student_name,student_age) VALUES('丛老师',26);

INSERT INTO students_new VALUES(0,'杨小辉',3,42)

```

[ID 可以为负数](https://www.coder.work/article/1664486)

![sxecHP](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/sxecHP.png)


在整型类型中，有 **signed** 和 **unsigned** 属性，其表示的是整型的取值范围，默认为 **signed**

* signed： 带符号，数值可以是正负和零
* unsigned：不带符号，数值是大于等于 0

## 三、练习题

### 3.1 创建表

编写一条 ` CREATE TABLE ` 语句，用来创建一个包含表 1-A 中所列各项的表 `Addressbook` （地址簿），并为 regist_no （注册编号）列设置主键约束

表 1-A　表 Addressbook （地址簿）中的列


| 列的含义 | 列的名称     | 数据类型                    | 约束            |
|----------|--------------|-----------------------------|:----------------|
| 注册编号 | regist_no    | 整数型                      | 不能为NULL、主键 |
| 姓名     | name         | 可变长字符串类型（长度为128） | 不能为NULL      |
| 住址     | address      | 可变长字符串类型（长度为256） | 不能为NULL      |
| 电话号码 | tel_no       | 定长字符串类型（长度为10）    |                 |
| 邮箱地址 | mail_address | 定长字符串类型（长度为20）    |                 |


```sql
CREATE TABLE Addressbook(
   regist_no        INTEGER          NOT NULL,
   name             VARCHAR(128)     NOT NULL,
   address          VARCHAR(256)     NOT NULL,
   tel_no           CHAR(10)     ,
   mail_address     CHAR(20)     ,
   PRIMARY KEY (regist_no)
);
```

### 3.2 增加新的列

假设在创建练习 1.1 中的 Addressbook 表时忘记添加如下一列 `postal_code` （邮政编码）了，请把此列添加到 Addressbook 表中。

列名    ： postal_code

数据类型 ：定长字符串类型（长度为 8）

约束    ：不能为 NULL


```sql
-- [MySQL]
ALTER TABLE Addressbook ADD COLUMN postal_code CHAR(8) NOT NULL ;
-- [Oracle]
ALTER TABLE Addressbook ADD (postal_code CHAR(8)) NOT NULL;
-- [SQL Server]
ALTER TABLE Addressbook ADD postal_code CHAR(8) NOT NULL;
/*
 [DB2] 无法添加。
 在 DB2 中，如果要为添加的列设定 NOT NULL 约束，
 需要像下面这样指定默认值，或者删除 NOT NULL 约束，
 否则就无法添加新列。
*/
-- [DB2 修正版]
ALTER TABLE Addressbook ADD COLUMN postal_code CHAR(8) NOT NULL DEFAULT '0000-000';
```
### 3.3 删除表

编写 SQL 语句来删除 Addressbook 表。

```sql
DROP TALBE Addressbook;
```

### 3.4 恢复？

编写 SQL 语句来恢复删除掉的 Addressbook 表。

删除后的表无法使用命令进行恢复，请使用习题 3.1 答案中的 ` CREATE TABLE ` 语句再次创建所需的表。

本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql

# Task02：SQL 基础查询与排序

[TOC]

## 一、SELECT 语句基础

### 1.1 从表中选取数据

**SELECT 语句**  

从表中选取数据时需要使用 SELECT 语句，也就是只从表中选出（SELECT）必要数据的意思。通过 SELECT 语句查询并选取出必要数据的过程称为匹配查询或查询（query）。

基本 `SELECT` 语句包含了 `SELECT` 和 `FROM` 两个子句（clause）。示例如下：

```sql
SELECT < 列名 >,< 列名 >
FROM < 表名 >;
```

其中，SELECT 子句中列举了希望从表中查询出的列的名称，而 FROM 子句则指定了选取出数据的表的名称。

### 1.2 从表中选取符合条件的数据

**WHERE 语句**
  
当不需要取出全部数据，而是选取出满足“商品种类为衣服”“销售单价在 1000 日元以上”等某些条件的数据时，使用 WHERE 语句。

SELECT 语句通过 WHERE 子句来指定查询数据的条件。在 WHERE 子句中可以指定“某一列的值和这个字符串相等”或者“某一列的值大于这个数字”等条件。执行含有这些条件的 SELECT 语句，就可以查询出只符合该条件的记录了。

```sql
SELECT < 列名 >, ……
FROM < 表名 >
WHERE < 条件表达式 >;
```

比较下面两者输出结果的不同：

```sql
-- 用来选取 product_type 列为衣服的记录的 SELECT 语句
SELECT product_name, product_type
FROM product
WHERE product_type = '衣服';
-- 也可以选取出不是查询条件的列（条件列与输出列不同）
SELECT product_name
FROM product
WHERE product_type = '衣服';
```

### 1.3 相关法则

* 星号（*）代表全部列的意思。
* SQL 中可以随意使用换行符，不影响语句执行（但不可插入空行）。
* 设定汉语别名时需要使用双引号（"）括起来。
* 在 SELECT 语句中使用 **DISTINCT** 可以删除重复行。
* 注释是 SQL 语句中用来标识说明或者注意事项的部分。分为单行注释 "--" 和多行注释两种 "/*  */"。

```sql
-- 想要查询出全部列时，可以使用代表所有列的星号（*）。
SELECT *
FROM < 表名 >;
-- SQL 语句可以使用 AS 关键字为列设定别名（用中文时需要双引号（""））。
SELECT product_id     AS id,
       product_name   AS name,
       purchase_price AS "进货单价"
FROM product;
-- 使用 DISTINCT 删除 product_type 列中重复的数据
SELECT DISTINCT product_type
FROM product;
```

## 二、算术运算符和比较运算符

### 2.1 算术运算符

SQL 语句中可以使用的四则运算的主要运算符如下：

含义 | 运算符
-- | ---
加法 | +  
减法 | -  
乘法 | \* 
除法 | /  

### 2.2 比较运算符

```sql
-- 选取出 sale_price 列为 500 的记录
SELECT product_name, product_type
FROM product
WHERE sale_price = 500;
```

SQL 常见比较运算符如下：

运算符 | 含义   
--- | -----
=   | 和 *某* 相等 
<>  | 和 *某* 不相等
\>=  | 大于等于 *某*
\>   | 大于 *某* 
<=  | 小于等于 *某*
<   | 小于 *某* 

### 2.3 常用法则

* SELECT 子句中可以使用常数或者表达式。
* 使用比较运算符时一定要注意**不等号**和**等号**的位置。
* 字符串类型的数据原则上按照字典顺序进行排序，不能与数字的大小顺序混淆。
* 希望选取 `NULL` 记录时，需要在条件表达式中使用 ` IS NULL` 运算符。希望选取不是 NULL 的记录时，需要在条件表达式中使用 IS NOT NULL 运算符。

相关代码如下：

```sql
-- SQL 语句中也可以使用运算表达式
SELECT 
    product_name, 
    sale_price, 
    sale_price * 2 AS "sale_price x2"
FROM product;
-- WHERE 子句的条件表达式中也可以使用计算表达式
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price-purchase_price >= 500;
```

```sql 
/* 对字符串使用不等号
首先创建 chars 并插入数据
选取出大于'2'的 SELECT 语句 */

-- DDL：创建表
CREATE TABLE chars(
    chr CHAR（3）NOT NULL，
    PRIMARY KEY(chr)
);
-- 选取出大于 '2' 的数据的 SELECT 语句 ('2' 为字符串)
SELECT chr
FROM chars
WHERE chr > '2';
```

```sql
-- 选取 NULL 的记录
SELECT product_name，purchase_price
FROM product
WHERE purchase_price IS NULL;
-- 选取不为 NULL 的记录
SELECT product_name，purchase_price
FROM product
WHERE purchase_price IS NOT NULL;
```

## 三、逻辑运算符

### 3.1 NOT 运算符

想要表示“不是……”时，除了前文的 <> 运算符外，还存在另外一个表示否定、使用范围更广的运算符：`NOT`。

**NOT** 不能单独使用，如下例：

```sql
-- 选取出销售单价大于等于 1000 日元的记录
SELECT product_name, product_type, sale_price
FROM product
WHERE sale_price >= 1000;

-- 向上面代码清单的查询条件中添加 NOT 运算符
SELECT product_name, product_type, sale_price
FROM product
WHERE NOT sale_price >= 1000;
```

### 3.2 AND 运算符和 OR 运算符

当希望同时使用多个查询条件时，可以使用 `AND` 或者 `OR` 运算符。

* AND 相当于“并且”，类似数学中的取交集；
* OR 相当于“或者”，类似数学中的取并集。

如下图所示：

* AND 运算符工作效果图

![4QTIKv](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/4QTIKv.jpg)

* OR 运算符工作效果图

![KRf31f](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/KRf31f.jpg)

### 3.3 通过括号优先处理

如果要查找这样一个商品，该怎么处理？

> “商品种类为办公用品”并且“登记日期是 2009 年 9 月 11 日或者 2009 年 9 月 20 日”  
> 理想结果为“打孔器”，但当你输入以下信息时，会得到错误结果

```sql
-- 将查询条件原封不动地写入条件表达式，会得到错误结果
SELECT product_name, product_type, regist_date
FROM product
WHERE product_type = '办公用品'
AND regist_date = '2009-09-11'
OR regist_date = '2009-09-20';
```

错误的原因是 **是 AND 运算符优先于 OR 运算符**，想要优先执行 OR 运算，可以使用 **括号**：

```sql
-- 通过使用括号让 OR 运算符先于 AND 运算符执行
SELECT product_name, product_type, regist_date
FROM product
WHERE product_type = '办公用品'
AND ( regist_date = '2009-09-11'
OR regist_date = '2009-09-20');
```

### 3.4 真值表

复杂运算时该怎样理解？

当碰到条件较复杂的语句时，理解语句含义并不容易，这时可以采用 **真值表** 来梳理逻辑关系。

**什么是真值？**

本节介绍的三个运算符 NOT、AND 和 OR 称为逻辑运算符。

这里所说的逻辑就是对真值进行操作的意思。**真值** 就是值为真（TRUE）或假 （FALSE）其中之一的值。

例如，对于 `sale_price >= 3000` 这个查询条件来说，由于 product_name 列为 '运动 T 恤' 的记录的 sale_price 列的值是 2800，因此会返回假（FALSE），而 product_name 列为 '高压锅' 的记录的 sale_price 列的值是 5000，所以返回真（TRUE）。

**AND 运算符**：两侧的真值都为真时返回真，除此之外都返回假。

**OR 运算符**：两侧的真值只要有一个不为假就返回真，只有当其两侧的真值都为假时才返回假。

**NOT 运算符**：只是单纯的将真转换为假，将假转换为真。

**真值表**

![kP3sDC](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/kP3sDC.jpg)

查询条件为 `P AND（Q OR R）` 的真值表

![BqdDME](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/BqdDME.jpg)

### 3.5 含有 NULL 时的真值

NULL 的真值结果既不为真，也不为假，因为并不知道这样一个值。

那该如何表示呢？

这时真值是除真假之外的第三种值——**不确定**（UNKNOWN）。一般的逻辑运算并不存在这第三种值。SQL 之外的语言也基本上只使用真和假这两种真值。与通常的逻辑运算被称为二值逻辑相对，只有 SQL 中的逻辑运算被称为三值逻辑。

三值逻辑下的 AND 和 OR 真值表为：

![N8pn5O](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/N8pn5O.jpg)

## 练习题 - 第一部分

### 练习题 1

编写一条 SQL 语句，从 product（商品）表中选取出“登记日期（regist 在 2009 年 4 月 28 日之后”的商品，查询结果要包含 product_name 和 regist_date 两列。

```sql
SELECT product_name, regist_date
FROM product
WHERE regist_date > '2009-04-28';
```

### 练习题 2

请说出对 product 表执行如下 3 条 SELECT 语句时的返回结果。

```sql
SELECT *
FROM product
WHERE purchase_price = NULL;
```

```sql
SELECT *
FROM product
WHERE purchase_price <> NULL;
```

```sql
SELECT *
FROM product
WHERE product_name > NULL;
```

### 练习题 3

代码清单 2-22（2-2 节）中的 SELECT 语句能够从 product 表中取出“销售单价（saleprice）比进货单价（purchase price）高出 500 日元以上”的商品。请写出两条可以得到相同结果的 SELECT 语句。执行结果如下所示。

```
product_name | sale_price | purchase_price 
------------ + ---------- + ------------
T 恤衫        | 　 1000    | 500
运动 T 恤     |    4000    | 2800
高压锅        |    6800    | 5000
```

```sql
-- SELECT 语句 1
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price >= purchase_price + 500;
 
-- SELECT 语句 2
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price - 500 >= purchase_price;
```


### 练习题 4

请写出一条 SELECT 语句，从 product 表中选取出满足“销售单价打九折之后利润高于 100 日元的办公用品和厨房用具”条件的记录。查询结果要包括 product_name 列、product_type 列以及销售单价打九折之后的利润（别名设定为 profit）。

提示：销售单价打九折，可以通过 saleprice 列的值乘以 0.9 获得，利润可以通过该值减去 purchase_price 列的值获得。

```sql
SELECT product_name, product_type,
       sale_price * 0.9 - purchase_price AS profit
FROM product
WHERE sale_price * 0.9 - purchase_price > 100
   AND (   product_type = '办公用品'
        OR product_type = '厨房用具');
```

```sql
SELECT product_type, SUM(sale_price), SUM(purchase_price)
FROM product
GROUP BY product_type
HAVING SUM(sale_price) > SUM(purchase_price) * 1.5;
```

上面这段代码是什么意思呢？如何翻译成中文！

## 四、对表进行聚合查询

### 4.1 聚合函数

SQL 中用于汇总的函数叫做聚合函数。以下五个是最常用的聚合函数：

* COUNT：计算表中的记录数（行数）
* SUM：计算表中数值列中数据的合计值
* AVG：计算表中数值列中数据的平均值
* MAX：求出表中任意列中数据的最大值
* MIN：求出表中任意列中数据的最小值

在使用 COUNT 的时候要特别注意的一点是,COUNT(*) 和 COUNT(字段) 的区别.

请沿用第一章的数据，使用以下操作熟练函数：

```sql
-- 计算全部数据的行数（包含 NULL）
SELECT COUNT(*)
FROM product;

-- 计算 NULL 以外数据的行数
SELECT COUNT(purchase_price)
FROM product;

-- 计算销售单价和进货单价的合计值
SELECT SUM(sale_price), SUM(purchase_price) 
FROM product;

-- 计算销售单价和进货单价的平均值
SELECT AVG(sale_price), AVG(purchase_price)
FROM product;

-- MAX 和 MIN 也可用于非数值型数据
SELECT MAX(regist_date), MIN(regist_date)
FROM product;
```


MySQL 聚合函数主要用于数据统计，比如计数、求和、求平均数等。聚合函数结合分组操作，您可以在更多的维度统计数据。

* AVG
MySQL AVG() 函数计算并返回表达式的平均值。
* BIT_AND
MySQL BIT_AND() 函数是一个聚合函数，它对所有的非 null 输入值执行"按位与"运算。
* BIT_OR
MySQL BIT_OR() 函数是一个聚合函数，它对所有的非 null 输入值执行"按位或"运算。
* BIT_XOR
MySQL BIT_XOR() 函数是一个聚合函数，它对所有的非 null 输入值执行"按位异或"运算。
* COUNT
MySQL COUNT() 函数用于统计表达式的数量。
* GROUP_CONCAT
MySQL GROUP_CONCAT() 函数将一个分组中指定的列或表达式的值连接成一个字符串并返回。
* JSON_ARRAYAGG
MySQL JSON_ARRAYAGG() 函数将指定的列或者表达式的值聚合为一个 JSON 数组。
* JSON_OBJECTAGG
MySQL JSON_OBJECTAGG() 函数将由第一个参数作为键和第二个参数作为值的键值对聚合为一个 JSON 对象。
* MAX
MySQL MAX() 函数返回表达式的最大值。
* MIN
MySQL MIN() 函数返回表达式的最小值。
* STD
MySQL STD() 计算所有非 null 输入值的总体标准差并返回结果。
* STDDEV
MySQL STDDEV() 函数计算所有非 null 输入值的总体标准差并返回结果。
* STDDEV_POP
MySQL STDDEV_POP() 函数计算所有非 null 输入值的总体标准差并返回结果。
* STDDEV_SAMP
MySQL STDDEV_SAMP() 函数计算所有非 null 输入值的样本标准差并返回结果。
* SUM
MySQL SUM() 函数计算所有指定的非 NULL 值的总和并返回。
* VAR_POP
MySQL VAR_POP() 函数计算所有非 null 输入值的总体方差（总体标准差的平方）并返回结果。
* VAR_SAMP
MySQL VAR_SAMP() 函数计算所有非 null 输入值的样本方差（样本标准差的平方）并返回结果。
* VARIANCE
MySQL VARIANCE() 函数计算所有非 null 输入值的总体方差（总体标准差的平方）并返回结果。


### 4.2 使用聚合函数删除重复值

```sql
-- 计算去除重复数据后的数据行数
SELECT COUNT(DISTINCT product_type)
FROM product;

-- 是否使用 DISTINCT 时的动作差异（SUM 函数）
SELECT SUM(sale_price), SUM(DISTINCT sale_price)
FROM product;
```

### 4.3 常用法则

* COUNT 函数的结果根据参数的不同而不同。COUNT(*) 会得到包含 NULL 的数据行数，而 COUNT(< 列名 >) 会得到 NULL 之外的数据行数。
* 聚合函数会将 NULL 排除在外。但 COUNT(*) 例外，并不会排除 NULL。
* MAX/MIN 函数几乎适用于所有数据类型的列。SUM/AVG 函数只适用于数值类型的列。
* 想要计算值的种类时，可以在 COUNT 函数的参数中使用 DISTINCT。
* 在聚合函数的参数中使用 DISTINCT，可以删除重复数据。

## 五、对表进行分组

### 5.1 GROUP BY 语句

之前使用聚合函数都是会整个表的数据进行处理，当你想将进行分组汇总时（即：将现有的数据按照某列来汇总统计），GROUP BY 可以帮助你：

```sql
SELECT < 列名 1>,< 列名 2>, < 列名 3>, ……
FROM < 表名 >
GROUP BY < 列名 1>, < 列名 2>, < 列名 3>, ……;
```

看一看是否使用 GROUP BY 语句的差异：

```sql
-- 按照商品种类统计数据行数
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type;

-- 不含 GROUP BY
SELECT product_type, COUNT(*)
FROM product
```

按照商品种类对表进行切分

![d8piMk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/d8piMk.jpg)

这样，GROUP BY 子句就像切蛋糕那样将表进行了分组。在 GROUP BY 子句中指定的列称为 **聚合键** 或者 **分组列**。

### 5.2 聚合键中包含 NULL 时

将进货单价（purchase_price）作为聚合键举例：

```sql
SELECT purchase_price, COUNT(*)
FROM product
GROUP BY purchase_price;
```
此时会将 NULL 作为一组特殊数据进行处理

### 5.3 GROUP BY 书写位置

**GROUP BY** 的子句书写顺序有严格要求，不按要求会导致 SQL 无法正常执行，目前出现过的子句 **书写顺序** 为：

**1.SELECT → 2. FROM → 3. WHERE → 4. GROUP BY**

其中前三项用于筛选数据，GROUP BY 对筛选出的数据进行处理

### 5.4 在 WHERE 子句中使用 GROUP BY

```sql
SELECT purchase_price, COUNT(*)
FROM product
WHERE product_type = '衣服'
GROUP BY purchase_price;
```

### 5.5 常见错误

在使用聚合函数及 GROUP BY 子句时，经常出现的错误有：

1.  在聚合函数的 SELECT 子句中写了聚合键以外的列使用 COUNT 等聚合函数时，SELECT 子句中如果出现列名，**只能**是 GROUP BY 子句中指定的列名（也就是聚合键）。
2.  在 GROUP BY 子句中使用列的别名 SELECT 子句中可以通过 AS 来指定别名，但在 GROUP BY 中**不能**使用别名。因为在 DBMS 中 ,**SELECT 子句在 GROUP BY 子句后执行**。
3.  在 WHERE 中使用聚合函数，原因是聚合函数的使用前提是结果集已经确定，而 WHERE 还处于确定结果集的过程中，所以相互矛盾会引发错误。 如果想指定条件，可以在 SELECT，HAVING 以及 ORDER BY 子句中使用聚合函数。

## 六、为聚合结果指定条件

### 6.1 用 HAVING 得到特定分组

将表使用 GROUP BY 分组后，怎样才能只取出其中两组？

![uDC5YQ](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/uDC5YQ.jpg)

这里 WHERE 不可行，因为，WHERE 子句只能指定记录（行）的条件，而不能用来指定组的条件（例如，“数据行数为 2 行”或者“平均值为 500”等）。

可以在 GROUP BY 后使用 HAVING 子句。

HAVING 的用法类似 WHERE

### 6.2 HAVING 特点

**HAVING 子句用于对分组进行过滤，可以使用数字、聚合函数和 GROUP BY 中指定的列名（聚合键）。**

```sql
-- 数字
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type
HAVING COUNT(*) = 2;

-- 错误形式（因为 product_name 不包含在 GROUP BY 聚合键中）
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type
HAVING product_name = '圆珠笔';
```

## 七、对查询结果进行排序

### 7.1 ORDER BY

SQL 中的执行结果是随机排列的，当需要按照特定顺序排序时，可已使用 **ORDER BY** 子句。

```sql
SELECT < 列名 1>, < 列名 2>, < 列名 3>, ……
FROM < 表名 >
ORDER BY < 排序基准列 1>, < 排序基准列 2>, ……
```

默认为升序排列，降序排列为 DESC

```sql
-- 降序排列
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY sale_price DESC;

-- 多个排序键
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY sale_price, product_id;

-- 当用于排序的列名中含有 NULL 时，NULL 会在开头或末尾进行汇总。
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY purchase_price;
```

### 7.2 ORDER BY 中列名可使用别名

前文讲 GROUP BY 中提到，GROUP BY 子句中不能使用 SELECT 子句中定义的别名，但是在 ORDER BY 子句中却可以使用别名。为什么在 GROUP BY 中不可以而在 ORDER BY 中可以呢？

这是因为 SQL 在使用 HAVING 子句时 SELECT 语句的 **执行顺序** 为：

**FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY**

其中 SELECT 的执行顺序在 GROUP BY 子句之后，ORDER BY 子句之前。也就是说，当在 ORDER BY 中使用别名时，已经知道了 SELECT 设置的别名存在，但是在 GROUP BY 中使用别名时还不知道别名的存在，所以 **在 ORDER BY 中可以使用别名，但是在 GROUP BY 中不能使用别名。**

## 练习题 - 第二部分

### 练习题 5

请指出下述 SELECT 语句中所有的语法错误。

```sql
-- 本 SELECT 语句中存在错误。
SELECT product_id, SUM（product_name）
FROM product 
GROUP BY product_type 
WHERE regist_date > '2009-09-01';
```


* 错误 1
字符型字段  product_name  不可以进行  SUM  聚合
* 错误 2
WHERE  语句应该书写在  GROUP BY  语句之前（  FROM  语句之后）
* 错误 3
GROUP BY  字段（product_type ）与  SELECT  字段不同（product_id ）

### 练习题 6

请编写一条 SELECT 语句，求出销售单价（sale_price 列）合计值大于进货单价（purchase_price 列）合计值 1.5 倍的商品种类。执行结果如下所示。

![sxE3zO](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/sxE3zO.jpg)

```sql
SELECT product_type, SUM(sale_price),SUM(purchase_price)
FROM product
GROUP BY product_type
HAVING SUM(sale_price) > SUM(purchase_price) * 1.5;
```

### 练习题 7

此前我们曾经使用 SELECT 语句选取出了 product（商品）表中的全部记录。当时我们使用了 ORDERBY 子句来指定排列顺序，但现在已经无法记起当时如何指定的了。请根据下列执行结果，思考 ORDERBY 子句的内容。

![DwKApk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/DwKApk.jpg)

```sql
SELECT *
FROM product
ORDER BY regist_date DESC, sale_price;
```

本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql
# Task03：复杂查询方法 - 视图、子查询、函数等

[TOC]

## 3.1 视图

我们先来看一个查询语句（仅做示例，未提供相关数据）

```sql
SELECT stu_name FROM view_students_info;
```

单从表面上看起来这个语句是和正常的从数据表中查询数据是完全相同的，但其实我们操作的是一个视图。所以从 SQL 的角度来说操作视图与操作表看起来是完全相同的，那么为什么还会有视图的存在呢？视图到底是什么？视图与表有什么不同呢？

### 3.1.1 什么是视图

**视图是一个虚拟的表**，不同于直接操作数据表，视图是依据 SELECT 语句来创建的（会在下面具体介绍），所以操作视图时会根据创建视图的 SELECT 语句生成一张虚拟表，然后在这张虚拟表上做 SQL 操作。

### 3.1.2 视图与表有什么区别

《SQL 基础教程第 2 版 》用一句话非常凝练的概括了视图与表的区别—“是否保存了实际的数据”。所以视图并不是数据库真实存储的数据表，它可以看作是一个窗口，通过这个窗口我们可以看到数据库表中真实存在的数据。所以我们要区别视图和数据表的本质，即视图是基于真实表的一张虚拟的表，其数据来源均建立在真实表的基础上。

![SopKUf](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/SopKUf.jpg)

 图片来源：《SQL 基础教程第 2 版》

下面这句顺口溜也方便大家记忆视图与表的关系：**“视图不是表，视图是虚表，视图依赖于表，视图不保存正式数据”**。

### 3.1.3 为什么会存在视图

那既然已经有数据表了，为什么还需要视图呢？主要有以下几点原因：

1.  通过定义视图可以将频繁使用的 SELECT 语句保存以提高效率。
2.  通过定义视图可以使用户看到的数据更加清晰。
3.  通过定义视图可以不对外公开数据表全部字段，增强数据的保密性。
4.  通过定义视图可以降低数据的冗余。

### 3.1.4 如何创建视图

说了这么多视图与表的区别，下面我们就一起来看一下如何创建视图吧。创建视图的基本语法如下：

```sql
CREATE VIEW < 视图名称 >(< 列名 1>,< 列名 2>,...) AS <SELECT 语句 >
```

其中 SELECT 语句需要书写在 AS 关键字之后。 SELECT 语句中列的排列顺序和视图中列的排列顺序相同， SELECT 语句中的第 1 列就是视图中的第 1 列， SELECT 语句中的第 2 列就是视图中的第 2 列，以此类推。而且视图的列名是在视图名称之后的列表中定义的。  
需要注意的是视图名在数据库中需要是唯一的，不能与其他视图和表重名。

视图不仅可以基于真实表，我们也可以在视图的基础上继续创建视图。

![LSe4zz](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/LSe4zz.jpg)

图片来源：《SQL 基础教程第 2 版》

虽然在视图上继续创建视图的语法没有错误，但是我们还是应该尽量避免这种操作。这是因为对多数 DBMS 来说， 多重视图会降低 SQL 的性能。

* 注意事项

需要注意的是在一般的 DBMS 中定义视图时不能使用 ORDER BY 语句。下面这样定义视图是错误的。

```sql
CREATE VIEW productsum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type
ORDER BY product_type;
```

为什么不能使用 ORDER BY 子句呢？这是因为视图和表一样，**数据行都是没有顺序的**。

*在 MySQL 中视图的定义是允许使用 ORDER BY 语句的，但是若从特定视图进行选择，而该视图使用了自己的 ORDER BY 语句，则视图定义中的 ORDER BY 将被忽略。*

#### 3.1.4.1 基于单表的视图

我们在 product 表的基础上创建一个视图，如下：

```sql
CREATE VIEW productsum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type ;
```

创建的视图如下图所示：
  
![JIgtCS](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/JIgtCS.jpg)

#### 3.1.4.2 基于多表的视图

为了学习多表视图，我们再创建一张表，相关代码如下：

```sql
CREATE TABLE shop_product(
    shop_id    CHAR(4)       NOT NULL,
    shop_name  VARCHAR(200)  NOT NULL,
    product_id CHAR(4)       NOT NULL,
    quantity   INTEGER       NOT NULL,
    PRIMARY KEY (shop_id, product_id)
);

INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0001',	30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0002',	50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0003',	15);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0002',	30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0003',	120);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0004',	20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0006',	10);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0007',	40);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0003',	20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0004',	50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0006',	90);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0007',	70);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000D',	'福冈',		'0001',	100);
```

我们在 product 表和 shop_product 表的基础上创建视图。

```sql
CREATE VIEW view_shop_product(product_type, sale_price, shop_name)
AS
SELECT product_type, sale_price, shop_name
FROM product,shop_product
WHERE product.product_id = shop_product.product_id;
```

![bPSvEa](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/bPSvEa.png)

创建的视图如下图所示

![NwPDMh](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/NwPDMh.jpg)

我们可以在这个视图的基础上进行查询

```sql
SELECT sale_price, shop_name
FROM view_shop_product
WHERE product_type = '衣服';
```

查询结果为：

![YE9mg5](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/YE9mg5.jpg)

### 3.1.5 如何修改视图结构

修改视图结构的基本语法如下：

```sql
ALTER VIEW < 视图名 > AS <SELECT 语句 >
```

其中视图名在数据库中需要是唯一的，不能与其他视图和表重名。  
当然也可以通过将当前视图删除然后重新创建的方式达到修改的效果。（对于数据库底层是不是也是这样操作的呢，你可以自己探索一下。）

* 修改视图

我们修改上方的 productSum 视图为

```sql
ALTER VIEW productSum
AS
SELECT product_type, sale_price
FROM Product
WHERE regist_date > '2009-09-11';
```

此时 productSum 视图内容如下图所示  

![BdfkVM](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/BdfkVM.jpg)

### 3.1.6 如何更新视图内容

因为视图是一个虚拟表，所以对视图的操作就是对底层基础表的操作，所以在修改时只有满足底层基本表的定义才能成功修改。

**对于一个视图来说，如果包含以下结构的任意一种都是不可以被更新的**：

* 聚合函数 SUM()、MIN()、MAX()、COUNT() 等
* DISTINCT 关键字
* GROUP BY 子句
* HAVING 子句
* UNION 或 UNION ALL 运算符
* FROM 子句中包含多个表

视图归根结底还是从表派生出来的，因此，如果原表可以更新，那么视图中的数据也可以更新。反之亦然，如果视图发生了改变，而原表没有进行相应更新的话，就无法保证数据的一致性了。

* 更新视图

因为我们刚刚修改的 productSum 视图不包括以上的限制条件，我们来尝试更新一下视图

```sql
UPDATE productsum
SET sale_price = '5000'
WHERE product_type = '办公用品';
```

此时我们再查看 productSum 视图，可以发现数据已经更新了

![8ZYek0](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/8ZYek0.jpg)


此时观察原表也可以发现数据也被更新了

![FFLV1s](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/FFLV1s.jpg)


不知道大家看到这个结果会不会有疑问，刚才修改视图的时候是设置 product_type='办公用品' 的商品的 sale_price=5000，为什么原表的数据只有一条做了修改呢？

还是因为视图的定义，视图只是原表的一个窗口，所以它修改也只能修改透过窗口能看到的内容。

**注意：这里虽然修改成功了，但是并不推荐这种使用方式。而且我们在创建视图时也尽量使用限制不允许通过视图来修改表**

### 3.1.7 如何删除视图

删除视图的基本语法如下：

```sql
DROP VIEW < 视图名 1> [, < 视图名 2> …]
```

注意：需要有相应的权限才能成功删除。

* 删除视图

我们删除刚才创建的 productSum 视图

```sql
DROP VIEW productSum;
```

如果我们继续操作这个视图的话就会提示当前操作的内容不存在。

## 3.2 子查询

我们先来看一个语句（仅做示例，未提供相关数据）

```sql
SELECT stu_name
FROM (SELECT stu_name, COUNT(*) AS stu_cnt
      FROM students_info
      GROUP BY stu_age
     ) AS studentSum;
```

这个语句看起来很好理解，其中使用括号括起来的 SQL 语句首先执行，执行成功后再执行外面的 SQL 语句。但是我们上一节提到的视图也是根据 SELECT 语句创建视图然后在这个基础上再进行查询。那么什么是子查询呢？子查询和视图又有什么关系呢？

### 3.2.1 什么是子查询

子查询指一个查询语句嵌套在另一个查询语句内部的查询，这个特性从 MySQL 4.1 开始引入，在 SELECT 子句中**先计算子查询**，子查询结果作为外层另一个查询的过滤条件，查询可以基于一个表或者多个表。

### 3.2.2 子查询和视图的关系

子查询就是将用来定义视图的 SELECT 语句直接用于 FROM 子句当中。其中 AS studentSum 可以看作是子查询的名称，而且由于子查询是一次性的，所以**子查询不会像视图那样保存在存储介质中**， 而是在 SELECT 语句执行之后就消失了。

### 3.2.3 嵌套子查询

与在视图上再定义视图类似，子查询也没有具体的限制，例如我们可以这样

```sql
SELECT product_type, cnt_product
FROM (SELECT *
      FROM (  
              SELECT product_type, 
              COUNT(*) AS cnt_product
              FROM product 
              GROUP BY product_type
            ) AS productsum
      WHERE cnt_product = 4
      ) AS productsum2;
```

其中最内层的子查询我们将其命名为 productSum，这条语句根据 product_type 分组并查询个数，第二层查询中将个数为 4 的商品查询出来，最外层查询 product_type 和 cnt_product 两列。 
 
**虽然嵌套子查询可以查询出结果，但是随着子查询嵌套的层数的叠加，SQL 语句不仅会难以理解而且执行效率也会很差，所以要尽量避免这样的使用。**

### 3.2.4 标量子查询

标量就是单一的意思，那么标量子查询也就是单一的子查询，那什么叫做单一的子查询呢？

所谓单一就是要求我们执行的 SQL 语句只能返回一个值，也就是要返回表中具体的 **某一行的某一列**。例如我们有下面这样一张表

```sql
product_id | product_name | sale_price 
------------+-------------+----------
0003       | 运动 T 恤     | 4000 
0004       | 菜刀          | 3000 
0005       | 高压锅        | 6800
```

那么我们执行一次标量子查询后是要返回类似于，“0004”，“菜刀”这样的结果。

### 3.2.5 标量子查询有什么用

我们现在已经知道标量子查询可以返回一个值了，那么它有什么作用呢？

直接这样想可能会有些困难，让我们看几个具体的需求：

1.  查询出销售单价高于平均销售单价的商品
2.  查询出注册日期最晚的那个商品

你有思路了吗？

让我们看如何通过标量子查询语句查询出销售单价高于平均销售单价的商品。

```sql
SELECT product_id, product_name, sale_price
FROM product
WHERE sale_price > (
    SELECT AVG(sale_price) FROM product
);
```

上面的这条语句首先后半部分查询出 product 表中的平均售价，前面的 SQL 语句在根据 WHERE 条件挑选出合适的商品。  
由于标量子查询的特性，导致标量子查询不仅仅局限于 WHERE 子句中，通常任何可以使用单一值的位置都可以使用。也就是说， 能够使用常数或者列名的地方，无论是 SELECT 子句、GROUP BY 子句、HAVING 子句，还是 ORDER BY 子句，几乎所有的地方都可以使用。

我们还可以这样使用标量子查询：

```sql
SELECT product_id,
       product_name,
       sale_price,
       (SELECT AVG(sale_price) FROM product) AS avg_price
FROM product;
```

你能猜到这段代码的运行结果是什么吗？运行一下看看与你想象的结果是否一致。

### 3.2.6 关联子查询

* 什么是关联子查询

关联子查询既然包含关联两个字那么一定意味着查询与子查询之间存在着联系。这种联系是如何建立起来的呢？

我们先看一个例子：

```sql
SELECT product_type, product_name, sale_price
FROM product AS p1
WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product AS p2
                    WHERE p1.product_type = p2.product_type
                    GROUP BY product_type);
```

你能理解这个例子在做什么操作么？先来看一下这个例子的执行结果 

![CdgEqS](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/CdgEqS.jpg)

通过上面的例子我们大概可以猜到吗，关联子查询就是通过一些标志将内外两层的查询连接起来起到过滤数据的目的，接下来我们就一起看一下关联子查询的具体内容吧。

* 关联子查询与子查询的联系

还记得我们之前的那个例子么 ` 查询出销售单价高于平均销售单价的商品 `，这个例子的 SQL 语句如下

```sql
SELECT product_id, product_name, sale_price
FROM product
WHERE sale_price > (SELECT AVG(sale_price) FROM product);
```

我们再来看一下这个需求 ` 选取出各商品种类中高于该商品种类的平均销售单价的商品 `。SQL 语句如下：

```sql
SELECT product_type, product_name, sale_price
FROM product AS p1
WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product AS p2
                    WHERE p1.product_type =p2.product_type
                    GROUP BY product_type);
```

可以看出上面这两个语句的区别吗？  
在第二条 SQL 语句也就是关联子查询中我们将外面的 product 表标记为 p1，将内部的 product 设置为 p2，而且通过 WHERE 语句连接了两个查询。

但是如果刚接触的话一定会比较疑惑关联查询的执行过程，这里有一个 [博客](https://zhuanlan.zhihu.com/p/41844742) 讲的比较清楚。在这里我们简要的概括为：

1.  首先执行不带 WHERE 的主查询
2.  根据主查询讯结果匹配 product_type，获取子查询结果
3.  将子查询结果再与主查询结合执行完整的 SQL 语句

*在子查询中像标量子查询，嵌套子查询或者关联子查询可以看作是子查询的一种操作方式即可。*

## 小结

视图和子查询是数据库操作中较为基础的内容，对于一些复杂的查询需要使用子查询加一些条件语句组合才能得到正确的结果。但是无论如何对于一个 SQL 语句来说都不应该设计的层数非常深且特别复杂，不仅可读性差而且执行效率也难以保证，所以尽量有简洁的语句来完成需要的功能。

## 练习题 - 第一部分

### 练习 3.1

创建出满足下述三个条件的视图（视图名称为 ViewPractice5_1）。使用 product（商品）表作为参照表，假设表中包含初始状态的 8 行数据。

* 条件 1：销售单价大于等于 1000 日元。
* 条件 2：登记日期是 2009 年 9 月 20 日。
* 条件 3：包含商品名称、销售单价和登记日期三列。

对该视图执行 SELECT 语句的结果如下所示。

```sql
SELECT * FROM ViewPractice5_1;
```

执行结果

```sql
product_name | sale_price | regist_date
--------------+------------+------------
T 恤衫        | 　 1000    | 2009-09-20
菜刀          |    3000    | 2009-09-20
```


```sql
-- 创建视图的语句
CREATE VIEW ViewPractice5_1 AS
SELECT product_name, sale_price, regist_date
FROM product
WHERE sale_price >= 1000 AND regist_date = '2009-09-20';
```

### 练习 3.2

向习题一中创建的视图 ViewPractice5_1 中插入如下数据，会得到什么样的结果呢？

```sql
INSERT INTO ViewPractice5_1 VALUES ('刀子', 300, '2009-11-02');
```

![8YkZMk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/8YkZMk.png)

### 练习 3.3

请根据如下结果编写 SELECT 语句，其中 sale_price_all 列为全部商品的平均销售单价。

```sql
product_id | product_name | product_type | sale_price | sale_price_all
------------+-------------+--------------+------------+---------------------
0001       | T 恤衫        | 衣服         | 1000       | 2097.5000000000000000
0002       | 打孔器        | 办公用品      | 500        | 2097.5000000000000000
0003       | 运动 T 恤     | 衣服          | 4000      | 2097.5000000000000000
0004       | 菜刀          | 厨房用具      | 3000       | 2097.5000000000000000
0005       | 高压锅        | 厨房用具      | 6800       | 2097.5000000000000000
0006       | 叉子          | 厨房用具      | 500        | 2097.5000000000000000
0007       | 擦菜板        | 厨房用具       | 880       | 2097.5000000000000000
0008       | 圆珠笔        | 办公用品       | 100       | 2097.5000000000000000
```

```sql
SELECT product_id,
       product_name,
       product_type,
       sale_price,
       (SELECT AVG(sale_price) FROM product) AS sale_price_all
FROM product;
```

### 练习 3.4

请根据习题一中的条件编写一条 SQL 语句，创建一幅包含如下数据的视图（名称为 AvgPriceByType）。

```sql
product_id | product_name | product_type | sale_price | avg_sale_price
------------+-------------+--------------+------------+---------------------
0001       | T 恤衫         | 衣服         | 1000       |2500.0000000000000000
0002       | 打孔器         | 办公用品     | 500        | 300.0000000000000000
0003       | 运动 T 恤      | 衣服        | 4000        |2500.0000000000000000
0004       | 菜刀          | 厨房用具      | 3000        |2795.0000000000000000
0005       | 高压锅         | 厨房用具     | 6800        |2795.0000000000000000
0006       | 叉子          | 厨房用具      | 500         |2795.0000000000000000
0007       | 擦菜板         | 厨房用具     | 880         |2795.0000000000000000
0008       | 圆珠笔         | 办公用品     | 100         | 300.0000000000000000
```

提示：其中的关键是 avg_sale_price 列。与习题三不同，这里需要计算出的 是各商品种类的平均销售单价。这与使用关联子查询所得到的结果相同。 也就是说，该列可以使用关联子查询进行创建。问题就是应该在什么地方使用这个关联子查询。


```sql
-- 创建视图的语句
CREATE VIEW AvgPriceByType AS
SELECT product_id,
       product_name,
       product_type,
       sale_price,
       (SELECT AVG(sale_price)
        FROM product p2
        WHERE p1.product_type = p2.product_type
        GROUP BY p1.product_type) AS avg_sale_price
FROM product p1;
 
-- 确认视图内容
SELECT * FROM AvgPriceByType;
```

## 3.3 各种各样的函数

SQL 自带了各种各样的函数，极大提高了 SQL 语言的便利性。

所谓函数，类似一个黑盒子，你给它一个输入值，它便按照预设的程序定义给出返回值，输入值称为 `参数`。

函数大致分为如下几类：

* 算术函数    （用来进行数值计算的函数）
* 字符串函数  （用来进行字符串操作的函数）
* 日期函数     （用来进行日期操作的函数）
* 转换函数     （用来转换数据类型和值的函数）
* 聚合函数     （用来进行数据聚合的函数）

函数总个数超过 200 个，不需要完全记住，常用函数有 30~50 个，其他不常用的函数使用时查阅文档即可。

### 3.3.1 算数函数

* `+ - * /` 四则运算在之前的章节介绍过，此处不再赘述。

为了演示其他的几个算数函数，在此构造 `samplemath` 表

```sql
-- DDL ：创建表
USE shop;
DROP TABLE IF EXISTS samplemath;
CREATE TABLE samplemath(
    m float(10,3),
    n INT,
    p INT
);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO samplemath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO samplemath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT; -- 提交事务

-- 查询表内容
SELECT * FROM samplemath;
+----------+------+------+
| m        | n    | p    |
+----------+------+------+
|  500.000 |    0 | NULL |
| -180.000 |    0 | NULL |
|     NULL | NULL | NULL |
|     NULL |    7 |    3 |
|     NULL |    5 |    2 |
|     NULL |    4 | NULL |
|    8.000 | NULL |    3 |
|    2.270 |    1 | NULL |
|    5.555 |    2 | NULL |
|     NULL |    1 | NULL |
|    8.760 | NULL | NULL |
+----------+------+------+
11 rows in set (0.00 sec)
```

* ABS – 绝对值

    语法：`ABS(数值)`
    
    ABS 函数用于计算一个数字的绝对值，表示一个数到原点的距离。
    当 ABS 函数的参数为 `NULL` 时，返回值也是 `NULL`。

* MOD – 求余数

    语法：`MOD(被除数，除数)`
    
    MOD 是计算除法余数（求余）的函数，是 modulo 的缩写。小数没有余数的概念，只能对整数列求余数。
    注意：主流的 DBMS 都支持 MOD 函数，只有 SQL Server 不支持该函数，其使用 `%` 符号来计算余数。

* ROUND – 四舍五入

    语法：`ROUND(对象数值，保留小数的位数)`
    
    ROUND 函数用来进行四舍五入操作。
    注意：当参数 **保留小数的位数** 为变量时，可能会遇到错误，请谨慎使用变量。

```sql
SELECT 
m,
ABS(m) AS abs_col ,
n, 
p,
MOD(n, p) AS mod_col,
ROUND(m,1) AS round_colS
FROM samplemath;
+----------+---------+------+------+---------+-----------+
| m        | abs_col | n    | p    | mod_col | round_col |
+----------+---------+------+------+---------+-----------+
|  500.000 | 500.000 |    0 | NULL |    NULL |     500.0 |
| -180.000 | 180.000 |    0 | NULL |    NULL |    -180.0 |
|     NULL |    NULL | NULL | NULL |    NULL |      NULL |
|     NULL |    NULL |    7 |    3 |       1 |      NULL |
|     NULL |    NULL |    5 |    2 |       1 |      NULL |
|     NULL |    NULL |    4 | NULL |    NULL |      NULL |
|    8.000 |   8.000 | NULL |    3 |    NULL |       8.0 |
|    2.270 |   2.270 |    1 | NULL |    NULL |       2.3 |
|    5.555 |   5.555 |    2 | NULL |    NULL |       5.6 |
|     NULL |    NULL |    1 | NULL |    NULL |      NULL |
|    8.760 |   8.760 | NULL | NULL |    NULL |       8.8 |
+----------+---------+------+------+---------+-----------+
11 rows in set (0.08 sec)
```

### 3.3.2 字符串函数

字符串函数也经常被使用，为了学习字符串函数，在此我们构造 `samplestr` 表。

```sql
-- DDL ：创建表
USE  shop;

DROP TABLE IF EXISTS samplestr;
CREATE TABLE samplestr(
    str1 VARCHAR (40),
    str2 VARCHAR (40),
    str3 VARCHAR (40)
);

-- DML：插入数据
START TRANSACTION;
INSERT INTO samplestr (str1, str2, str3) VALUES ('opx',	'rt', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('太阳',	'月亮', '火星');
INSERT INTO samplestr (str1, str2, str3) VALUES ('aaa',	NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES (NULL, 'xyz', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc 哈哈',  'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('abcdefabc', 'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('micmic', 'i', 'I');
COMMIT;
-- 确认表中的内容
SELECT * FROM samplestr;
+-----------+------+------+
| str1      | str2 | str3 |
+-----------+------+------+
| opx       | rt   | NULL |
| abc       | def  | NULL |
| 太阳       | 月亮 | 火星 |
| aaa       | NULL | NULL |
| NULL      | xyz  | NULL |
| @!#$%     | NULL | NULL |
| ABC       | NULL | NULL |
| aBC       | NULL | NULL |
| abc 哈哈   | abc  | ABC  |
| abcdefabc | abc  | ABC  |
| micmic    | i    | I    |
+-----------+------+------+
11 rows in set (0.00 sec)
```

* CONCAT – 拼接

    语法：`CONCAT(str1, str2, str3)`
    
    MySQL 中使用 CONCAT 函数进行拼接。

* LENGTH – 字符串长度

    语法：`LENGTH(字符串)`

* LOWER – 小写转换

    LOWER 函数只能针对英文字母使用，它会将参数中的字符串全都转换为小写。该函数不适用于英文字母以外的场合，不影响原本就是小写的字符。 类似的， UPPER 函数用于大写转换。

* REPLACE – 字符串的替换

    语法：`REPLACE(对象字符串，替换前的字符串，替换后的字符串)`

* SUBSTRING – 字符串的截取

    语法：`SUBSTRING （对象字符串 FROM 截取的起始位置 FOR 截取的字符数）`

    使用 SUBSTRING 函数 可以截取出字符串中的一部分字符串。截取的起始位置从字符串最左侧开始计算，索引值起始为 1。

![SbhU5q](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/SbhU5q.jpg)

* **（扩展内容）SUBSTRING_INDEX – 字符串按索引截取**

    语法：`SUBSTRING_INDEX (原始字符串， 分隔符，n)`

    该函数用来获取原始字符串按照分隔符分割后，第 n 个分隔符之前（或之后）的子字符串，支持正向和反向索引，索引起始值分别为 1 和 -1。

```sql
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2);
+------------------------------------------+
| SUBSTRING_INDEX('www.mysql.com', '.', 2) |
+------------------------------------------+
| www.mysql                                |
+------------------------------------------+
1 row in set (0.00 sec)
SELECT SUBSTRING_INDEX('www.mysql.com', '.', -2);
+-------------------------------------------+
| SUBSTRING_INDEX('www.mysql.com', '.', -2) |
+-------------------------------------------+
| mysql.com                                 |
+-------------------------------------------+
1 row in set (0.00 sec)
```

获取第 1 个元素比较容易，获取第 2 个元素 / 第 n 个元素可以采用二次拆分的写法。

```sql
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 1);
+------------------------------------------+
| SUBSTRING_INDEX('www.mysql.com', '.', 1) |
+------------------------------------------+
| www                                      |
+------------------------------------------+
1 row in set (0.00 sec)
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('www.mysql.com', '.', 2), '.', -1);
+--------------------------------------------------------------------+
| SUBSTRING_INDEX(SUBSTRING_INDEX('www.mysql.com', '.', 2), '.', -1) |
+--------------------------------------------------------------------+
| mysql                                                              |
+--------------------------------------------------------------------+
1 row in set (0.00 sec)
```

### 3.3.3 日期函数

不同 DBMS 的日期函数语法各有不同，本课程介绍一些被标准 SQL 承认的可以应用于绝大多数 DBMS 的函数。特定 DBMS 的日期函数查阅文档即可。

* CURRENT_DATE – 获取当前日期

```sql
SELECT CURRENT_DATE;
+--------------+
| CURRENT_DATE |
+--------------+
| 2020-08-08   |
+--------------+
1 row in set (0.00 sec)
```

* CURRENT_TIME – 当前时间

```sql
SELECT CURRENT_TIME;
+--------------+
| CURRENT_TIME |
+--------------+
| 17:26:09     |
+--------------+
1 row in set (0.00 sec)
```

* CURRENT_TIMESTAMP – 当前日期和时间

```sql
SELECT CURRENT_TIMESTAMP;
+---------------------+
| CURRENT_TIMESTAMP   |
+---------------------+
| 2020-08-08 17:27:07 |
+---------------------+
1 row in set (0.00 sec)
```

* EXTRACT – 截取日期元素

    语法：`EXTRACT(日期元素 FROM 日期)`

    使用 EXTRACT 函数可以截取出日期数据中的一部分，例如“年”，“月”，或者“小时”“秒”等。该函数的返回值并不是日期类型而是数值类型

```sql
SELECT CURRENT_TIMESTAMP AS now,
EXTRACT(YEAR   FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH  FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY    FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR   FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS MINute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;
+---------------------+------+-------+------+------+--------+--------+
| now                 | year | month | day  | hour | MINute | second |
+---------------------+------+-------+------+------+--------+--------+
| 2020-08-08 17:34:38 | 2020 |     8 |    8 |   17 |     34 |     38 |
+---------------------+------+-------+------+------+--------+--------+
1 row in set (0.00 sec)
```

### 3.3.4 转换函数

“转换”这个词的含义非常广泛，在 SQL 中主要有两层意思：一是数据类型的转换，简称为类型转换，在英语中称为 `cast`；另一层意思是值的转换。

* CAST – 类型转换

    语法：`CAST（转换前的值 AS 想要转换的数据类型）`

```sql
-- 将字符串类型转换为数值类型
SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;
+---------+
| int_col |
+---------+
|       1 |
+---------+
1 row in set (0.00 sec)
-- 将字符串类型转换为日期类型
SELECT CAST('2009-12-14' AS DATE) AS date_col;
+------------+
| date_col   |
+------------+
| 2009-12-14 |
+------------+
1 row in set (0.00 sec)
```

* COALESCE – 将 NULL 转换为其他值

    语法：`COALESCE(数据 1，数据 2，数据 3……)`

    COALESCE 是 SQL 特有的函数。该函数会返回可变参数 A 中左侧开始第 1 个不是 NULL 的值。参数个数是可变的，因此可以根据需要无限增加。

    在 SQL 语句中将 NULL 转换为其他值时就会用到转换函数。

```sql
SELECT 
COALESCE(NULL, 11) AS col_1,
COALESCE(NULL, 'hello world', NULL) AS col_2,
COALESCE(NULL, NULL, '2020-11-01') AS col_3;
+-------+-------------+------------+
| col_1 | col_2       | col_3      |
+-------+-------------+------------+
|    11 | hello world | 2020-11-01 |
+-------+-------------+------------+
1 row in set (0.00 sec)
```


## 3.4 谓词

### 3.4.1 什么是谓词

谓词就是返回值为真值的函数。包括 `TRUE / FALSE / UNKNOWN`。
谓词主要有以下几个：

* LIKE
* BETWEEN
* IS NULL、IS NOT NULL
* IN
* EXISTS

### 3.4.2 LIKE 谓词 – 用于字符串的部分一致查询

当需要进行字符串的部分一致查询时需要使用该谓词。部分一致大体可以分为前方一致、中间一致和后方一致三种类型。
首先我们来创建一张表

```sql

-- DDL ：创建表
CREATE TABLE samplelike(
    strcol VARCHAR(6) NOT NULL,
    PRIMARY KEY (strcol)
);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO samplelike (strcol) VALUES ('abcddd');
INSERT INTO samplelike (strcol) VALUES ('dddabc');
INSERT INTO samplelike (strcol) VALUES ('abdddc');
INSERT INTO samplelike (strcol) VALUES ('abcdd');
INSERT INTO samplelike (strcol) VALUES ('ddabc');
INSERT INTO samplelike (strcol) VALUES ('abddc');
COMMIT; -- 提交事务

SELECT * FROM samplelike;
+--------+
| strcol |
+--------+
| abcdd  |
| abcddd |
| abddc  |
| abdddc |
| ddabc  |
| dddabc |
+--------+
6 rows in set (0.00 sec)
```

* 前方一致：选取出“dddabc”

前方一致即作为查询条件的字符串（这里是“ddd”）与查询对象字符串起始部分相同。

```sql
SELECT *
FROM samplelike
WHERE strcol LIKE 'ddd%';
+--------+
| strcol |
+--------+
| dddabc |
+--------+
1 row in set (0.00 sec)
```

其中的 `%` 是代表“零个或多个任意字符串”的特殊符号，本例中代表“以 ddd 开头的所有字符串”。

* 中间一致：选取出“abcddd”,“dddabc”,“abdddc”

中间一致即查询对象字符串中含有作为查询条件的字符串，无论该字符串出现在对象字符串的最后还是中间都没有关系。

```sql
SELECT *
FROM samplelike
WHERE strcol LIKE '%ddd%';
+--------+
| strcol |
+--------+
| abcddd |
| abdddc |
| dddabc |
+--------+
3 rows in set (0.00 sec)
```

* 后方一致：选取出“abcddd“

后方一致即作为查询条件的字符串（这里是“ddd”）与查询对象字符串的末尾部分相同。

```sql
SELECT *
FROM samplelike
WHERE strcol LIKE '%ddd';
+--------+
| strcol |
+--------+
| abcddd |
+--------+
1 row in set (0.00 sec)
```

综合如上三种类型的查询可以看出，查询条件最宽松，也就是能够取得最多记录的是 ` 中间一致 `。这是因为它同时包含前方一致和后方一致的查询结果。

* `_` 下划线匹配任意 1 个字符

使用 _（下划线）来代替 %，与 % 不同的是，它代表了“任意 1 个字符”。

```sql
SELECT *
FROM samplelike
WHERE strcol LIKE 'abc__';
+--------+
| strcol |
+--------+
| abcdd  |
+--------+
1 row in set (0.00 sec)
```

### 3.4.3 BETWEEN 谓词 – 用于范围查询

使用 BETWEEN 可以进行范围查询。该谓词与其他谓词或者函数的不同之处在于它使用了 3 个参数。

```sql
-- 选取销售单价为 100～ 1000 元的商品
SELECT product_name, sale_price
FROM product
WHERE sale_price BETWEEN 100 AND 1000;
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| T 恤          |       1000 |
| 打孔器       |        500 |
| 叉子         |        500 |
| 擦菜板       |        880 |
| 圆珠笔       |        100 |
+--------------+------------+
5 rows in set (0.00 sec)
```

BETWEEN 的特点就是结果中会包含 100 和 1000 这两个临界值，也就是 **闭区间**。如果不想让结果中包含临界值，那就必须使用 < 和 >。

```sql
SELECT product_name, sale_price
FROM product
WHERE sale_price > 100
AND sale_price < 1000;
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 打孔器       |        500 |
| 叉子         |        500 |
| 擦菜板       |        880 |
+--------------+------------+
3 rows in set (0.00 sec)
```

### 3.4.4 IS NULL、 IS NOT NULL – 用于判断是否为 NULL

为了选取出某些值为 NULL 的列的数据，不能使用 =，而只能使用特定的谓词 IS NULL。

```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price IS NULL;
+--------------+----------------+
| product_name | purchase_price |
+--------------+----------------+
| 叉子         |           NULL |
| 圆珠笔       |           NULL |
+--------------+----------------+
2 rows in set (0.00 sec)
```

与此相反，想要选取 NULL 以外的数据时，需要使用 `IS NOT NULL`。

```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price IS NOT NULL;
+--------------+----------------+
| product_name | purchase_price |
+--------------+----------------+
| T 恤          |            500 |
| 打孔器       |            320 |
| 运动 T 恤      |           2800 |
| 菜刀         |           2800 |
| 高压锅       |           5000 |
| 擦菜板       |            790 |
+--------------+----------------+
6 rows in set (0.00 sec)
```

### 3.4.5 IN 谓词 – OR 的简便用法

多个查询条件取并集时可以选择使用 `or` 语句。

```sql
-- 通过 OR 指定多个进货单价进行查询
SELECT product_name, purchase_price
FROM product
WHERE purchase_price = 320
OR purchase_price = 500
OR purchase_price = 5000;
+--------------+----------------+
| product_name | purchase_price |
+--------------+----------------+
| T 恤        |            500 |
| 打孔器       |            320 |
| 高压锅       |           5000 |
+--------------+----------------+
3 rows in set (0.00 sec)
```

虽然上述方法没有问题，但还是存在一点不足之处，那就是随着希望选取的对象越来越多， SQL 语句也会越来越长，阅读起来也会越来越困难。这时， 我们就可以使用 IN 谓词  
`IN(值 1, 值 2, 值 3, …) 来替换上述 SQL 语句。

```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price IN (320, 500, 5000);
+--------------+----------------+
| product_name | purchase_price |
+--------------+----------------+
| T 恤        |            500 |
| 打孔器       |            320 |
| 高压锅       |           5000 |
+--------------+----------------+
3 rows in set (0.00 sec)
```

上述语句简洁了很多，可读性大幅提高。  
反之，希望选取出“进货单价不是 320 元、 500 元、 5000 元”的商品时，可以使用否定形式 NOT IN 来实现。

```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price NOT IN (320, 500, 5000);
+--------------+----------------+
| product_name | purchase_price |
+--------------+----------------+
| 运动 T 恤    |           2800 |
| 菜刀         |           2800 |
| 擦菜板       |            790 |
+--------------+----------------+
3 rows in set (0.00 sec)
```

需要注意的是，在使用 IN 和 NOT IN 时是无法选取出 NULL 数据的。  
实际结果也是如此，上述两组结果中都不包含进货单价为 NULL 的叉子和圆珠笔。 NULL 只能使用 IS NULL 和 IS NOT NULL 来进行判断。


### 3.4.6 使用子查询作为 IN 谓词的参数

* IN 和子查询

IN 谓词（NOT IN 谓词）具有其他谓词所没有的用法，那就是可以使用子查询作为其参数。我们已经在前面的章节中学习过了，子查询就是 SQL 内部生成的表，因此也可以说“能够将表作为 IN 的参数”。同理，我们还可以说“能够将视图作为 IN 的参数”。

在此，我们创建一张新表 `shopproduct` 显示出哪些商店销售哪些商品。

```sql
-- DDL ：创建表
DROP TABLE IF EXISTS shopproduct;

CREATE TABLE shopproduct(
    shop_id CHAR(4)     NOT NULL,
    shop_name VARCHAR(200) NOT NULL,
    product_id CHAR(4)      NOT NULL,
    quantity INTEGER      NOT NULL,
    PRIMARY KEY (shop_id, product_id) -- 指定主键
);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000A', '东京', '0001', 30);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000A', '东京', '0002', 50);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000A', '东京', '0003', 15);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000B', '名古屋', '0002', 30);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000B', '名古屋', '0003', 120);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000B', '名古屋', '0004', 20);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000B', '名古屋', '0006', 10);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000B', '名古屋', '0007', 40);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000C', '大阪', '0003', 20);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000C', '大阪', '0004', 50);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000C', '大阪', '0006', 90);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000C', '大阪', '0007', 70);
INSERT INTO shopproduct (shop_id, shop_name, product_id, quantity) 
VALUES ('000D', '福冈', '0001', 100);
COMMIT; -- 提交事务
SELECT * FROM shopproduct;
+---------+-----------+------------+----------+
| shop_id | shop_name | product_id | quantity |
+---------+-----------+------------+----------+
| 000A    | 东京      | 0001       |       30 |
| 000A    | 东京      | 0002       |       50 |
| 000A    | 东京      | 0003       |       15 |
| 000B    | 名古屋    | 0002       |       30 |
| 000B    | 名古屋    | 0003       |      120 |
| 000B    | 名古屋    | 0004       |       20 |
| 000B    | 名古屋    | 0006       |       10 |
| 000B    | 名古屋    | 0007       |       40 |
| 000C    | 大阪      | 0003       |       20 |
| 000C    | 大阪      | 0004       |       50 |
| 000C    | 大阪      | 0006       |       90 |
| 000C    | 大阪      | 0007       |       70 |
| 000D    | 福冈      | 0001       |      100 |
+---------+-----------+------------+----------+
13 rows in set (0.00 sec)
```

由于单独使用商店编号（shop_id）或者商品编号（product_id）不能区分表中每一行数据，因此指定了 2 列作为主键（primary key）对商店和商品进行组合，用来唯一确定每一行数据。

假设我么需要取出大阪在售商品的销售单价，该如何实现呢？

第一步，取出大阪门店的在售商品  `product_id`    ;

第二步，取出大阪门店在售商品的销售单价  `sale_price`

```sql
-- step1：取出大阪门店的在售商品 `product_id`
SELECT product_id
FROM shopproduct
WHERE shop_id = '000C';
+------------+
| product_id |
+------------+
| 0003       |
| 0004       |
| 0006       |
| 0007       |
+------------+
4 rows in set (0.00 sec)
```

上述语句取出了大阪门店的在售商品编号，接下来，我么可以使用上述语句作为第二步的查询条件来使用了。

```sql
-- step2：取出大阪门店在售商品的销售单价 `sale_price`
SELECT product_name, sale_price
FROM product
WHERE product_id IN (SELECT product_id
                     FROM shopproduct
                     WHERE shop_id = '000C');
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 运动 T 恤    |       4000 |
| 菜刀         |       3000 |
| 叉子         |        500 |
| 擦菜板       |        880 |
+--------------+------------+
4 rows in set (0.00 sec)
```

根据前面章节学习的知识，子查询是从最内层开始执行的（由内而外），因此，上述语句的子查询执行之后，SQL 展开成下面的语句

```sql
-- 子查询展开后的结果
SELECT product_name, sale_price
FROM product
WHERE product_id IN ('0003', '0004', '0006', '0007');
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 运动 T 恤      |       4000 |
| 菜刀         |       3000 |
| 叉子         |        500 |
| 擦菜板       |        880 |
+--------------+------------+
4 rows in set (0.00 sec)
```

可以看到，子查询转换之后变为 in 谓词用法，你理解了吗？  
或者，你会疑惑既然 in 谓词也能实现，那为什么还要使用子查询呢？这里给出两点原因：

1. 实际生活中，某个门店的在售商品是不断变化的，使用 in 谓词就需要经常更新 SQL 语句，降低了效率，提高了维护成本；

2. 实际上，某个门店的在售商品可能有成百上千个，手工维护在售商品编号真是个大工程。

使用子查询即可保持 SQL 语句不变，极大提高了程序的可维护性，这是系统开发中需要重点考虑的内容。

* NOT IN 和子查询

NOT IN 同样支持子查询作为参数，用法和 in 完全一样。

```sql
-- NOT IN 使用子查询作为参数，取出未在大阪门店销售的商品的销售单价
SELECT product_name, sale_price
FROM product
WHERE product_id NOT IN (SELECT product_id
                         FROM shopproduct
                         WHERE shop_id = '000A');
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 菜刀         |       3000 |
| 高压锅       |       6800 |
| 叉子         |        500 |
| 擦菜板       |        880 |
| 圆珠笔       |        100 |
+--------------+------------+
5 rows in set (0.00 sec)
```

### 3.4.7 EXIST 谓词

EXIST 谓词的用法理解起来有些难度。

1. EXIST 的使用方法与之前的都不相同

2. 语法理解起来比较困难

3. 实际上即使不使用 EXIST，基本上也都可以使用 IN（或者 NOT IN）来代替

这么说的话，还有学习 EXIST 谓词的必要吗？答案是肯定的，因为一旦能够熟练使用 EXIST 谓词，就能体会到它极大的便利性。

不过，你不用过于担心，本课程介绍一些基本用法，日后学习时可以多多留意 EXIST 谓词的用法，以期能够在达到 SQL 中级水平时掌握此用法。

* EXIST 谓词的使用方法

谓词的作用就是 **“判断是否存在满足某种条件的记录”**。

如果存在这样的记录就返回真（TRUE），如果不存在就返回假（FALSE）。

EXIST（存在）谓词的主语是“记录”。

我们继续以 IN 和子查询 中的示例，使用 EXIST 选取出大阪门店在售商品的销售单价。

```sql
SELECT product_name, sale_price
FROM product AS p
WHERE EXISTS (SELECT *
              FROM shopproduct AS sp
              WHERE sp.shop_id = '000C'
                    AND sp.product_id = p.product_id
              );
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 运动 T 恤     |       4000 |
| 菜刀         |       3000 |
| 叉子         |        500 |
| 擦菜板        |        880 |
+--------------+------------+
4 rows in set (0.00 sec)
```

* EXIST 的参数

之前我们学过的谓词，基本上都是像“列 LIKE 字符串”或者“ 列 BETWEEN 值 1 AND 值 2”这样需要指定 2 个以上的参数，而 EXIST 的左侧并没有任何参数。因为 EXIST 是只有 1 个参数的谓词。 所以，EXIST 只需要在右侧书写 1 个参数，该参数通常都会是一个子查询。

```sql
(SELECT *
 FROM shopproduct AS sp
 WHERE sp.shop_id = '000C'
       AND sp.product_id = p.product_id)
```

上面这样的子查询就是唯一的参数。确切地说，由于通过条件 “SP.product_id = P.product_id” 将 product 表和 shopproduct 表进行了联接，因此作为参数的是关联子查询。 EXIST 通常会使用关联子查询作为参数。

* 子查询中的 SELECT

由于 EXIST 只关心记录是否存在，因此返回哪些列都没有关系。 EXIST 只会判断是否存在满足子查询中 WHERE 子句指定的条件“商店编号（shop_id）为 '000C'，商品（product）表和商店商品（shopproduct）表中商品编号（product_id）相同”的记录，只有存在这样的记录时才返回真（TRUE）。

因此，使用下面的查询语句，查询结果也不会发生变化。

```sql
SELECT product_name, sale_price
FROM product AS p
WHERE EXISTS (SELECT 1 -- 这里可以书写适当的常数
              FROM shopproduct AS sp
              WHERE sp.shop_id = '000C'
                  AND sp.product_id = p.product_id);
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 运动 T 恤    |       4000 |
| 菜刀         |       3000 |
| 叉子         |        500 |
| 擦菜板       |        880 |
+--------------+------------+
4 rows in set (0.00 sec)
```

> 大家可以把在 EXIST 的子查询中书写 SELECT * 当作 SQL 的一种习惯。

* 使用 NOT EXIST 替换 NOT IN

就像 EXIST 可以用来替换 IN 一样， NOT IN 也可以用 NOT EXIST 来替换。

下面的代码示例取出，不在大阪门店销售的商品的销售单价。

```sql
SELECT product_name, sale_price
FROM product AS p
WHERE NOT EXISTS (SELECT *
                  FROM shopproduct AS sp
                  WHERE sp.shop_id = '000A'
                      AND sp.product_id = p.product_id);
+--------------+------------+
| product_name | sale_price |
+--------------+------------+
| 菜刀         |       3000 |
| 高压锅       |       6800 |
| 叉子         |        500 |
| 擦菜板       |        880 |
| 圆珠笔       |        100 |
+--------------+------------+
5 rows in set (0.00 sec)
```

NOT EXIST 与 EXIST 相反，当 “不存在” 满足子查询中指定条件的记录时返回真（TRUE）。

## 3.5 CASE 表达式

### 3.5.1 什么是 CASE 表达式？

CASE 表达式是函数的一种，是 SQL 中数一数二的重要功能，有必要好好学习一下。

CASE 表达式是在区分情况时使用的，这种情况的区分在编程中通常称为（条件）分支。

CASE 表达式的语法分为简单 CASE 表达式和搜索 CASE 表达式两种。由于搜索 CASE 表达式包含简单 CASE 表达式的全部功能。本课程将重点介绍搜索 CASE 表达式。

语法：

```sql
CASE WHEN < 求值表达式 > THEN < 表达式 >
     WHEN < 求值表达式 > THEN < 表达式 >
     WHEN < 求值表达式 > THEN < 表达式 >
     .
     .
     .
ELSE < 表达式 >
END
```

上述语句执行时，依次判断 when 表达式是否为真值，是则执行 THEN 后的语句，如果所有的 when 表达式均为假，则执行 ELSE 后的语句。  
无论多么庞大的 CASE 表达式，最后也只会返回一个值。


### 3.5.2 CASE 表达式的使用方法

假设现在 要实现如下结果：

```sql
A ：衣服
B ：办公用品
C ：厨房用具
```

因为表中的记录并不包含“A ： ”或者“B ： ”这样的字符串，所以需要在 SQL 中进行添加。并将“A ： ”“B ： ”“C ： ”与记录结合起来。

* **应用场景 1：根据不同分支得到不同列值**

```sql
SELECT  product_name,
        CASE 
            WHEN product_type = '衣服'     THEN CONCAT('A ：',product_type)
            WHEN product_type = '办公用品'  THEN CONCAT('B ：',product_type)
            WHEN product_type = '厨房用具'  THEN CONCAT('C ：',product_type)
            ELSE NULL
        END 
        
        AS abc_product_type
FROM  product;
+--------------+------------------+
| product_name | abc_product_type |
+--------------+------------------+
| T 恤          | A ： 衣服        |
| 打孔器         | B ： 办公用品    |
| 运动 T 恤      | A ： 衣服        |
| 菜刀           | C ： 厨房用具    |
| 高压锅         | C ： 厨房用具    |
| 叉子           | C ： 厨房用具    |
| 擦菜板         | C ： 厨房用具    |
| 圆珠笔         | B ： 办公用品    |
+--------------+------------------+
8 rows in set (0.00 sec)
```

ELSE 子句也可以省略不写，这时会被默认为 ELSE NULL。但为了防止有人漏读，还是希望大家能够显示地写出 ELSE 子句。  
此外， CASE 表达式最后的“END”是不能省略的，请大家特别注意不要遗漏。忘记书写 END 会发生语法错误，这也是初学时最容易犯的错误。

* **应用场景 2：实现列方向上的聚合**

通常我们使用如下代码实现行的方向上不同种类的聚合（这里是 sum）

```sql
SELECT product_type,
       SUM(sale_price) AS sum_price
FROM product
GROUP BY product_type;  
+--------------+-----------+
| product_type | sum_price |
+--------------+-----------+
| 衣服         |      5000 |
| 办公用品      |       600 |
| 厨房用具      |     11180 |
+--------------+-----------+
3 rows in set (0.00 sec)
```

假如要在列的方向上展示不同种类额聚合值，该如何写呢？

```sql
sum_price_clothes | sum_price_kitchen | sum_price_office
------------------+-------------------+-----------------
             5000 |             11180 |              600
```

聚合函数 + CASE WHEN 表达式即可实现该效果

```sql
-- 对按照商品种类计算出的销售单价合计值进行行列转换
SELECT 
        SUM(CASE WHEN product_type = '衣服' THEN sale_price ELSE 0 END)    AS sum_price_clothes,
        SUM(CASE WHEN product_type = '厨房用具' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
        SUM(CASE WHEN product_type = '办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
FROM product;
+-------------------+-------------------+------------------+
| sum_price_clothes | sum_price_kitchen | sum_price_office |
+-------------------+-------------------+------------------+
|              5000 |             11180 |              600 |
+-------------------+-------------------+------------------+
1 row in set (0.00 sec)
```

* **（扩展内容）应用场景 3：实现行转列**

假设有如下图表的结构

![yDRKCu](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/yDRKCu.jpg)

计划得到如下的图表结构

![ykwpCl](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/ykwpCl.jpg)


聚合函数 + CASE WHEN 表达式即可实现该转换

```sql
-- CASE WHEN 实现数字列 score 行转列
SELECT name,
       SUM(CASE WHEN subject = '语文' THEN score ELSE null END) as chinese,
       SUM(CASE WHEN subject = '数学' THEN score ELSE null END) as math,
       SUM(CASE WHEN subject = '外语' THEN score ELSE null END) as english
FROM score
GROUP BY name;
+------+---------+------+---------+
| name | chinese | math | english |
+------+---------+------+---------+
| 张三 |      93 |   88 |      91 |
| 李四 |      87 |   90 |      77 |
+------+---------+------+---------+
2 rows in set (0.00 sec)
```

上述代码实现了数字列 score 的行转列，也可以实现文本列 subject 的行转列

```sql
-- CASE WHEN 实现文本列 subject 行转列
SELECT name,
       MAX(CASE WHEN subject = '语文' THEN subject ELSE null END) as chinese,
       MAX(CASE WHEN subject = '数学' THEN subject ELSE null END) as math,
       MIN(CASE WHEN subject = '外语' THEN subject ELSE null END) as english
FROM score
GROUP BY name;
+------+---------+------+---------+
| name | chinese | math | english |
+------+---------+------+---------+
| 张三 | 语文    | 数学 | 外语    |
| 李四 | 语文    | 数学 | 外语    |
+------+---------+------+---------+
2 rows in set (0.00 sec
```

**总结：**

* **当待转换列为数字时，可以使用 `SUM AVG MAX MIN` 等聚合函数；**
* **当待转换列为文本时，可以使用 `MAX MIN` 等聚合函数**


## 练习题 - 第二部分

### 练习 3.5

运算或者函数中含有 NULL 时，结果全都会变为 NULL ？（判断题）

` 正确 `

### 练习 3.6

对本章中使用的 product（商品）表执行如下 2 条 SELECT 语句，能够得到什么样的结果呢？

1. 第一条
```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price NOT IN (500, 2800, 5000);
```

2. 第二条

```sql
SELECT product_name, purchase_price
FROM product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);
```

### 练习 3.7

按照销售单价（ sale_price）对练习 6.1 中的 product（商品）表中的商品进行如下分类。

* 低档商品：销售单价在 1000 日元以下（T 恤衫、办公用品、叉子、擦菜板、 圆珠笔）
* 中档商品：销售单价在 1001 日元以上 3000 日元以下（菜刀）
* 高档商品：销售单价在 3001 日元以上（运动 T 恤、高压锅）

请编写出统计上述商品种类中所包含的商品数量的 SELECT 语句，结果如下所示。

执行结果

```sql
low_price | mid_price | high_price
----------+-----------+------------
        5 |         1 |         2
```

```sql
SELECT 
SUM(CASE WHEN sale_price <= 1000 THEN 1 ELSE 0 END) AS low_price,

SUM(CASE WHEN sale_price BETWEEN 1001 AND 3000 THEN 1 ELSE 0 END) AS mid_price,

SUM(CASE WHEN sale_price >= 3001 THEN 1 ELSE 0 END) AS high_price

FROM product;
```

本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql
# Task04：集合运算 - 表的加减法和 join 等

[TOC]

## 4.1 表的加减法

### 4.1.1 什么是集合运算

` 集合 ` 在数学领域表示“各种各样的事物的总和”, 在数据库领域表示记录的集合. 具体来说, 表、视图和查询的执行结果都是记录的集合, 其中的元素为表或者查询结果中的每一行。

在标准 SQL 中, 分别对检索结果使用 `UNION`, `INTERSECT,` `EXCEPT` 来将检索结果进行**并**, **交**和**差**运算, 像 `UNION`,`INTERSECT`, `EXCEPT` 这种用来进行集合运算的运算符称为集合运算符。

以下的文氏图展示了几种集合的基本运算.

![图片](https://img.alicdn.com/imgextra/i4/O1CN01xPY2gv1XHKSEPPrqr_!!6000000002898-2-tps-500-375.png)

![图片](https://img.alicdn.com/imgextra/i1/O1CN016axpJu1zsi1SvV0eZ_!!6000000006770-2-tps-1156-951.png)

[图片来源于网络]

在数据库中, 所有的表–以及查询结果–都可以视为集合, 因此也可以把表视为集合进行上述集合运算, 在很多时候, 这种抽象非常有助于对复杂查询问题给出一个可行的思路.

### 4.1.2 表的加法–UNION

#### 4.1.2.1 UNION

建表代码及数据导入请使用第一章提供的代码.

接下来我们演示 UNION 的具体用法及查询结果:

```sql
SELECT product_id, product_name
FROM product

UNION

SELECT product_id, product_name
FROM product2;
```

上述结果包含了两张表中的全部商品. 你会发现, 这就是我们在学校学过的集合中的并集运算, 通过文氏图会看得更清晰（图 7-1):  

![KBkjh3](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/KBkjh3.jpg)

通过观察可以发现, 商品编号为“ 0001 ”~“ 0003 ”的 3 条记录在两个表中都存在, 因此大家可能会认为结果中会出现重复的记录, 但是 **UNION 等集合运算符通常都会除去重复的记录**.

上述查询是对不同的两张表进行求并集运算. 对于同一张表, 实际上也是可以进行求并集的.

**练习题**

假设连锁店想要增加毛利率超过 50% 或者售价低于 800 的货物的存货量, 请使用 UNION 对分别满足上述两个条件的商品的查询结果求并集.

结果应该类似于:

![LSIB81](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/LSIB81.jpg)

```sql
-- 参考答案:
SELECT  product_id,product_name,product_type
       ,sale_price,purchase_price
FROM product 
WHERE sale_price<800

UNION

SELECT  product_id,product_name,product_type
       ,sale_price,purchase_price
FROM product 
WHERE sale_price>1.5*purchase_price;
```

思考: 如果不使用 UNION 该怎么写查询语句?

```sql
-- 参考答案:
SELECT  product_id,product_name,product_type
       ,sale_price,purchase_price
FROM product 
WHERE sale_price < 800 
    OR sale_price > 1.5 * purchase_price;
```

#### 4.1.2.2 UNION 与 OR 谓词

对于上边的练习题, 如果你已经正确地写出来查询, 你会发现, 使用 UNION 对两个查询结果取并集, 和在一个查询中使用 WHERE 子句, 然后使用 OR 谓词连接两个查询条件, 能够得到相同的结果.

那么是不是就没必要引入 UNION 了呢? 当然不是这样的. 确实, 对于同一个表的两个不同的筛选结果集, 使用 UNION 对两个结果集取并集, 和把两个子查询的筛选条件用  OR 谓词连接, 会得到相同的结果, 但倘若要将两个不同的表中的结果合并在一起, 就不得不使用 UNION 了.

而且, 即便是对于同一张表, 有时也会出于查询效率方面的因素来使用 UNION.

**练习题**

分别使用 UNION 或者 OR 谓词, 找出毛利率不足 30% 或毛利率未知的商品.

参考答案:

```sql
-- 使用 OR 谓词
SELECT * 
FROM product 
WHERE sale_price / purchase_price < 1.3 
    OR sale_price / purchase_price IS NULL;
```

```sql
-- 使用 UNION
SELECT * 
FROM product 
WHERE sale_price / purchase_price < 1.3

UNION

SELECT * 
FROM product 
WHERE sale_price / purchase_price IS NULL;
```

#### 4.1.2.3 包含重复行的集合运算 UNION ALL

在 1.1.1 中我们发现, SQL 语句的 UNION 会对两个查询的结果集进行合并和去重, 这种去重不仅会去掉两个结果集相互重复的, 还会去掉一个结果集中的重复行. 但在实践中有时候需要不去重的并集, 在 UNION 的结果中保留重复行的语法其实非常简单, **只需要在 UNION 后面添加 ALL 关键字就可以了**.

例如,  想要知道 product 和 product2 中所包含的商品种类及每种商品的数量, 第一步, 就需要将两个表的商品种类字段选出来, 然后使用 UNION ALL 进行不去重地合并. 接下来再对两个表的结果按 product_type 字段分组计数.

```sql
-- 保留重复行
SELECT product_id, product_name
FROM product

UNION ALL

SELECT product_id, product_name
FROM product2;
```

查询结果如下:  

![k8RHuI](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/k8RHuI.jpg)

**练习题**

商店决定对 product 表中利润低于 50% 和售价低于 1000 的商品提价, 请使用 UNION ALL 语句将分别满足上述两个条件的结果取并集. 查询结果类似下表:

![UTv0WW](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/UTv0WW.jpg)

参考答案

```sql
SELECT * 
FROM product 
WHERE sale_price < 1000

UNION ALL

SELECT * 
FROM product 
WHERE sale_price > 1.5 * purchase_price
```

#### 4.1.2.4 [扩展阅读]bag 模型与 set 模型

在高中数学课上我们就学过, 集合的一个显著的特征就是集合中的元素都是互异的. 当我们把数据库中的表看作是集合的时候, 实际上存在一些问题的: 不论是有意的设计或无意的过失, 很多数据库中的表包含了重复的行.

Bag 是和 set 类似的一种数学结构, 不一样的地方在于: bag 里面允许存在重复元素, 如果同一个元素被加入多次, 则袋子里就有多个该元素.

通过上述 bag 与 set 定义之间的差别我们就发现, 使用 bag 模型来描述数据库中的表在很多时候更加合适.

是否允许元素重复导致了 set 和 bag 的并交差等运算都存在一些区别. 以 bag 的交为例, 由于 bag 允许元素重复出现, 对于两个 bag, 他们的并运算会按照: 
**1. 该元素是否至少在一个 bag 里出现过, 
2. 该元素在两个 bag 中的最大出现次数** 

这两个方面来进行计算. 因此对于 A = {1,1,1,2,3,5,7}, B = {1,1,2,2,4,6,8} 两个 bag, 它们的并就等于 {1,1,1,2,2,3,4,5,6,7,8}.

#### 4.1.2.5 隐式类型转换

通常来说, 我们会把类型完全一致, 并且代表相同属性的列使用 UNION 合并到一起显示, 但有时候, 即使数据类型不完全相同, 也会通过隐式类型转换来将两个类型不同的列放在一列里显示, 例如字符串和数值类型:

```sql
SELECT product_id, product_name, '1'
FROM product
UNION
SELECT product_id, product_name,sale_price
FROM product2;
```

上述查询能够正确执行, 得到如下结果:  

![mWBODL](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/mWBODL.jpg)

**练习题:**

使用 `SYSDATE()` 函数可以返回当前日期时间, 是一个日期时间类型的数据, 试测试该数据类型和数值, 字符串等类型的兼容性.

例如, 以下代码可以正确执行, 说明时间日期类型和字符串, 数值以及缺失值均能兼容.

```sql
SELECT SYSDATE(), SYSDATE(), SYSDATE()

UNION

SELECT 'chars', 123,  null
```

上述代码的查询结果:  

![8H8qY7](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/8H8qY7.jpg)

### 4.1.3 MySQL 8.0 不支持交运算 INTERSECT

集合的交, 就是两个集合的公共部分, 由于集合元素的互异性, 集合的交只需通过文氏图就可以很直观地看到它的意义.

虽然集合的交运算在 SQL 标准中已经出现多年了, 然而很遗憾的是, 截止到 MySQL 8.0 版本, MySQL 仍然不支持 INTERSECT 操作.

```sql
SELECT product_id, product_name
FROM product

INTERSECT

SELECT product_id, product_name
FROM product2
```

> 错误代码：1064  
> You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT product_id, product_name  
> FROM product2

#### 4.1.3.1 [扩展阅读]bag 的交运算

对于两个 bag, 他们的交运算会按照: 
1. 该元素是否同时属于两个 bag, 
2. 该元素在两个 bag 中的最小出现次数

这两个方面来进行计算. 因此对于 
`A = {1,1,1,2,3,5,7}, B = {1,1,2,2,4,6,8}` 两个 bag, 
它们的交运算结果就等于 {1,1,2}.

### 4.1.4 差集, 补集与表的减法

求集合差集的减法运算和实数的减法运算有些不同, 当使用一个集合 A 减去另一个集合 B 的时候, 对于只存在于集合 B 而不存在于集合 A 的元素, 采取直接忽略的策略, 因此集合 A 和 B 做减法只是将集合 A 中也同时属于集合 B 的元素减掉。

![sgdzba](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/sgdzba.jpg)

#### 4.1.4.1 MySQL 8.0 还不支持 EXCEPT 运算

MySQL 8.0 还不支持 表的减法运算符 EXCEPT. 不过, 借助第六章学过的 NOT IN 谓词, 我们同样可以实现表的减法.

**练习题 :**

找出只存在于 product 表但不存在于 product2 表的商品.

```sql
-- 使用 IN 子句的实现方法
SELECT * 
FROM product
WHERE product_id NOT IN (SELECT product_id 
                            FROM product2)
```

#### 4.1.4.2 EXCEPT 与 NOT 谓词

通过上述练习题的 MySQL 解法, 我们发现, 使用 NOT IN 谓词, 基本上可以实现和 SQL 标准语法中的 EXCEPT 运算相同的效果.

**练习题:**

使用 NOT 谓词进行集合的减法运算, 求出 product 表中, 售价高于 2000, 但利润低于 30% 的商品, 结果应该如下表所示.

![wZpXMd](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/wZpXMd.jpg)

参考答案:

```sql
SELECT * 
FROM product
WHERE sale_price > 2000 
   AND product_id NOT IN (
        SELECT product_id 
        FROM product 
        WHERE sale_price < 1.3*purchase_price)
```

#### 4.1.4.3 EXCEPT ALL 与 bag 的差

类似于 UNION ALL, EXCEPT ALL 也是按出现次数进行减法, 也是使用 bag 模型进行运算.

对于两个 bag, 他们的差运算会按照:

**1. 该元素是否属于作为被减数的 bag,**

**2. 该元素在两个 bag 中的出现次数**

这两个方面来进行计算. 只有属于被减数的 bag 的元素才参与 **EXCEP ALL** 运算, 并且差 bag 中的次数, 等于该元素在两个 bag 的出现次数之差(差为零或负数则不出现). 因此对于 `A = {1,1,1,2,3,5,7}, B = {1,1,2,2,4,6,8}` 两个 bag, 它们的差就等于 {1,3,5,7}.

#### 4.1.4.4 INTERSECT 与 AND 谓词

对于同一个表的两个查询结果而言, 他们的交 INTERSECT 实际上可以等价地将两个查询的检索条件用 AND 谓词连接来实现.

**练习题:**

使用 AND 谓词查找 product 表中利润率高于 50%, 并且售价低于 1500 的商品, 查询结果如下所示.

![moBLqf](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/moBLqf.jpg)

参考答案

```sql
SELECT * 
FROM product
WHERE sale_price > 1.5 * purchase_price 
   AND sale_price < 1500
```

### 4.1.5 对称差

两个集合 A,B 的对称差是指那些仅属于 A 或仅属于 B 的元素构成的集合. 对称差也是个非常基础的运算, 例如, 两个集合的交就可以看作是两个集合的并去掉两个集合的对称差. 上述方法在其他数据库里也可以用来简单地实现表或查询结果的对称差运算: 首先使用 UNION 求两个表的并集, 然后使用 INTERSECT 求两个表的交集, 然后用并集减去交集, 就得到了对称差.

但由于在 MySQL 8.0 里, 由于两个表或查询结果的并不能直接求出来, 因此并不适合使用上述思路来求对称差. 好在还有差集运算可以使用. 从直观上就能看出来, 两个集合的对称差等于 A-B 并上 B-A, 因此实践中可以用这个思路来求对称差.

**练习题:**

使用 product 表和 product2 表的对称差来查询哪些商品只在其中一张表, 结果类似于:

![Ujrzk2](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Ujrzk2.jpg)

提示: 使用 NOT IN 实现两个表的差集.

**参考答案:**

```sql
-- 使用 NOT IN 实现两个表的差集
SELECT * 
FROM product
WHERE product_id NOT IN (
    SELECT product_id FROM product2)

UNION

SELECT * 
FROM product2
WHERE product_id NOT IN (
    SELECT product_id FROM product)
```

#### 4.1.5.1 借助并集和差集迂回实现交集运算 INTERSECT

通过观察集合运算的文氏图, 我们发现, 两个集合的交可以看作是两个集合的并去掉两个集合的对称差。

![huNmct](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/huNmct.png)

## 4.2 连结(JOIN)

前一节我们学习了 UNION 和 INTERSECT 等集合运算, 这些集合运算的特征就是以行方向为单位进行操作. 通俗地说, 就是进行这些集合运算时, 会导致记录行数的增减. 使用 UNION 会增加记录行数, 而使用 INTERSECT 或者 EXCEPT 会减少记录行数.

但这些运算不能改变列的变化, 虽然使用函数或者 CASE 表达式等列运算, 可以增加列的数量, 但仍然只能从一张表中提供的基础信息列中获得一些 "引申列", 本质上并不能提供更多的信息. 如果想要从多个表获取信息, 例如, 如果我们想要找出某个商店里的衣服类商品的名称, 数量及价格等信息, 则必须分别从 shopproduct 表和 product 表获取信息.

![lYCXMM](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/lYCXMM.jpg)

> 注:  
> 截至目前, 本书中出现的示例 (除了关联子查询) 基本上都是从一张表中选取数据, 但实际上, 期望得到的数据往往会分散在不同的表之中, 这时候就需要使用连结了.  
> 之前在学习关联子查询时我们发现, 使用关联子查询也可以从其他表获取信息, 但 ** 连结 ** 更适合从多张表获取信息.

连结 (JOIN) 就是使用某种关联条件(一般是使用相等判断谓词 "="), 将其他表中的列添加过来, 进行“添加列”的集合运算. 可以说, 连结是 SQL 查询的核心操作, 掌握了连结, 能够从两张甚至多张表中获取列, 能够将过去使用关联子查询等过于复杂的查询简化为更加易读的形式, 以及进行一些更加复杂的查询.

SQL 中的连结有多种分类方法, 我们这里使用最基础的内连结和外连结的分类方法来分别进行讲解.

### 4.2.1 内连结(INNER JOIN)

内连结的语法格式是:

```sql
-- 内连结
FROM <tb_1> INNER JOIN <tb_2> ON <condition(s)>
```

其中 INNER 关键词表示使用了内连结, 至于内连结的涵义, 目前暂时可以不必细究.  
例如, 还是刚才那个问题:

找出某个商店里的衣服类商品的名称, 数量及价格等信息.

我们进一步把这个问题明确化:

找出东京商店里的衣服类商品的商品名称, 商品价格, 商品种类, 商品数量信息.

#### 4.2.1.1 使用内连结从两个表获取信息

我们先来分别观察所涉及的表,product 表保存了商品编号, 商品名称, 商品种类等信息, 这个表可以提供关于衣服种类的衣服的详细信息, 但是不能提供商店信息.

![Vft6MK](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Vft6MK.jpg)

我们接下来观察 shopproduct 表, 这个表里有商店编号名称, 商店的商品编号及数量. 但要想获取商品的种类及名称售价等信息, 则必须借助于 product 表.

![图片](https://img.alicdn.com/imgextra/i2/O1CN01xgPi7J1oEtox2dJly_!!6000000005194-2-tps-366-400.png)

所以问题的关键是, 找出一个类似于 "轴" 或者 "桥梁" 的公共列, 将两张表用这个列连结起来. 这就是连结运算所要作的事情.

我们来对比一下上述两张表, 可以发现, 商品编号列是一个公共列, 因此很自然的事情就是用这个商品编号列来作为连接的“桥梁”，将 **product** 和 **shopproduct** 这两张表连接起来。

![4yJRHd](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/4yJRHd.jpg)

> 注:  
> 如果你使用过 excel 的 vlookup 函数, 你会发现这个函数正好也能够实现这个功能. 实际上, 在思路上,  关联子查询更像是 vlookup 函数: 以表 A 为主表, 然后根据表 A 的关联列的每一行的取值, 逐个到表 B 中的关联列中去查找取值相等的行.  
> 当数据量较少时, 这种方式并不会有什么性能问题, 但数据量较大时, 这种方式将会导致较大的计算开销:  对于外部查询返回的每一行数据, 都会向内部的子查询传递一个关联列的值, 然后内部子查询根据传入的值执行一次查询然后返回它的查询结果. 这就使得, 例如外部主查询的返回结果有一万行, 那么子查询就会执行一万次, 这将会带来非常恐怖的时间消耗.

我们把上述问题进行分解:

首先, 找出每个商店的商店编号, 商店名称, 商品编号, 商品名称,  商品类别,  商品售价, 商品数量信息.

按照内连结的语法, 在 FROM 子句中使用 INNER JOIN 将两张表连接起来, 并为 ON 子句指定连结条件为 `shop_product.product_id=product.product_id`, 就得到了如下的查询语句:

```sql
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM shop_product AS SP
INNER JOIN product AS P
ON SP.product_id = P.product_id;
```

在上述查询中, 我们分别为两张表指定了简单的别名, 这种操作在使用连结时是非常常见的, 通过别名会让我们在编写查询时少打很多字, 并且更重要的是, 会让查询语句看起来更加简洁.  
上述查询将会得到如下的结果:

![4R8xit](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/4R8xit.jpg)

观察查询结果, 我们看到, 这个结果里的列已经包含了所有我们需要的信息.

关于内连结, 需要注意以下三点:

**要点一: 进行连结时需要在 FROM 子句中使用多张表.**

之前的 FROM 子句中只有一张表, 而这次我们同时使用了 shopproduct 和 product 两张表, 使用关键字 INNER JOIN 就可以将两张表连结在一起了:

```sql
FROM shop_product AS SP INNER JOIN product AS P
```

**要点二: 必须使用 ON 子句来指定连结条件.**

在进行内连结时 ON 子句是必不可少的(大家可以试试去掉上述查询的 ON 子句后会有什么结果).

ON 子句是专门用来指定连结条件的, 我们在上述查询的 ON 之后指定两张表连结所使用的列以及比较条件, 基本上, 它能起到与 WHERE 相同的筛选作用, 我们会在本章的结尾部分进一步探讨这个话题.

**要点三: SELECT 子句中的列最好按照 表名.列名 的格式来使用.**

当两张表的列除了用于关联的列之外, 没有名称相同的列的时候, 也可以不写表名, 但表名使得我们能够在今后的任何时间阅读查询代码的时候, 都能马上看出每一列来自于哪张表, 能够节省我们很多时间.

但是, 如果两张表有其他名称相同的列, 则必须使用上述格式来选择列名, 否则查询语句会报错.

我们回到上述查询所回答的问题. 通过观察上述查询的结果, 我们发现, 这个结果离我们的目标: 找出东京商店的衣服类商品的基础信息已经很接近了. 接下来, 我们只需要把这个查询结果作为一张表, 给它增加一个 WHERE 子句来指定筛选条件.

#### 4.2.1.2 结合 WHERE 子句使用内连结

如果需要在使用内连结的时候同时使用 WHERE 子句对检索结果进行筛选, 则需要把 WHERE 子句写在 ON 子句的后边.

例如, 对于上述查询问题, 我们可以在前一步查询的基础上,  增加 WHERE 条件.

增加 WHERE 子句的方式有好几种, 我们先从最简单的说起.

第一种增加 WEHRE 子句的方式, 就是把上述查询作为子查询, 用括号封装起来, 然后在外层查询增加筛选条件.

```sql
SELECT *
FROM (-- 第一步查询的结果
        SELECT SP.shop_id
               ,SP.shop_name
               ,SP.product_id
               ,P.product_name
               ,P.product_type
               ,P.sale_price
               ,SP.quantity
         FROM shop_product AS SP
         INNER JOIN product AS P
            ON SP.product_id = P.product_id) AS STEP1
WHERE shop_name = '东京'
    AND product_type = '衣服' ;
```

还记得我们学习子查询时的认识吗? 子查询的结果其实也是一张表, 只不过是一张虚拟的表, 它并不真实存在于数据库中, 只是数据库中其他表经过筛选, 聚合等查询操作后得到的一个 "视图".  
这种写法能很清晰地分辨出每一个操作步骤, 在我们还不十分熟悉 SQL 查询每一个子句的执行顺序的时候可以帮到我们.

但实际上, 如果我们熟知 WHERE 子句将在 FROM 子句之后执行, 也就是说, 在做完 INNER JOIN … ON 得到一个新表后, 才会执行 WHERE 子句, 那么就得到标准的写法:

```sql
SELECT  SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM shopproduct AS SP
INNER JOIN product AS P
    ON SP.product_id = P.product_id
WHERE SP.shop_name = '东京'
   AND P.product_type = '衣服' ;
```

我们首先给出上述查询的执行顺序:  

**FROM 子句 ->WHERE 子句 ->SELECT 子句**

也就是说, 两张表是先按照连结列进行了连结, 得到了一张新表, 然后 WHERE 子句对这张新表的行按照两个条件进行了筛选,  最后, SELECT 子句选出了那些我们需要的列.

此外, 一种不是很常见的做法是, 还可以将 WHERE 子句中的条件直接添加在 ON 子句中, 这时候 ON 子句后最好用括号将连结条件和筛选条件括起来.

```sql
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM shop_product AS SP
INNER JOIN product AS P
    ON (SP.product_id = P.product_id
   AND SP.shop_name = '东京'
   AND P.product_type = '衣服') ;
```
![dyUNfr](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/dyUNfr.png)
但上述这种把筛选条件和连结条件都放在 ON 子句的写法, 不是太容易阅读, 不建议大家使用.  
另外, 先连结再筛选的标准写法的执行顺序是, 两张完整的表做了连结之后再做筛选, 如果要连结多张表, 或者需要做的筛选比较复杂时, 在写 SQL 查询时会感觉比较吃力. 在结合 WHERE 子句使用内连结的时候, 我们也可以更改任务顺序, 并采用任务分解的方法, 先分别在两个表使用 WHERE 进行筛选, 然后把上述两个子查询连结起来.

```sql
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM (-- 子查询 1: 从 shopproduct 表筛选出东京商店的信息
        SELECT *
        FROM shop_product
        WHERE shop_name = '东京' ) AS SP
INNER JOIN -- 子查询 2: 从 product 表筛选出衣服类商品的信息
    (SELECT *
     FROM product
     WHERE product_type = '衣服') AS P

ON SP.product_id = P.product_id;
```
![Jc7ngf](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Jc7ngf.png)
先分别在两张表里做筛选, 把复杂的筛选条件按表分拆, 然后把筛选结果 (作为表) 连接起来, 避免了写复杂的筛选条件, 因此这种看似复杂的写法, 实际上整体的逻辑反而非常清晰. 在写查询的过程中, 首先要按照最便于自己理解的方式来写, 先把问题解决了, 再思考优化的问题.  

![WC7adF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/WC7adF.png)

**练习题:**

找出每个商店里的衣服类商品的名称及价格等信息. 希望得到如下结果:

![zo6faK](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/zo6faK.jpg)

```sql
-- 参考答案 1-- 不使用子查询
SELECT  SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.product_type,
        P.purchase_price
FROM shopproduct  AS SP 

INNER JOIN product AS P 

ON SP.product_id = P.product_id

WHERE P.product_type = '衣服';
```

```sql
-- 参考答案 2-- 使用子查询

SELECT  
    SP.shop_id,
    SP.shop_name,
    SP.product_id,
    P.product_name,
    P.product_type,
    P.purchase_price
FROM shopproduct AS SP 

INNER JOIN -- 从 product 表找出衣服类商品的信息
  (SELECT 
      product_id, 
      product_name, 
      product_type, 
      purchase_price
    FROM product	
    WHERE product_type = '衣服') AS P 
    
ON SP.product_id = P.product_id;
```

上述第二种写法虽然包含了子查询, 并且代码行数更多, 但由于每一层的目的很明确, 更适于阅读, 并且在外连结的情形下, 还能避免错误使用 WHERE 子句导致外连结失效的问题, 相关示例见后文中的 "**结合 WHERE 子句使用外连结**" 章节.  

**练习题:**

分别使用连结两个子查询和不使用子查询的方式, 找出东京商店里, 售价低于 2000 的商品信息, 希望得到如下结果.

![4kwdmD](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/4kwdmD.jpg)

```sql
-- 参考答案
-- 不使用子查询
SELECT SP.*, P.*
FROM shopproduct AS SP 

INNER JOIN product AS P 

ON SP.product_id = P.product_id

WHERE shop_id = '000A' AND sale_price < 2000;
```

#### 4.2.1.3 结合 GROUP BY 子句使用内连结

结合 GROUP BY 子句使用内连结, 需要根据分组列位于哪个表区别对待.

最简单的情形, 是在内连结之前就使用 GROUP BY 子句.

但是如果分组列和被聚合的列不在同一张表, 且二者都未被用于连结两张表, 则只能先连结, 再聚合.

**练习题:**

每个商店中, 售价最高的商品的售价分别是多少?

```sql
-- 参考答案
SELECT SP.shop_id
      ,SP.shop_name
      ,MAX(P.sale_price) AS max_price
FROM shopproduct AS SP

INNER JOIN product AS P

ON SP.product_id = P.product_id

GROUP BY SP.shop_id,SP.shop_name
```

**思考题:** 上述查询得到了每个商品售价最高的商品, 但并不知道售价最高的商品是哪一个. 如何获取每个商店里售价最高的商品的名称和售价?

> 注: 这道题的一个简易的方式是使用下一章的窗口函数. 当然, 也可以使用其他我们已经学过的知识来实现, 例如, 在找出每个商店售价最高商品的价格后, 使用这个价格再与 product 列进行连结, 但这种做法在价格不唯一时会出现问题.

#### 4.2.1.4 自连结(SELF JOIN)

之前的内连结,  连结的都是不一样的两个表. 但实际上一张表也可以与自身作连结, 这种连接称之为自连结. 需要注意, 自连结并不是区分于内连结和外连结的第三种连结, 自连结可以是外连结也可以是内连结, 它是不同于内连结外连结的另一个连结的分类方法.

#### 4.2.1.5 内连结与关联子查询

回忆第五章第三节关联子查询中的问题: 找出每个商品种类当中售价高于该类商品的平均售价的商品. 当时我们是使用关联子查询来实现的.

```sql
SELECT 
    product_type, 
    product_name, 
    sale_price
FROM product AS P1

WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product AS P2
                    WHERE P1.product_type = P2.product_type
                    GROUP BY product_type);
```

使用内连结同样可以解决这个问题:  
首先, 使用 GROUP BY 按商品类别分类计算每类商品的平均价格.

```sql
SELECT  
        product_type,
        AVG(sale_price) AS avg_price 
FROM product 
GROUP BY product_type;
```

接下来, 将上述查询与表 product 按照 product_type (商品种类)进行内连结.

```sql
SELECT  P1.product_id,
        P1.product_name,
        P1.product_type,
        P1.sale_price,
        P2.avg_price
FROM product AS P1 

INNER JOIN 
   (SELECT product_type,AVG(sale_price) AS avg_price 
    FROM product 
    GROUP BY product_type) AS P2 

ON P1.product_type = P2.product_type;
```

最后, 增加 WHERE 子句, 找出那些售价高于该类商品平均价格的商品. 完整的代码如下:

```sql
SELECT  P1.product_id,
        P1.product_name,
        P1.product_type,
        P1.sale_price,
        P2.avg_price
FROM product AS P1

INNER JOIN (SELECT product_type,AVG(sale_price) AS avg_price 
            FROM product 
            GROUP BY product_type) AS P2 

ON P1.product_type = P2.product_type

WHERE P1.sale_price > P2.avg_price;
```

仅仅从代码量上来看, 上述方法似乎比关联子查询更加复杂, 但这并不意味着这些代码更难理解. 通过上述分析, 很容易发现上述代码的逻辑实际上更符合我们的思路, 因此尽管看起来复杂, 但思路实际上更加清晰.  
作为对比, 试分析如下代码:

```sql
SELECT  
        P1.product_id,
        P1.product_name,
        P1.product_type,
        P1.sale_price,AVG(P2.sale_price) AS avg_price
FROM product AS P1

INNER JOIN product AS P2

ON P1.product_type=P2.product_type

WHERE P1.sale_price > P2.sale_price

GROUP BY P1.product_id,P1.product_name,P1.product_type,P1.sale_price,P2.product_type
```

虽然去掉了子查询, 查询语句的层次更少, 而且代码行数似乎更少, 但实际上这个方法可能更加难以写出来. 在实践中, 一定要按照易于让自己理解的思路去分层次写代码, 而不要花费很长世间写出一个效率可能更高但自己和他人理解起来难度更高的代码.

#### 4.2.1.6 自然连结(NATURAL JOIN)

自然连结并不是区别于内连结和外连结的第三种连结, 它其实是内连结的一种特例–当两个表进行自然连结时, 会按照两个表中都包含的列名来进行等值内连结, 此时无需使用 ON 来指定连接条件.

```sql
SELECT *  FROM shopproduct NATURAL JOIN product
```

上述查询得到的结果, 会把两个表的公共列 (这里是 product_id, 可以有多个公共列) 放在第一列, 然后按照两个表的顺序和表中列的顺序, 将两个表中的其他列都罗列出来.  

![rw21Co](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/rw21Co.jpg)

**练习题:**

试写出与上述自然连结等价的内连结.

```sql
-- 参考答案
SELECT  
        SP.product_id,
        SP.shop_id,
        SP.shop_name,
        SP.quantity,
        P.product_name,
        P.product_type,
        P.sale_price,
        P.purchase_price,
        P.regist_date  

FROM shopproduct AS SP 

INNER JOIN product AS P 

ON SP.product_id = P.product_id
```

使用自然连结还可以求出两张表或子查询的公共部分, 例如教材中 7-1 选取表中公共部分–INTERSECT 一节中的问题: 求表 product 和表 product2 中的公共部分, 也可以用自然连结来实现:

```sql
SELECT * FROM product NATURAL JOIN product2
```

![ZQlPHy](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/ZQlPHy.jpg)

这个结果和书上给的结果并不一致, 少了运动 T 恤, 这是由于运动 T 恤的 regist_date 字段为空, 在进行自然连结时, 来自于 product 和 product2 的运动 T 恤这一行数据在进行比较时, 实际上是在逐字段进行等值连结, 回忆我们在 **6.2 ISNULL,IS NOT NULL** 这一节学到的缺失值的比较方法就可得知, 两个缺失值用等号进行比较, 结果不为真. 而连结只会返回对连结条件返回为真的那些行.

如果我们将查询语句进行修改:

```sql
SELECT * 
FROM (SELECT 
        product_id, 
        product_name
      FROM product ) AS A 
      
NATURAL JOIN 

   (SELECT 
        product_id, 
        product_name 
    FROM product2) AS B;
```

那就可以得到正确的结果了:  

![Ky1pRa](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Ky1pRa.jpg)

#### 4.2.1.7 使用连结求交集

我们在上一节表的加减法里知道, MySQL 8.0 里没有交集运算, 我们当时是通过并集和差集来实现求交集的. 现在学了连结, 让我们试试使用连结来实现求交集的运算.

练习题: 使用内连结求 product 表和 product2 表的交集.

```sql
SELECT P1.*

FROM product AS P1

INNER JOIN product2 AS P2

ON (P1.product_id  = P2.product_id
   AND P1.product_name = P2.product_name
   AND P1.product_type = P2.product_type
   AND P1.sale_price   = P2.sale_price
   AND P1.regist_date  = P2.regist_date)
```

得到如下结果  

![rKoT3K](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/rKoT3K.jpg)


注意上述结果和 P230 的结果并不一致–少了 product_id='0001' 这一行, 观察源表数据可发现, 少的这行数据的 regist_date 为缺失值, 回忆第六章讲到的 IS NULL 谓词, 我们得知, 这是由于缺失值是不能用等号进行比较导致的.

如果我们仅仅用 product_id 来进行连结:

```sql
SELECT P1.*

FROM product AS P1

INNER JOIN product2 AS P2
    ON P1.product_id = P2.product_id
```

查询结果:  

![hTiBZy](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/hTiBZy.jpg)


这次就一致了.

### 4.2.2 外连结(OUTER JOIN)

内连结会丢弃两张表中不满足 ON 条件的行, 和内连结相对的就是外连结. 外连结会根据外连结的种类有选择地保留无法匹配到的行.

按照保留的行位于哪张表, 外连结有三种形式: `左连结, 右连结和全外连结`.

左连结会保存左表中无法按照 ON 子句匹配到的行, 此时对应右表的行均为缺失值; 右连结则会保存右表中无法按照 ON 子句匹配到的行, 此时对应左表的行均为缺失值;  而全外连结则会同时保存两个表中无法按照 ON 子句匹配到的行, 相应的另一张表中的行用缺失值填充.

三种外连结的对应语法分别为:

```sql
-- 左连结     
FROM <tb_1> LEFT  OUTER JOIN <tb_2> ON <condition(s)>
-- 右连结     
FROM <tb_1> RIGHT OUTER JOIN <tb_2> ON <condition(s)>
-- 全外连结
FROM <tb_1> FULL  OUTER JOIN <tb_2> ON <condition(s)>
```

#### 4.2.2.1 左连结与右连接

由于连结时可以交换左表和右表的位置, 因此左连结和右连结并没有本质区别. 接下来我们先以左连结为例进行学习. 所有的内容在调换两个表的前后位置, 并将左连结改为右连结之后, 都能得到相同的结果.  稍后再介绍全外连结的概念.

#### 4.2.2.2 使用左连结从两个表获取信息

如果你仔细观察过将 **shopproduct** 和 **product** 进行内连结前后的结果的话, 你就会发现,product 表中有两种商品并未在内连结的结果里, 就是说, 这两种商品并未在任何商店有售(这通常意味着比较重要的业务信息, 例如, 这两种商品在所有商店都处于缺货状态, 需要及时补货). 现在, 让我们先把之前内连结的 SELECT 语句转换为左连结试试看吧.

练习题: 统计每种商品分别在哪些商店有售, 需要包括那些在每个商店都没货的商品.

使用左连结的代码如下(注意区别于书上的右连结):

```sql
SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
        
FROM product AS P

LEFT OUTER JOIN shopproduct AS SP

ON SP.product_id = P.product_id;

```

上述查询得到的检索结果如下(由于并未使用 ORDER BY 子句指定顺序, 你执行上述代码得到的结果可能顺序与下图不同):  

![g2xMbq](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/g2xMbq.jpg)


我们观察上述结果可以发现, 有两种商品: 高压锅和圆珠笔, 在所有商店都没有销售. 由于我们在 SELECT 子句选择列的显示顺序以及未对结果进行排序的原因, 这个事实需要你仔细地进行观察.

**● 外连结要点 1: 选取出单张表中全部的信息**

与内连结的结果相比, 不同点显而易见, 那就是结果的行数不一样. 

内连结的结果中有 13 条记录, 而外连结的结果中有 15 条记录, 增加的 2 条记录到底是什么呢? 

这正是外连结的关键点. 多出的 2 条记录是高压锅和圆珠笔, 这 2 条记录在 shopproduct 表中并不存在, 也就是说, 这 2 种商品在任何商店中都没有销售. 

由于内连结只能选取出同时存在于两张表中的数据, 因此只在 product 表中存在的 2 种商品并没有出现在结果之中. 

相反, 对于外连结来说, 只要数据存在于某一张表当中, 就能够读取出来. 

在实际的业务中, 例如想要生成固定行数的单据时, 就需要使用外连结. 如果使用内连结的话, 根据 SELECT 语句执行时商店库存状况的不同, 结果的行数也会发生改变, 生成的单据的版式也会受到影响, 而使用外连结能够得到固定行数的结果. 

虽说如此, 那些表中不存在的信息我们还是无法得到, 结果中高压锅和圆珠笔的商店编号和商店名称都是 NULL （具体信息大家都不知道, 真是无可奈何）. 

外连结名称的由来也跟 NULL 有关, 即“结果中包含原表中不存在（在原表之外）的信息”. 相反, 只包含表内信息的连结也就被称为内连结了.

**● 外连结要点 2: 使用 LEFT、RIGHT 来指定主表.**

外连结还有一点非常重要, 那就是要把哪张表作为主表. 

最终的结果中会包含主表内所有的数据. 指定主表的关键字是 **LEFT** 和 **RIGHT**. 

顾名思义, 使用 LEFT 时 FROM 子句中写在左侧的表是主表, 使用 RIGHT 时右侧的表是主表. 

代码清单 7-11 中使用了 RIGHT , 因此, 右侧的表, 也就是 product 表是主表. 我们还可以像代码清单 7-12 这样进行改写, 意思完全相同. 这样你可能会困惑，到底应该使用 LEFT 还是 RIGHT？

其实它们的功能没有任何区别, 使用哪一个都可以. 通常使用 LEFT 的情况会多一些, 但也并没有非使用这个不可的理由, 使用 RIGHT 也没有问题.

通过交换两个表的顺序, 同时将 LEFT 更换为 RIGHT(如果原先是 RIGHT, 则更换为 LEFT), 两种方式会到完全相同的结果.

#### 4.2.2.3 结合 WHERE 子句使用左连结

上一小节我们学到了外连结的基础用法, 并且在上一节也学习了结合 WHERE 子句使用内连结的方法, 但在结合 WHERE 子句使用外连结时, 由于外连结的结果很可能与内连结的结果不一样, 会包含那些主表中无法匹配到的行, 并用缺失值填写另一表中的列, 由于这些行的存在, 因此在外连结时使用 WHERE 子句, 情况会有些不一样. 我们来看一个例子:

**练习题:**

使用外连结从 shopproduct 表和 product 表中找出那些在某个商店库存少于 50 的商品及对应的商店. 希望得到如下结果.

![0hILMh](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/0hILMh.jpg)


注意高压锅和圆珠笔两种商品在所有商店都无货, 所以也应该包括在内.

按照 "结合 WHERE 子句使用内连结" 的思路, 我们很自然会写出如下代码

```sql
SELECT 
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        SP.quantity
FROM product AS P

LEFT OUTER JOIN shopproduct AS SP

ON SP.product_id = P.product_id

WHERE quantity< 50
```

然而不幸的是, 得到的却是如下的结果:  

![tJAaTt](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/tJAaTt.jpg)


观察发现, 返回结果缺少了在所有商店都无货的高压锅和圆珠笔。

聪明的你可能很容易想到，在 WHERE 过滤条件中增加 `OR quantity IS NULL` 的判断条件，便可以得到预期结果。然而在实际环境中，由于数据量大且数据质量并非像我们设想的那样 "干净"，我们并不能容易地意识到缺失值等问题数据的存在，因此，还是让我们想一下如何改写我们的查询以使得它能够适应更复杂的真实数据的情形吧。

联系到我们已经掌握了的 SQL 查询的执行顺序(**FROM->WHERE->SELECT**), 我们发现, 问题可能出在筛选条件上, 因为在进行完外连结后才会执行 WHERE 子句, 因此那些主表中无法被匹配到的行就被 WHERE 条件筛选掉了。

明白了这一点, 我们就可以试着把 WHERE 子句挪到外连结之前进行: 先写个子查询, 用来从 **shopproduct** 表中筛选 **quantity<50** 的商品, 然后再把这个子查询和主表连结起来。

我们把上述思路写成 SQL 查询语句:

```sql
SELECT 
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        SP.quantity 
FROM product AS P

LEFT OUTER JOIN-- 先筛选 quantity<50 的商品
   (SELECT *
    FROM shopproduct
    WHERE quantity < 50 ) AS SP
     
ON SP.product_id = P.product_id
```

得到的结果如下:  

![tWv53V](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/tWv53V.jpg)


#### 4.2.2.4 在 MySQL 中实现全外连结

有了对左连结和右连结的了解, 就不难理解全外连结的含义了. 全外连结本质上就是对左表和右表的所有行都予以保留, 能用 ON 关联到的就把左表和右表的内容在一行内显示, 不能被关联到的就分别显示, 然后把多余的列用缺失值填充。

遗憾的是, **MySQL8.0 目前还不支持全外连结**, 不过我们可以对左连结和右连结的结果进行 UNION 来实现全外连结。

### 4.2.3 多表连结

通常连结只涉及 2 张表, 但有时也会出现必须同时连结 3 张以上的表的情况, 原则上连结表的数量并没有限制。

#### 4.2.3.1 多表进行内连结

首先创建一个用于三表连结的表 Inventoryproduct. 首先我们创建一张用来管理库存商品的表,  假设商品都保存在 P001 和 P002 这 2 个仓库之中.

![e85lMI](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/e85lMI.jpg)

建表语句如下:

```sql
CREATE TABLE Inventoryproduct(
    inventory_id       CHAR(4) NOT NULL,
    product_id         CHAR(4) NOT NULL,
    inventory_quantity INTEGER NOT NULL,
    PRIMARY KEY (inventory_id, product_id));
```

然后插入一些数据:

```sql
--- DML：插入数据
START TRANSACTION;
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0001', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0002', 120);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0003', 200);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0004', 3);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0005', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0006', 99);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0007', 999);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P001', '0008', 200);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0001', 10);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0002', 25);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0003', 34);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0004', 19);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0005', 99);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0006', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0007', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity)
VALUES ('P002', '0008', 18);
COMMIT;
```

接下来, 我们根据上表及 shopproduct 表和 product 表, 使用内连接找出每个商店都有那些商品, 每种商品的库存总量分别是多少.

```sql
SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price,
        IP.inventory_quantity
FROM shopproduct AS SP

INNER JOIN product AS P

ON SP.product_id = P.product_id

INNER JOIN Inventoryproduct AS IP

ON SP.product_id = IP.product_id

WHERE IP.inventory_id = 'P001';
```

得到如下结果

![nvSG7j](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/nvSG7j.jpg)

我们可以看到, 连结第三张表的时候, 也是通过 **ON** 子句指定连结条件(这里使用最基础的等号将作为连结条件的 **product** 表和 **shopproduct** 表中的商品编号 **product_id** 连结了起来), 由于 **product** 表和 **shopproduct** 表已经进行了连结, 因此就无需再对 **product** 表和 **Inventoryproduct** 表进行连结了(虽然也可以进行连结, 但结果并不会发生改变, 因为本质上并没有增加新的限制条件).

即使想要把连结的表增加到 4 张、5 张……使用 INNER JOIN 进行添加的方式也是完全相同的.

#### 4.2.3.2 多表进行外连结

正如之前所学发现的, 外连结一般能比内连结有更多的行, 从而能够比内连结给出更多关于主表的信息, 多表连结的时候使用外连结也有同样的作用.

例如,

```sql
SELECT 
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        IP.inventory_quantity
FROM product AS P

LEFT OUTER JOIN shopproduct AS SP

ON SP.product_id = P.product_id

LEFT OUTER JOIN Inventoryproduct AS IP

ON SP.product_id = IP.product_id
```

查询结果  

![hLsIEo](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/hLsIEo.jpg)


### 4.2.4 ON 子句进阶–非等值连结

在刚开始介绍连结的时候, 书上提到过, 除了使用相等判断的等值连结, 也可以使用比较运算符来进行连接. 实际上, 包括比较运算符 (<,<=,>,>=, BETWEEN) 和谓词运算 (LIKE, IN, NOT 等等) 在内的所有的逻辑运算都可以放在 ON 子句内作为连结条件.

#### 4.2.4.1 非等值自左连结(SELF JOIN)

使用非等值自左连结实现排名。

**练习题:**

希望对 product 表中的商品按照售价赋予排名. 一个从集合论出发, 使用自左连结的思路是, 对每一种商品, 找出售价不低于它的所有商品, 然后对售价不低于它的商品使用 COUNT 函数计数. 例如, 对于价格最高的商品,

```sql
SELECT  
        product_id,
        product_name,
        sale_price,
        COUNT(p2_id) AS rank_id
FROM (-- 使用自左连结对每种商品找出价格不低于它的商品
        SELECT 
                P1.product_id,
                P1.product_name,
                P1.sale_price,
                P2.product_id AS P2_id,
                P2.product_name AS P2_name,
                P2.sale_price AS P2_price 
        FROM product AS P1 
        
        LEFT OUTER JOIN product AS P2 
        
        ON P1.sale_price <= P2.sale_price 
        ) AS X
        
GROUP BY product_id, product_name, sale_price

ORDER BY rank_id;
```

注 1: COUNT 函数的参数是列名时, 会忽略该列中的缺失值, 参数为 * 时则不忽略缺失值.  
注 2: 上述排名方案存在一些问题–如果两个商品的价格相等, 则会导致两个商品的排名错误, 例如,  叉子和打孔器的排名应该都是第六, 但上述查询导致二者排名都是第七. 试修改上述查询使得二者的排名均为第六.

![QA1Uas](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/QA1Uas.jpg)


注 3: 实际上, 进行排名有专门的函数, 这是 MySQL 8.0 新增加的窗口函数中的一种(窗口函数将在下一章学习), 但在较低版本的 MySQL 中只能使用上述自左连结的思路.

使用非等值自左连结进行累计求和:

**练习题:**

请按照商品的售价从低到高, 对售价进行累计求和[注: 这个案例缺少实际意义, 并且由于有两种商品价格相同导致了不必要的复杂度, 但示例数据库的表结构比较简单, 暂时未想出有实际意义的例题]

首先, 按照题意, 对每种商品使用自左连结, 找出比该商品售价价格更低或相等的商品

```sql
SELECT  
        P1.product_id,
        P1.product_name,
        P1.sale_price,
        P2.product_id AS P2_id,
        P2.product_name AS P2_name,
        P2.sale_price AS P2_price 
FROM product AS P1 

LEFT OUTER JOIN product AS P2 

ON P1.sale_price >= P2.sale_price

ORDER BY P1.sale_price,P1.product_id
```

查看查询结果  

![kHVqn4](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/kHVqn4.jpg)


看起来似乎没什么问题.

下一步, 按照 P1.product_Id 分组, 对 P2_price 求和:

```sql
SELECT  
        product_id,
        product_name,
        sale_price,
        SUM(P2_price) AS cum_price 
        
FROM (SELECT  
            P1.product_id,
            P1.product_name,
            P1.sale_price,
            P2.product_id AS P2_id,
            P2.product_name AS P2_name,
            P2.sale_price AS P2_price 
        FROM product AS P1 
        LEFT OUTER JOIN product AS P2 
        ON P1.sale_price >= P2.sale_price
        ORDER BY P1.sale_price,P1.product_id ) AS X
        
GROUP BY product_id, product_name, sale_price

ORDER BY sale_price,product_id;
```

得到的查询结果为:  

![9pyNrd](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/9pyNrd.jpg)


观察上述查询结果发现, 由于有两种商品的售价相同, 在使用 >= 进行连结时, 导致了累计求和错误, 这是由于这两种商品售价相同导致的. 因此实际上之前是不应该单独只用 >= 作为连结条件的. 

考察我们建立自左连结的本意, 是要找出满足:

1. 比该商品售价更低的, 或者是 
2. 该种商品自身, 以及 
3. 如果 A 和 B 两种商品售价相等, 则建立连结时, 如果 P1.A 和 P2.A,P2.B 建立了连接, 则 P1.B 不再和 P2.A 建立连结, 因此根据上述约束条件, 利用 ID 的有序性, 进一步将上述查询改写为:

```sql
SELECT	
        product_id, 
        product_name, 
        sale_price,
        SUM(P2_price) AS cum_price 
FROM
        (SELECT  
                P1.product_id, 
                P1.product_name, 
                P1.sale_price,
                P2.product_id AS P2_id,
                P2.product_name AS P2_name,
                P2.sale_price AS P2_price 
        FROM product AS P1 
        
        LEFT OUTER JOIN product AS P2 
        ON ((P1.sale_price > P2.sale_price)
            OR (P1.sale_price = P2.sale_price 
            AND P1.product_id<=P2.product_id))
            ORDER BY P1.sale_price,P1.product_id) AS X
            
GROUP BY product_id, product_name, sale_price

ORDER BY sale_price,cum_price;
```

这次结果就正确了.  

![6E7ukR](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/6E7ukR.jpg)

### 4.2.5 交叉连结—— CROSS JOIN(笛卡尔积)

之前的无论是外连结内连结, 一个共同的必备条件就是连结条件 –**ON 子句**, 用来指定连结的条件. 如果你试过不使用这个连结条件的连结查询, 你可能已经发现, 结果会有很多行. 在连结去掉 ON 子句, 就是所谓的交叉连结 (CROSS JOIN), 交叉连结又叫笛卡尔积, 后者是一个数学术语. 两个集合做笛卡尔积, 就是使用集合 A 中的每一个元素与集合 B 中的每一个元素组成一个有序的组合. 

数据库表(或者子查询) 的并, 交和差都是在纵向上对表进行扩张或筛选限制等运算的, 这要求表的列数及对应位置的列的数据类型 "相容", 因此这些运算并不会增加新的列, 而交叉连接 (笛卡尔积) 则是在横向上对表进行扩张, 即增加新的列, 这一点和连结的功能是一致的. 但因为没有了 ON 子句的限制, 会对左表和右表的每一行进行组合, 这经常会导致很多无意义的行出现在检索结果中. 当然, 在某些查询需求中, 交叉连结也有一些用处.

交叉连结的语法有如下几种形式:

```sql
-- 1. 使用关键字 CROSS JOIN 显式地进行交叉连结

SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
        
FROM shopproduct AS SP

CROSS JOIN product AS P;
 
--2. 使用逗号分隔两个表, 并省略 ON 子句

SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
FROM shopproduct AS SP ,product AS P;
```

请大家试着执行一下以上语句.  
可能大家会惊讶于结果的行数, 但我们还是先来介绍一下语法结构吧. 对满足相同规则的表进行交叉连结的集合运算符是**CROSS JOIN （笛卡儿积）**. 进行交叉连结时无法使用内连结和外连结中所使用的 ON 子句, 这是因为交叉连结是对两张表中的全部记录进行交叉组合, 因此结果中的记录数通常是两张表中行数的乘积. 本例中, 因为 shopproduct 表存在 13 条记录,product 表存在 8 条记录, 所以结果中就包含了 **13 × 8 = 104** 条记录.

可能这时会有读者想起前面我们提到过集合运算中的乘法会在本节中进行详细学习, 这就是上面介绍的交叉连结. 内连结是交叉连结的一部分,“内”也可以理解为“包含在交叉连结结果中的部分”. 相反, 外连结的“外”可以理解为“交叉连结结果之外的部分”.

交叉连结没有应用到实际业务之中的原因有两个. 一是其结果没有实用价值, 二是由于其结果行数太多, 需要花费大量的运算时间和高性能设备的支持.

#### 4.2.5.1 [扩展阅读]连结与笛卡儿积的关系

考察笛卡儿积和连结, 不难发现, 笛卡儿积可以视作一种特殊的连结(事实上笛卡儿积的语法也可以写作 CROSS JOIN), 这种连结的 ON 子句是一个恒为真的谓词.

反过来思考, 在对笛卡儿积进行适当的限制之后, 也就得到了内连结和外连结.

例如, 对于 shopproduct 表和 product 表, 首先建立笛卡尔乘积:

```sql
SELECT SP.*, P.*

FROM shopproduct AS SP 

CROSS JOIN product AS P;
```

查询结果的一部分如下:  

![ax6Isf](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/ax6Isf.jpg)

然后对上述笛卡尔乘积增加筛选条件 **SP.product_id=P.product_id**, 就得到了和内连结一致的结果:

```sql
SELECT SP.*, P.*

FROM shopproduct AS SP 

CROSS JOIN product AS P

WHERE SP.product_id = P.product_id;
```

查询结果如下:  

![hcrEz4](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/hcrEz4.jpg)

实际上, 正如书中所说, 上述写法中, 将 CROSS JOIN 改为逗号后, 正是内连结的旧式写法, 但在 ANSI 和 ISO 的 SQL-92 标准中, 已经将使用 INNER JION …ON… 的写法规定为标准写法, 因此极力推荐大家在平时写 SQL 查询时, 使用规范写法.

### 4.2.6 连结的特定语法和过时语法

在笛卡尔积的基础上, 我们增加一个 WHERE 子句, 将之前的连结条件作为筛选条件加进去, 我们会发现, 得到的结果恰好是直接使用内连接的结果.

试执行以下查询, 并将查询结果与内连结一节第一个例子的结果做对比.

```sql
SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
FROM shopproduct AS SP
CROSS JOIN product AS P
WHERE SP.product_id = P.product_id;
```

我们发现, 这两个语句得到的结果是相同的.  

之前我们学习的内连结和外连结的语法都符合标准 SQL 的规定, 可以在所有 DBMS 中执行, 因此大家可以放心使用. 但是如果大家之后从事系统开发工作, 或者阅读遗留 SQL 查询语句的话, 一定会碰到需要阅读他人写的代码并进行维护的情况, 而那些使用特定和过时语法的程序就会成为我们的麻烦.

SQL 是一门特定语法及过时语法非常多的语言, 虽然之前本书中也多次提及, 但连结是其中特定语法的部分, 现在还有不少年长的程序员和系统工程师仍在使用这些特定的语法. 例如, 将本节最初介绍的内连结的 SELECT 语句替换为过时语法的结果如下所示.

使用过时语法的内连结（结果与代码清单 7-9 相同）

```sql
SELECT 
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
FROM shopproduct SP,product P
WHERE SP.product_id = P.product_id AND SP.shop_id = '000A';
```

这样的书写方式所得到的结果与标准语法完全相同, 并且这样的语法可以在所有的 DBMS 中执行, 并不能算是特定的语法, 只是过时了而已.  
但是, 由于这样的语法不仅过时, 而且还存在很多其他的问题, 因此不推荐大家使用, 理由主要有以下三点:

第一, 使用这样的语法无法马上判断出到底是内连结还是外连结（又或者是其他种类的连结）.

第二, 由于连结条件都写在 WHERE 子句之中, 因此无法在短时间内分辨出哪部分是连结条件, 哪部分是用来选取记录的限制条件.

第三, 我们不知道这样的语法到底还能使用多久. 每个 DBMS 的开发者都会考虑放弃过时的语法, 转而支持新的语法. 虽然并不是马上就不能使用了, 但那一天总会到来的.

虽然这么说, 但是现在使用这些过时语法编写的程序还有很多, 到目前为止还都能正常执行. 我想大家很可能会碰到这样的代码, 因此还是希望大家能够了解这些知识.

## 练习题

### 练习题 4.1

找出 product 和 product2 中售价高于 500 的商品的基本信息。

### 练习题 4.2

借助对称差的实现方式, 求 product 和 product2 的交集。

### 练习题 4.3

每类商品中售价最高的商品都在哪些商店有售 ？

### 练习题 4.4

分别使用内连结和关联子查询每一类商品中售价最高的商品。

### 练习题 4.5

用关联子查询实现：在 `product` 表中，取出 product_id, produc_name, slae_price, 并按照商品的售价从低到高进行排序、对售价进行累计求和。

本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql
# Task05：窗口函数

[TOC]

## 5.0 MySQL 函数

本节为您提供最常用的**MySQL函数**，包括聚合函数，字符串函数，日期时间函数，控制流函数等。

### MySQL聚合函数

* [AVG](func-mysql-avg.html "MySQL AVG") - 计算一组值或表达式的平均值。
* [COUNT](func-mysql-count.html "MySQL COUNT") - 计算表中的行数。
* [INSTR](func-mysql-instr.html) - 返回字符串中第一次出现的子字符串的位置。
* [SUM ](func-mysql-sum.html "MySQL SUM") - 计算一组值或表达式的总和。
* [MIN](func-mysql-min.html "MySQL MIN") - 在一组值中找到最小值
* [MAX](func-mysql-max.html "MySQL MAX功能") - 在一组值中找到最大值

### MySQL字符串函数

* [CONCAT](func-mysql-concat.html) - 将两个或多个字符串组合成一个字符串。
* [LENGTH＆CHAR_LENGTH ](func-mysql-length.html "MySQL字符串长度") - 获取字符串的长度，以字节和字符为单位。
* [LEFT](func-mysql-left.html) - 获取具有指定长度的字符串的左侧部分。
* [REPLACE](func-mysql-replace.html) - 搜索并替换字符串中的子字符串。
* [SUBSTRING](func-mysql-SUBSTRING.html) - 从具有特定长度的位置开始提取子字符串。
* [TRIM](func-mysql-trim.html) - 从字符串中删除不需要的字符。
* [FIND_IN_SET](func-mysql-find-in-set.html) - 在以逗号分隔的字符串列表中查找字符串。
* [FORMAT](func-mysql-format.html) - 格式化具有特定区域设置的数字，四舍五入到小数位数

### MySQL控制流功能

* [CASE](func-mysql-case.html) - `THEN`如果`WHEN`满足分支中的条件，则返回分支中的相应结果，否则返回`ELSE`分支中的结果。
* [IF](func-mysql-if.html) - 根据给定条件返回值。
* [IFNULL](func-mysql-ifnull.html "MySQL IFNULL") - 如果它不是NULL则返回第一个参数，否则返回第二个参数。
* [NULLIF](func-mysql-nullif.html "MySQL NULLIF") - 如果第一个参数等于第二个参数，[则](func-mysql-nullif.html "MySQL NULLIF")返回NULL，否则返回第一个参数。

### MySQL日期和时间函数

* [CURDATE](func-mysql-curdate.html) - 返回当前日期。
* [DATEDIFF](func-mysql-datediff.html)  - 计算两个`DATE`值之间的天数   。
* [DAY](func-mysql-day.html)  - 获取指定日期的月份日期。
* [DATE_ADD](func-mysql-date-add.html)  - 将日期值添加到日期值。
* [DATE_SUB](func-mysql-date-sub.html) - 从日期值中减去时间值。
* [DATE_FORMAT](func-mysql-date-format.html "MySQL DATE_FORMAT函数") - 根据指定的日期格式格式化日期值。
* [DAYNAME](func-mysql-dayname.html) - 获取指定日期的工作日名称。
* [DAYOFWEEK](func-mysql-dayofweek.html) - 返回日期的工作日索引。
* [EXTRACT](func-mysql-extract.html) - 提取日期的一部分。
* [NOW](func-mysql-now.html "MySQL NOW() 函数") - 返回执行语句的当前日期和时间。
* [MONTH](https://www.begtut.com/mysql/mysql-month.html) - 返回表示指定日期月份的整数。
* [STR_TO_DATE](func-mysql-str-to-date.html "MySQL STR_TO_DATE() 函数") - 根据指定的格式将字符串转换为日期和时间值。
* [SYSDATE](func-mysql-sysdate.html) - 返回当前日期。
* [TIMEDIFF](func-mysql-timediff.html) - 计算两个`TIME`或`DATETIME`值之间的差异。
* [TIMESTAMPDIFF](func-mysql-timestampdiff.html) - 计算两个`DATE`或`DATETIME`值之间的差异。
* [WEEK](func-mysql-week.html) - 返回一个星期的日期。
* [WEEKDAY](func-mysql-weekday.html)  - 返回日期的工作日索引。
* [YEAR](func-mysql-year.html) -返回日期值的年份部分。

### MySQL比较功能

* [COALESCE](func-mysql-coalesce.html) - 返回第一个非null参数，这对于替换null非常方便。
* [GREATEST＆LEAST](func-mysql-greatest.html) - 取n个参数并分别返回n个参数的最大值和最小值。
* [ISNULL](https://www.begtut.com/mysql/mysql-isnull-function.html) - 如果参数为null，则返回1，否则返回零。

### MySQL数学函数

* [ABS](func-mysql-abs.html) - 返回数字的绝对值。
* [CEIL](func-mysql-ceil.html) - 返回大于或等于输入数字的最小整数值。
* [FLOOR](func-mysql-floor.html) - 返回不大于参数的最大整数值。
* [MOD](func-mysql-mod.html) - 返回数字的余数除以另一个。
* [ROUND](func-mysql-round.html)  - 将数字四舍五入到指定的小数位数。
* [TRUNCATE](func-mysql-truncate.html) - 将数字截断为指定的小数位数。

### 其他MySQL功能

* [LAST_INSERT_ID](func-mysql-last-insert-id.html) - 获取最后生成的最后一个插入记录的序列号。
* [CAST](func-mysql-cast.html "MySQL CAST") - 将任何类型的值转换为具有指定类型的值。


## 5.1 窗口函数

![2JGnOx](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/2JGnOx.png)

### 5.1.1 窗口函数概念及基本的使用方法

窗口函数也称为 **OLAP** 函数。OLAP 是 OnLine Analytical Processing 的简称，意思是**对数据库数据进行实时分析处理**。

为了便于理解，称之为窗口函数。常规的 SELECT 语句都是对整张表进行查询，而窗口函数可以让我们有选择的去某一部分数据进行汇总、计算和排序。


窗口函数和普通聚合函数也很容易混淆，二者区别如下：

* 聚合函数是将多条记录聚合为一条；而窗口函数是每条记录都会执行，有几条记录执行完还是几条。

* 聚合函数也可以用于窗口函数中

下面是一个窗口函数的简单例子：

![BT7D11](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/BT7D11.jpg)

按照功能划分，可以把MySQL支持的窗口函数分为如下几类：

* 序号函数：row_number() / rank() / dense_rank()

* 分布函数：percent_rank() / cume_dist()

* 前后函数：lag() / lead()

* 头尾函数：first_val() / last_val()

* 其他函数：nth_value() / nfile()

窗口函数的通用形式：

```sql
<窗口函数> OVER ([PARTITION BY <列名>]
                     ORDER BY <排序用列名>)
```

_[]_ 中的内容可以省略。  

窗口函数最关键的是搞明白关键字 **PARTITON BY** 和 **ORDER BY** 的作用。

**PARTITON BY** 是用来分组，即选择要看哪个窗口，类似于 GROUP BY 子句的分组功能，但是 PARTITION BY 子句并不具备 GROUP BY 子句的汇总功能，并不会改变原始表中记录的行数。

**ORDER BY** 是用来排序，即决定窗口内，是按那种规则 (字段) 来排序的。

举个🌰:

```sql
SELECT 
        product_name,
        product_type,
        sale_price,
        RANK() OVER (
            PARTITION BY product_type
            ORDER BY sale_price) AS ranking
FROM product
```

得到的结果是:

![e1I3fm](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/e1I3fm.jpg)

我们先忽略生成的新列 - [ranking]， 看下原始数据在 PARTITION BY 和 ORDER BY 关键字的作用下发生了什么变化。

**PARTITION BY** 能够设定窗口对象范围。本例中，为了按照商品种类进行排序，我们指定了 **product_type**。即一个商品种类就是一个小的 "窗口"。

**ORDER BY** 能够指定按照哪一列、何种顺序进行排序。为了按照销售单价的升序进行排列，我们指定了 sale_price。此外，窗口函数中的 ORDER BY 与 SELECT 语句末尾的 ORDER BY 一样，可以通过关键字 ASC/DESC 来指定升序 / 降序。省略该关键字时会默认按照 ASC，也就是

升序进行排序。本例中就省略了上述关键字 。

![5qnRyd](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/5qnRyd.jpg)

其中，over是关键字，用来指定函数执行的窗口范围，如果后面括号中什么都不写，则意味着窗口包含满足where条件的所有行，窗口函数基于所有行进行计算；如果不为空，则支持以下四种语法来设置窗口：

window_name：给窗口指定一个别名，如果SQL中涉及的窗口较多，采用别名可以看起来更清晰易读。上面例子中如果指定一个别名w，则改写如下：

```sql
select * from(
    select row_number()over w as row_num,
    order_id,user_no,amount,create_date
    from order_tab
    WINDOW w AS (partition by user_no order by amount desc)
)t ;
```

* partition子句：窗口按照那些字段进行分组，窗口函数在不同的分组上分别执行。上面的例子就按照用户id进行了分组。在每个用户id上，按照order by的顺序分别生成从1开始的顺序编号。

* order by子句：按照哪些字段进行排序，窗口函数将按照排序后的记录顺序进行编号。可以和partition子句配合使用，也可以单独使用。上例中二者同时使用，如果没有partition子句，则会按照所有用户的订单金额排序来生成序号。

* frame子句：frame是当前分区的一个子集，子句用来定义子集的规则，通常用来作为滑动窗口使用。比如要根据每个订单动态计算包括本订单和按时间顺序前后两个订单的平均订单金额，则可以设置如下frame子句来创建滑动窗口：

 ![WDHDUk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/WDHDUk.jpg)

从结果可以看出，order_id为5订单属于边界值，没有前一行，因此平均订单金额为(900+800)/2=850；order_id为4的订单前后都有订单，所以平均订单金额为（900+800+300）/3=666.6667，以此类推就可以得到一个基于滑动窗口的动态平均订单值。此例中，窗口函数用到了传统的聚合函数avg()，用来计算动态的平均值。


## 5.2 窗口函数分类

大致来说，窗口函数可以分为两类。

* 一是将 SUM、MAX、MIN 等聚合函数用在窗口函数中

* 二是RANK、DENSE_RANK 等排序用的专用窗口函数

### 5.2.1 专用窗口函数

* **RANK 函数 （英式排序）** 序号函数

    计算排序时，如果存在相同位次的记录，则会跳过之后的位次。

    例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、4 位……

* **DENSE_RANK 函数 （中式排序）** 序号函数

    同样是计算排序，即使存在相同位次的记录，也不会跳过之后的位次。

    例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、2 位……

* **ROW_NUMBER 函数** 序号函数

    赋予唯一的连续位次。

    例）有 3 条记录排在第 1 位时：1 位、2 位、3 位、4 位

    运行以下代码：

```sql
SELECT  
        product_name,
        product_type,
        sale_price,
        RANK() OVER (
            ORDER BY sale_price) AS ranking,
        DENSE_RANK() OVER (
            ORDER BY sale_price) AS dense_ranking ,
        ROW_NUMBER() OVER (
            ORDER BY sale_price) AS row_num
FROM product
```

![mJkouF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/mJkouF.jpg)


### 5.2.2 聚合函数在窗口函数上的使用

聚合函数在开窗函数中的使用方法和之前的专用窗口函数一样，只是出来的结果是一个 **累计** 的聚合函数值。

运行以下代码：

```sql
SELECT  
        product_id,
        product_name,
        sale_price,
        SUM(sale_price) OVER (ORDER BY product_id) AS current_sum,
        AVG(sale_price) OVER (ORDER BY product_id) AS current_avg  
FROM product;
```

![cV2SWL](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/cV2SWL.jpg)

![9wxzrp](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/9wxzrp.jpg)

可以看出，聚合函数结果是，按我们指定的排序，这里是 product_id，**当前所在行及之前所有的行** 的合计或均值。即累计到当前行的聚合。


对于滑动窗口的范围指定，有两种方式，基于行和基于范围，具体区别如下：

* 基于行：

    通常使用BETWEEN frame_start AND frame_end语法来表示行范围，frame_start和frame_end可以支持如下关键字，来确定不同的动态行记录：
    
    - CURRENT ROW 边界是当前行，一般和其他范围关键字一起使用
    - UNBOUNDED PRECEDING 边界是分区中的第一行
    - UNBOUNDED FOLLOWING 边界是分区中的最后一行
    - expr PRECEDING  边界是当前行减去expr的值
    - expr FOLLOWING  边界是当前行加上expr的值

    比如，下面都是合法的范围：
    
    - rows BETWEEN 1 PRECEDING AND 1 FOLLOWING 窗口范围是当前行、前一行、后一行一共三行记录。
    - rows  UNBOUNDED FOLLOWING 窗口范围是当前行到分区中的最后一行。
    - rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 窗口范围是当前分区中所有行，等同于不写。

* 基于范围：

    和基于行类似，但有些范围不是直接可以用行数来表示的，比如希望窗口范围是一周前的订单开始，截止到当前行，则无法使用rows来直接表示，此时就可以使用范围来表示窗口：INTERVAL 7 DAY PRECEDING。Linux中常见的最近1分钟、5分钟负载是一个典型的应用场景。
    
    有的函数不管有没有frame子句，它的窗口都是固定的，也就是前面介绍的静态窗口，这些函数包括如下：
    
    - CUME_DIST() 分布函数
    - DENSE_RANK()
    - LAG() 前后函数
    - LEAD() 前后函数
    - NTILE()
    - PERCENT_RANK() 分布函数
    - RANK()
    - ROW_NUMBER()

    接下来我们以上例的订单表为例，来介绍每个函数的使用方法。表中各字段含义按顺序分别为订单号、用户id、订单金额、订单创建日期。

## 5.3 窗口函数的的应用 - 计算移动平均

在上面提到，聚合函数在窗口函数使用时，计算的是累积到当前行的所有的数据的聚合。 实际上，还可以指定更加详细的 **汇总范围**。该汇总范围成为 **框架(frame)。**

语法

```sql
<窗口函数> OVER (ORDER BY <排序用列名>
                 ROWS n PRECEDING )  

<窗口函数> OVER (ORDER BY <排序用列名>
                 ROWS BETWEEN n PRECEDING AND n FOLLOWING)
```

PRECEDING（“之前”）， 将框架指定为 “截止到之前 n 行”，加上自身行

FOLLOWING（“之后”）， 将框架指定为 “截止到之后 n 行”，加上自身行

BETWEEN 1 PRECEDING AND 1 FOLLOWING，将框架指定为 “之前 1 行” + “之后 1 行” + “自身”

执行以下代码：

```sql
SELECT  
        product_id,
        product_name,
        sale_price,
        AVG(sale_price) OVER (
                            ORDER BY product_id
                               ROWS 2 PRECEDING) AS moving_avg,
        AVG(sale_price) OVER (
                            ORDER BY product_id
                               ROWS BETWEEN 1 PRECEDING 
                                        AND 1 FOLLOWING) AS moving_avg  
FROM product
```

**执行结果：**

注意观察框架的范围。

ROWS 2 PRECEDING：

![VIohyw](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/VIohyw.jpg)

ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING：

![Spv6ae](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Spv6ae.jpg)

### 5.3.1 窗口函数适用范围和注意事项

* 原则上，窗口函数只能在 SELECT 子句中使用。
* 窗口函数 OVER 中的 ORDER BY 子句并不会影响最终结果的排序。其只是用来决定窗口函数按何种顺序计算。

## 5.4 GROUPING 运算符

### 5.4.1 ROLLUP - 计算合计及小计

常规的 GROUP BY 只能得到每个分类的小计，有时候还需要计算分类的合计，可以用 ROLLUP 关键字。

```sql
SELECT  
        product_type,
        regist_date,
        SUM(sale_price) AS sum_price
        
FROM product

GROUP BY product_type, regist_date 
WITH ROLLUP;
```

得到的结果为：

![pHpDgk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/pHpDgk.jpg)

![fnRGWh](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/fnRGWh.jpg)

这里 ROLLUP 对 product_type, regist_date 两列进行合计汇总。结果实际上有三层聚合，如下图 模块 3 是常规的 GROUP BY 的结果，需要注意的是衣服 有个注册日期为空的，这是本来数据就存在日期为空的，不是对衣服类别的合计； 模块 2 和 1 是 ROLLUP 带来的合计，模块 2 是对产品种类的合计，模块 1 是对全部数据的总计。

ROLLUP 可以对多列进行汇总求小计和合计。

![XpyHSn](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/XpyHSn.jpg)

## 5.5 序号函数

序号函数——row_number() / rank() / dense_rank()。

用途：显示分区中的当前行号

使用场景：希望查询每个用户订单金额最高的前三个订单

![BQMIpR](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/BQMIpR.jpg)

此时可以使用ROW_NUMBER()函数按照用户进行分组并按照订单日期进行由大到小排序，最后查找每组中序号<=3的记录。

对于用户‘002’的订单，大家发现订单金额为800的有两条，序号随机排了1和2，但很多情况下二者应该是并列第一，而订单为600的序号则可能是第二名，也可能为第三名，这时候，row_number就不能满足需求，需要rank和dense_rank出场。

这两个函数和row_number()非常类似，只是在出现重复值时处理逻辑有所不同。

上面例子我们稍微改一下，需要查询不同用户的订单中，按照订单金额进行排序，显示出相应的排名序号，SQL中用row_number() / rank() / dense_rank()分别显示序号，我们看一下有什么差别：

![XPkXyH](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/XPkXyH.jpg)

上面红色粗体显示了三个函数的区别，row_number()在amount都是800的两条记录上随机排序，但序号按照1、2递增，后面amount为600的的序号继续递增为3，中间不会产生序号间隙；rank()/dense_rank()则把amount为800的两条记录序号都设置为1，但后续amount为600的需要则分别设置为3（rank）和2（dense_rank）。即rank（）会产生序号相同的记录，同时可能产生序号间隙；而dense_rank（）也会产生序号相同的记录，但不会产生序号间隙。

## 5.6 分布函数

分布函数——percent_rank()/cume_dist()。

percent_rank()

用途：和之前的RANK()函数相关，每行按照如下公式进行计算：

(rank - 1) / (rows - 1)

其中，rank为RANK()函数产生的序号，rows为当前窗口的记录总行数。

![Fxt9WQ](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Fxt9WQ.jpg)

从结果看出，percent列按照公式(rank - 1) / (rows - 1)带入rank值（row_num列）和rows值（user_no为‘001’和‘002’的值均为5）。

cume_dist()

用途：分组内小于等于当前rank值的行数/分组内总行数，这个函数比percen_rank使用场景更多。

应用场景：大于等于当前订单金额的订单比例有多少。


SQL如下：

![vfY56p](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/vfY56p.jpg)

列cume显示了预期的数据分布结果。

## 5.7 前后函数

前后函数——lead(n)/lag(n)。

用途：分区中位于当前行前n行（lead）/后n行(lag)的记录值。

使用场景：查询上一个订单距离当前订单的时间间隔。

SQL如下：

![nsPbBE](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/nsPbBE.jpg)

内层SQL先通过lag函数得到上一次订单的日期，外层SQL再将本次订单和上次订单日期做差得到时间间隔diff。

## 5.8 头尾函数

头尾函数——first_val(expr)/last_val(expr)。

用途：得到分区中的第一个/最后一个指定参数的值。

使用场景：查询截止到当前订单，按照日期排序第一个订单和最后一个订单的订单金额。

SQL如下：

![dtJk8H](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/dtJk8H.jpg)

结果和预期一致，比如order_id为4的记录，first_amount和last_amount分别记录了用户‘001’截止到时间2018-01-03 00:00:00为止，第一条订单金额100和最后一条订单金额800，注意这里是按时间排序的最早订单和最晚订单，并不是最小金额和最大金额订单。

## 5.9 其他函数

 

其他函数——nth_value(expr,n)/nfile(n）。

nth_value(expr,n)

用途：返回窗口中第N个expr的值，expr可以是表达式，也可以是列名。

应用场景：每个用户订单中显示本用户金额排名第二和第三的订单金额。

SQL如下：

![hNPTk0](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/hNPTk0.jpg)


nfile(n)

用途：将分区中的有序数据分为n个桶，记录桶号。

应用场景：将每个用户的订单按照订单金额分成3组。


SQL如下：

![73v7aH](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/73v7aH.jpg)

此函数在数据分析中应用较多，比如由于数据量大，需要将数据平均分配到N个并行的进程分别计算，此时就可以用NFILE(N)对数据进行分组，由于记录数不一定被N整除，所以数据不一定完全平均，然后将不同桶号的数据再分配。

## 练习题

### 练习 5.1

请说出针对本章中使用的 product（商品）表执行如下 SELECT 语句所能得到的结果。

```sql
SELECT  
        product_id,
        product_name,
        sale_price,
        MAX(sale_price) OVER (ORDER BY product_id) AS Current_max_price
FROM product
```

> 按照 product_id 升序排列，计算出截⾄当前⾏的最⾼ sale_price 。

### 练习 5.2

继续使用 product 表，计算出按照登记日期（regist_date）升序进行排列的各日期的销售单价（sale_price）的总额。排序是需要将登记日期为 NULL 的“运动 T 恤”记录排在第 1 位（也就是将其看作比其他日期都早）

如下两种⽅法都可以实现：

```sql
-- ①regist_date为NULL时，显示“1年1⽉1⽇”。 

SELECT 
    regist_date, 
    product_name, 
    sale_price, 
    SUM(sale_price) OVER (
        ORDER BY COALESCE(regist_date, CAST('0001-01-01' AS DATE))) AS current_sum_price 

FROM Product;

-- ②regist_date为NULL时，将该记录放在最前显示。 

SELECT 
    regist_date, 
    product_name, 
    sale_price, 
    SUM(sale_price) OVER (
        ORDER BY regist_date NULLS FIRST) AS current_sum_price 
FROM Product;

```

### 练习 5.3

思考题

① 窗口函数不指定 PARTITION BY 的效果是什么？

> 窗⼝函数不指定 PARTITION BY 就是针对排序列进⾏全局排序。

② 为什么说窗口函数只能在 SELECT 子句中使用？实际上，在 ORDER BY 子句使用系统并不会报错

本质上是因为 SQL 语句的执⾏顺序。

**FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY**

如果在 WHERE, GROUP BY, HAVING 使⽤了窗⼝函数，就是说提前进⾏了⼀次排序，排序之后再去除 记录、汇总、汇总过滤，第⼀次排序结果就是错误的，没有实际意义。⽽ ORDER BY 语句执⾏顺序在 SELECT 语句之后，⾃然是可以使⽤的。

