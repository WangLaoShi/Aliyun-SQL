# 数据分析 MySQL-窗口函数篇

## 理论

MySQL 从 8.0 之后开始支持窗口函数，也叫分析函数，用于处理相对复杂的报表统计分析场景。

窗口函数：窗口、函数（应用在窗口内的函数）-----窗口类似于窗户，限定一个空间范围。

窗口的概念非常重要，它可以理解为**记录集合**，窗口函数也就是在满足某种条件的记录集合上执行的特殊函数。

对于每条记录都要在此窗口内执行函数，窗口大小都是固定的，这种属于静态窗口；

不同的记录对应着不同的窗口，这种动态变化的窗口叫滑动窗口。

```sql
函数名([expr]) OVER 子句函数()
```

其中，

* OVER 是关键字，用来指定函数执行的窗口范围，包含三个分析子句：分组(PARTITION BY)子句，排序(ORDER BY)子句，窗口(ROWS)子句
* 如果后面括号中什么都不写，则意味着窗口包含满足 WHERE 条件的所有行，窗口函数基于所有行进行计算；如果不为空，则支持以下语法来设置窗口：

```sql
函数名（[expr]） OVER(
    PARTITION BY <要分列的组> 
    ORDER BY <要排序的列> 
    ROW BETWEEN <数据范围>
    )
```

知识点总结：

```sql
SUM(...A...) 
OVER(
    PARTITION BY ...B...
    ORDER BY ...C... 
    ROWS BETWEEN ...D1... AND ...D2...
)


AVG(...A...) 
OVER(
    PARTITION BY ...B... 
    ORDER BY ...C... 
    ROWS BETWEEN ...D1... AND ...D2...
)
```

* A：需要被加工的字段
* B：分组字段
* C：排序字段
* D：计算的行数范围

滑动窗口的示例：

* ROWS BETWEEN 2 preceding AND current row # 取当前行和前面两行 
* ROWS BETWEEN unbounded preceding AND current row # 包括本行和之前所有的行 
* ROWS BETWEEN current row AND unbounded following # 包括本行和之后所有的行 
* ROWS BETWEEN 3 preceding AND current row # 包括本行和前面三行 
* ROWS BETWEEN 3 preceding AND 1 following # 从前面三行和下面一行，总共五行 
* 当 ORDER BY 后面缺少窗口从句条件，窗口规范默认是 ROWS BETWEEN unbounded preceding AND current row 
* 当 ORDER BY 和窗口从句都缺失，窗口规范默认是 ROWS BETWEEN unbounded preceding AND unbounded following


## 应用

窗口函数一般分为：

* 专有窗口函数：

    - RANK()
    - DENSE_RANK()
    - ROW_NUMBER()

* 聚合类窗口函数：

    - SUM()
    - COUNT()
    - AVG()
    - MAX()
    - MIN()

窗口函数和普通场景下的聚合函数的区别：

* 普通场景下的聚合函数是将多条记录聚合为一条 **（多到一）**；窗口函数是每条记录都会执行，有几条记录执行完还是几条 **（多到多）**。
* 分组(PARTITION BY)：记录按照字段进行分组，窗口函数在不同的分组上分别执行。
* 排序(ORDER BY)：按照哪些字段进行排序，窗口函数将按照排序后的记录顺序进行编号，可以和 PARTITION 子句配合使用，也可以单独使用。如果没有 PARTITION 子句，数据范围则是整个表的数据行。
* 窗口(ROWS)：就是进行函数分析时要处理的数据范围，属于当前分区的一个子集，通常用来作为滑动窗口使用。比如要根据每个订单动态计算包括本订单和按时间顺序前后两个订单的移动平均支付金额，则可以设置 ROWS 子句来创建滑动窗口(ROWS)。

案例：

现有 2018～2020 某电商平台订单信息表

列名             | 释义  
-------------- | ----
user_name      | 用户名 
piece          | 购买数量
price          | 价格  
pay_amount     | 支付金额
goods_category | 商品品类
pay_time       | 支付时间

```sql
CREATE TABLE user_trade 
( 
    user_name varchar(20), 
    piece int, 
    price double, 
    pay_amount double, 
    goods_category varchar(20), 
    pay_time date 
);
```

数据前10行：

![mhNg5x](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/mhNg5x.jpg)

—— 实验数据如上，可自行按照数据结构编写数据 ——

### 需求1: 查询出 2019 年每月的支付总额和当年累计支付总额

