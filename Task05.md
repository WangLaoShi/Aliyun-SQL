本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql
# Task05：窗口函数

[TOC]

## 5.1 窗口函数

### 5.1.1 窗口函数概念及基本的使用方法

窗口函数也称为 **OLAP** 函数。OLAP 是 OnLine Analytical Processing 的简称，意思是**对数据库数据进行实时分析处理**。

为了便于理解，称之为窗口函数。常规的 SELECT 语句都是对整张表进行查询，而窗口函数可以让我们有选择的去某一部分数据进行汇总、计算和排序。

窗口函数的通用形式：

```sql
<窗口函数> OVER ([PARTITION BY <列名>]
                     ORDER BY <排序用列名>)
```

_[] 中的内容可以省略。  

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

## 5.2 窗口函数分类

大致来说，窗口函数可以分为两类。

* 一是将 SUM、MAX、MIN 等聚合函数用在窗口函数中

* 二是RANK、DENSE_RANK 等排序用的专用窗口函数

### 5.2.1 专用窗口函数

* **RANK 函数 （英式排序）**

    计算排序时，如果存在相同位次的记录，则会跳过之后的位次。

    例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、4 位……

* **DENSE_RANK 函数 （中式排序）**

    同样是计算排序，即使存在相同位次的记录，也不会跳过之后的位次。

    例）有 3 条记录排在第 1 位时：1 位、1 位、1 位、2 位……

* **ROW_NUMBER 函数**

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

GROUP BY product_type, regist_date WITH ROLLUP
```

得到的结果为：

![pHpDgk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/pHpDgk.jpg)

![fnRGWh](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/fnRGWh.jpg)

这里 ROLLUP 对 product_type, regist_date 两列进行合计汇总。结果实际上有三层聚合，如下图 模块 3 是常规的 GROUP BY 的结果，需要注意的是衣服 有个注册日期为空的，这是本来数据就存在日期为空的，不是对衣服类别的合计； 模块 2 和 1 是 ROLLUP 带来的合计，模块 2 是对产品种类的合计，模块 1 是对全部数据的总计。

ROLLUP 可以对多列进行汇总求小计和合计。

![XpyHSn](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/XpyHSn.jpg)

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