```sql
-- 1. 查询2019年的数据
SELECT * 
FROM user_trade 
WHERE YEAR(pay_time) = 2019;

-- 2. 统计每月支付总额
SELECT 
  MONTH(pay_time),
  SUM(pay_amount) 
FROM user_trade WHERE YEAR(pay_time) = 2019 
GROUP BY MONTH(pay_time);

-- 3. 窗口函数实现
SELECT 
  a.month, -- 月
  a.pay_amount,-- 当月总支付金额
  SUM(a.pay_amount) OVER(ORDER BY a.month)
FROM (
    SELECT 
      MONTH(pay_time) month,
      SUM(pay_amount) pay_amount 
    FROM 
      user_trade 
    WHERE YEAR(pay_time)=2019 
    GROUP BY MONTH(pay_time)) AS a;
```

### 需求2: 查询出 2018-2019 年每月的支付总额和当年累计支付金额

```sql
-- 1. 过滤数据
SELECT * 
FROM user_trade 
WHERE YEAR(pay_time) in (2018,2019);

-- 2. 每月支付总额
SELECT 
  YEAR(pay_time),
  MONTH(pay_time),
  SUM(pay_amount)
FROM
  user_trade
WHERE
  YEAR(pay_time) IN (2018,2019)
GROUP BY 
  YEAR(pay_time),MONTH(pay_time);
  
-- 3. 窗口函数解决需求
SELECT 
  a.year,
  a.month,
  a.pay_amount,
  SUM(a.pay_amount) OVER(PARTITION BY a.year ORDER BY a.month)
FROM(
    SELECT 
      YEAR(pay_time) year,
      MONTH(pay_time) month,
      SUM(pay_amount) pay_amount
    FROM
      user_trade
    WHERE
      YEAR(pay_time) IN (2018,2019)
    GROUP BY
      YEAR(pay_time),MONTH(pay_time)
    ) as a;
```

### 需求3: 查询出 2019 年每个月的近三月移动平均支付金额

```sql
SELECT 
  a.month,
  a.pay_amount,
  AVG(a.pay_amount) OVER(ORDER BY a.month ROWS BETWEEN 2 preceding AND current row)
FROM(
    SELECT 
       MONTH(pay_time) month,
       SUM(pay_amount) pay_amount
    FROM user_trade
    WHERE YEAR(pay_time) = 2019
    GROUP BY MONTH(pay_time)
    ) AS a;
```

### 需求4: 查询出每四个月的最大月总支付金额 

```sql
SELECT 
  a.month, 
  a.pay_amount, 
  MAX(a.pay_amount) OVER(ORDER BY a.month ROWS BETWEEN 3 preceding AND current row)
FROM(
    SELECT 
      SUBSTR(pay_time,1,7) AS month, 
      SUM(pay_amount) AS pay_amount 
    FROM user_trade 
    GROUP BY SUBSTR(pay_time,1,7)
    ) AS a;
```

### 需求5: 2020年1月，购买商品品类数用户排名

```sql
/*
2020年1月（基础数据范围） 
一个商品属于某一个品类 
A用户购买了100件商品，那么可能涉及到了10个品类 
B用户购买了50件商品，那么可能涉及到了15个品类 
根据所购买商品涉及的品类数量进行排名（给用户） 
思路：
1）先把各个用户所购买商品涉及的品类数给统计出来 
2) 在1的基础上排名，使count()用到排名窗口函数
*/
SELECT 
  user_name,
  COUNT(DISTINCT goods_category) category_count,
  ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT goods_category)) order_row_number,
  RANK() OVER(ORDER BY COUNT(DISTINCT goods_category)) order_rank,
  DENSE_RANK() OVER(ORDER BY COUNT(DISTINCT goods_category)) order_dense_rank
FROM user_trade
WHERE SUBSTR(pay_time,1,7) = '2020-01'
GROUP BY user_name;
```

这三个函数的作用都是返回相应规则的排序序号

### 需求6: 查询出将 2020 年 2 月的支付用户，按照支付金额分成 5 组后的结果 

```sql
-- 需求6: 查询出将2020年2月的支付用户，按照支付金额分成5组后的结果 
SELECT 
  user_name, 
  SUM(pay_amount) pay_amount, 
  NTILE(5) OVER(ORDER BY SUM(pay_amount) desc) level 
FROM user_trade 
WHERE SUBSTR(pay_time,1,7)='2020-02' 
GROUP BY user_name;
```

### 需求7: 查询出 2020 年支付金额排名前 30% 的所有用户 

```sql
-- 需求7: 查询出2020年支付金额排名前30%的所有用户 
SELECT 
  a.user_name, 
  a.pay_amount, 
  a.level 
FROM (
    SELECT 
      user_name, 
      SUM(pay_amount) pay_amount, 
      NTILE(10) OVER(ORDER BY SUM(pay_amount) DESC) level 
    FROM user_trade 
    WHERE YEAR(pay_time) = 2020 
    GROUP BY user_name
  ) AS a 
WHERE a.level IN (1,2,3);
```

知识点总结:

ntile(**n**) OVER(PARTITION BY ...**A**... ORDER BY ...**B**... )

**n**:切分的片数

**A**:分组的字段名称

**B**:排序的字段名称

ntile(**n**)，用于将分组数据按照顺序切分成 n 片，返回当前切片值 NTILE 不支持ROWS BETWEEN

### 需求8: 查询出King和West的时间偏移(前N行) 

King 和 West 是其中的 2 个 user，可以根据实际情况进行替换。

```sql
SELECT user_trade.user_name,count(*)
FROM user_trade
GROUP BY user_trade.user_name
HAVING count(*) > 2;
```

```sql
-- 需求8: 查询出King和West的时间偏移(前N行) 
SELECT 
  user_name, 
  pay_time, 
  LAG(pay_time,1,pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lag_1_paytime,
  -- 没有传入偏移量，那么默认就是1，找不到的话，此处也没有给默认值，为null 
  LAG(pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lag_1_null,
  LAG(pay_time,2,pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lag_2_paytime, 
  LAG(pay_time,2) OVER(PARTITION BY user_name ORDER BY pay_time) lag_2_null
FROM user_trade 
WHERE user_name in ('King','West');
```

### 需求9: King和West的时间偏移(后N行) 

```sql
-- 需求9: King和West的时间偏移(后N行) 
SELECT 
  user_name, 
  pay_time, 
  LEAD(pay_time,1,pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lead_1_paytime, 
  LEAD(pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lead_1_null, 
  LEAD(pay_time,2,pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lead_2_paytime, 
  LEAD(pay_time,2) OVER(PARTITION BY user_name ORDER BY pay_time) lead_2_null 
FROM user_trade 
WHERE user_name in ('King','West');
```

知识点总结:

**Lag**和**Lead**函数可以在同一次查询中取出同一字段的前**N**行的数据**(Lag)**和后**N**行的数据**(Lead)**作为 独立的列。

在实际应用当中，若要用到取今天和昨天的某字段差值时，Lag和Lead函数的应用就显得尤为重要。

**lag(exp_str,offffset,defval) OVER(partion by ......ORDER BY ......)**

**lead(exp_str,offffset,defval) OVER(partion by ......ORDER BY ......)**

exp_str是字段名称。 

offffset是偏移量，即是上 1 个或上 N 个的值，假设当前行在表中排在第5行，则offffset 为 3，则表示我们所要找的数据行就是表中的第2行(即5-3=2)。
offffset默认值为1。defval 默认值，当两个函数取上N/下N个值，当在表中从当前行位置向前数N行已经超出了表的范围时，lag()函数将defval这个参数值作为函数的返回值，若没有指定默认值，则返回NULL，那么在数学运算中，总要给一个默认值才不会出错。

### 需求10: 查询出支付时间间隔超过100天的用户数 

```sql
-- 需求10: 查询出支付时间间隔超过100天的用户数 
SELECT 
  count(distinct user_name) 
FROM(
  SELECT 
    user_name, 
    pay_time, 
    LEAD(pay_time) OVER(PARTITION BY user_name ORDER BY pay_time) lead_dt 
  FROM user_trade
  ) AS a 
WHERE a.lead_dt IS NOT NULL AND DATEDIFF(a.lead_dt,a.pay_time)>100;
```

### 需求11: 查询出每年支付时间间隔最长的用户

```sql
-- 需求11: 查询出每年支付时间间隔最长的用户
SELECT
  years,
  b.user_name,
  b.pay_days
FROM(
  SELECT
    years,
    a.user_name, 
    DATEDIFF(a.pay_time,a.lag_dt) pay_days,
    RANK() OVER(
        PARTITION BY years 
        ORDER BY DATEDIFF(a.pay_time,a.lag_dt) desc) ranking
   FROM(
      SELECT
        YEAR(pay_time) as years, 
        user_name,
        pay_time,
        LAG(pay_time) OVER(
            PARTITION BY user_name,YEAR(pay_time) 
            ORDER BY pay_time
            ) lag_dt
         FROM user_trade
        ) AS a
   WHERE a.lag_dt is not null
   ) AS b
WHERE b.ranking=1;
```