# 数据分析MySQL-窗口函数篇

## 理论

MySQL从8.0之后开始支持窗口函数，也叫分析函数。（用于处理相对复杂的报表统计分析场景）。

窗口函数：窗口、函数（应用在窗口内的函数）-----窗口类似于窗户，限定一个空间范围。

窗口的概念非常重要，它可以理解为**记录集合**，窗口函数也就是在满足某种条件的记录集合上执行的特殊函数。对于每条记录都要在此窗口内执行函数，窗口大小都是固定的，这种属于静态窗口；不同的记录对应着不同的窗口，这种动态变化的窗口叫滑动窗口。

```sql
函数名 （[expr]）over子句函数（）over（）
```

其中，

* over是关键字，用来指定函数执行的窗口范围，包含三个分析子句：分组(partition by)子句，排序(order by)子句，窗口(rows)子句，
* 如果后面括号中什么都不写，则意味着窗口包含满足where条件的所有行，窗口函数基于所有行进行计算；如果不为空，则支持以下语法来设置窗口：

```sql
函数名（[expr]） over(
    partition by <要分列的组> 
    order by <要排序的列> 
    rows between <数据范围>
    )
```

知识点总结：

```sql

sum(...A...) 
over(
    partition by ...B...
    order by ...C... 
    rows between ...D1... and ...D2...
)


avg(...A...) 
over(
    partition by ...B... 
    order by ...C... 
    rows between ...D1... and ...D2...
)

A：需要被加工的字段
B：分组字段
C：排序字段
D：计算的行数范围
​
​
rows between 2 preceding and current row # 取当前行和前面两行 
rows between unbounded preceding and current row # 包括本行和之前所有的行 
rows between current row and unbounded following # 包括本行和之后所有的行 
rows between 3 preceding and current row # 包括本行和前面三行 
rows between 3 preceding and 1 following # 从前面三行和下面一行，总共五行 
# 当order by后面缺少窗口从句条件，窗口规范默认是rows between unbounded preceding and current row. 
# 当order by和窗口从句都缺失， 窗口规范默认是 rows between unbounded preceding and unbounded following
```

## 应用

窗口函数一般分为：

* 专有窗口函数：

    - rank（）
    - dense_rank（）
    - row_number（）

* 聚合类窗口函数：

    - sum（）
    - count（）
    - avg（）
    - max（）
    - min（）

窗口函数和普通场景下的聚合函数的区别：

* 普通场景下的聚合函数是将多条记录聚合为一条**（多到一）**；窗口函数是每条记录都会执行，有几条记录执行完还是几条**（多到多）**。
* 分组(partition by)：记录按照字段进行分组，窗口函数在不同的分组上分别执行。
* 排序(order by)：按照哪些字段进行排序，窗口函数将按照排序后的记录顺序进行编号，可以和partition子句配合使用，也可以单独使用。如果没有partition子句，数据范围则是整个表的数据行。
* 窗口(rows)：就是进行函数分析时要处理的数据范围，属于当前分区的一个子集，通常用来作为滑动窗口使用。比如要根据每个订单动态计算包括本订单和按时间顺序前后两个订单的移动平均支付金额，则可以设置rows子句来创建滑动窗口(rows)。

案例：

现有2018～2020某电商平台订单信息表

列名             | 释义  
-------------- | ----
user_name      | 用户名 
piece_num      | 购买数量
price          | 价格  
pay_amount     | 支付金额
goods_category | 商品品类
pay_time       | 支付时间

```sql
create table user_trade 
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

### 需求1: 查询出2019年每月的支付总额和当年累计支付总额

```sql

-- 

# 1、查询2019年的数据
select * from user_trade where year(pay_time) = 2019;

# 2、统计每月支付总额
select month(pay_time),sum(pay_amount) from user_trade where year(pay_time)=2019 group by month(pay_time);

# 3、窗口函数实现
select 
  a.month, -- 月
  a.pay_amount,--当月总支付金额
  sum(a.pay_amount) over(order by a.month)
from (
    select 
      month(pay_time) month,
      sum(pay_amount) pay_amount 
    from 
      user_trade 
    where year(pay_time)=2019 
    group by month(pay_time)) as a;
```

![jhzSpn](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/jhzSpn.jpg)


### 需求2: 查询出2018-2019年每月的支付总额和当年累计支付金额

```sql
--

# 1、过滤数据
select * from user_trade where year（pay_time）in （2018,2019）;

# 2、每月支付总额
select 
  year（pay_time）,
  month（pay_time）,
  sum（pay_amount）
from
  user_trade
where
  year（pay_time）in（2018,2019)
group by 
  year(pay_time ),
  month(pay_time)
  
# 3、窗口函数解决需求
select 
  a.year,
  a.month,
  a.pay_amount,
  sum(a.pay_amount) over(partition by a.year order by a.month)
from
  (select 
  year（pay_time）year,
  month（pay_time）month,
  sum（pay_amount）pay_amount
from
  user_trade
where
  year（pay_time）in（2018,2019)
group by 
  year(pay_time ),
  month(pay_time)) as a;
```

![bW8mUs](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/bW8mUs.jpg)

### 需求3: 查询出2019年每个月的近三月移动平均支付金额

```sql
--
select 
  a.month,
  a.pay_mount,
  avg(a.pay_amount) over(order by a.month rows between 2 preceding and current row)
from
  (select 
       month(pay_time) month,
       sum(pay_amount) pay_amount
     from user_trade
     where year(pay_time) = 2019
     group by month(pay_time))a;
```

![6WAfTM](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/6WAfTM.jpg)


### 需求4: 查询出每四个月的最大月总支付金额 

```sql
-- 
SELECT 
  a.month, 
  a.pay_amount, 
  max(a.pay_amount) over(order by a.month rows between 3 preceding and current row)
FROM 
  (SELECT substr(pay_time,1,7) as month, sum(pay_amount) 
  as pay_amount FROM user_trade GROUP BY substr(pay_time,1,7))a;
```

![nxjR6u](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/nxjR6u.jpg)

### 需求5: 2020年1月，购买商品品类数用户排名

```sql
-- 
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
select 
  user_name,
  count(distinct goods_category) category_count,
  row_number() over(order by count(distinct goods_category)) order1,
  rank() over(order by count(distinct goods_category)) order2,
  dense_rank() over(order by count(distinct goods_category)) order3
from user_trade
where substring(pay_time,1,7) = '2020-01'
group by
  user_name;
```

![wjRo4a](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/wjRo4a.jpg)

这三个函数的作用都是返回相应规则的排序序号

row_number() over(partition by ...**A**... order by ...**B**... )

rank() over(partition by ...**A**... order by ...**B**... )

dense_rank() over(partition by ...**A**... order by ...**B**... )

**A**:分组的字段名称

**B**:排序的字段名称

注意:

row_number()、rank() 和dense_rank()紧邻的括号内是不加任何字段名称的。

**row_number**:它会为查询出来的每一行记录生成一个序号，依次排序且不会重复。

**rank&dense_rank**:如果使用rank函数来生成序号，over子句中排序字段值相同的序号是一样的，后面字段值不相同的序号将跳过相同的排名号排下一个，也就是相关行之前的排名数加一。

dense_rank函数在生成序号时是连续的，而rank函数生成的序号有可能不连续。

dense_rank函数出现相同排名时，将不跳过相同排名号，rank值紧接上一次的rank值。

在各个分组内，rank()是跳跃排序，有两个第一名时接下来就是第三名，dense_rank()是连续排序，有两个第一名时仍然跟着第二名。


### 需求6: 查询出将2020年2月的支付用户，按照支付金额分成5组后的结果 

```sql
-- 需求6: 查询出将2020年2月的支付用户，按照支付金额分成5组后的结果 
SELECT 
  user_name, 
  sum(pay_amount) pay_amount, 
  ntile(5) over(order by sum(pay_amount) desc) level 
FROM user_trade 
WHERE substr(pay_time,1,7)='2020-02' 
GROUP BY user_name;
```

![Lh1sR3](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Lh1sR3.jpg)

### 需求7: 查询出2020年支付金额排名前30%的所有用户 

```sql
-- 需求7: 查询出2020年支付金额排名前30%的所有用户 
SELECT 
  a.user_name, 
  a.pay_amount, 
  a.level 
FROM 
  (SELECT user_name, sum(pay_amount) pay_amount, ntile(10) over(order by sum(pay_amount) desc) level FROM user_trade WHERE year(pay_time)=2020 GROUP BY user_name)a WHERE a.level in (1,2,3);
```

![2wjkaU](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/2wjkaU.jpg)

知识点总结:

ntile(**n**) over(partition by ...**A**... order by ...**B**... )

**n**:切分的片数

**A**:分组的字段名称

**B**:排序的字段名称

ntile(**n**)，用于将分组数据按照顺序切分成n片，返回当前切片值NTILE不支持ROWS BETWEEN


### 需求8: 查询出King和West的时间偏移(前N行) 

```sql
-- 需求8: 查询出King和West的时间偏移(前N行) 
SELECT 
  user_name, 
  pay_time, 
  lag(pay_time,1,pay_time) over(partition by user_name order by pay_time) lag1,
  -- 没有传入偏移量，那么默认就是1，找不到的话，此处也没有给默认值， 为null 
  lag(pay_time) over(partition by user_name order by pay_time) lag2,
  lag(pay_time,2,pay_time) over(partition by user_name order by pay_time) lag3, 
  lag(pay_time,2) over(partition by user_name order by pay_time) lag4 
FROM user_trade WHERE user_name in ('King','West');
```

![Vetl1N](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/Vetl1N.jpg)

### 需求9: King和West的时间偏移(后N行) 

```sql
-- 需求9: King和West的时间偏移(后N行) 
SELECT 
  user_name, 
  pay_time, 
  lead(pay_time,1,pay_time) over(partition by user_name order by pay_time) lead1, 
  lead(pay_time) over(partition by user_name order by pay_time) lead2, 
  lead(pay_time,2,pay_time) over(partition by user_name order by pay_time) lead3, 
  lead(pay_time,2) over(partition by user_name order by pay_time) lead4 
FROM user_trade WHERE user_name in ('King','West');
```

![AuHR19](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/AuHR19.jpg)

知识点总结:

**Lag**和**Lead**函数可以在同一次查询中取出同一字段的前**N**行的数据**(Lag)**和后**N**行的数据**(Lead)**作为 独立的列。

在实际应用当中，若要用到取今天和昨天的某字段差值时，Lag和Lead函数的应用就显得尤为重要。

**lag(exp_str,offffset,defval) over(partion by ......order by ......)**

**lead(exp_str,offffset,defval) over(partion by ......order by ......)**

exp_str是字段名称。 offffset是偏移量，即是上1个或上N个的值，假设当前行在表中排在第5行，则offffset 为3，则表示我 们所要找的数据行就是表中的第2行(即5-3=2)。offffset默认值为1。defval默认值，当两个函数取上N/下N个值，当在表中从当前行位置向前数N行已经超出了表的范围时，lag()函数将defval这个参数值作为函数的返回值，若没有指定默认值，则返回NULL，那么在数学运算中，总要给一个默认值才不会出错。


### 需求10: 查询出支付时间间隔超过100天的用户数 

```sql
--需求10: 查询出支付时间间隔超过100天的用户数 
SELECT 
  count(distinct user_name) 
FROM 
  (SELECT user_name, pay_time, lead(pay_time) over(partition by user_name order by pay_time) lead_dt FROM user_trade)a 
WHERE a.lead_dt is not null and datediff(a.lead_dt,a.pay_time)>100;
```

![6Neoqb](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/6Neoqb.jpg)

### 需求11: 查询出每年支付时间间隔最长的用户

```sql
-- 需求11: 查询出每年支付时间间隔最长的用户
SELECT
 years,
 b.user_name,
       b.pay_days
FROM
   (SELECT
 years,
 a.user_name, 
           datediff(a.pay_time,a.lag_dt) pay_days,
           rank() over(partition by years order by 
datediff(a.pay_time,a.lag_dt) desc) rank1
   FROM
       (SELECT
 year(pay_time) as years, 
 user_name,
               pay_time,
               lag(pay_time) over(partition by user_name,year(pay_time) 
order by pay_time) lag_dt
         FROM user_trade)a
   WHERE a.lag_dt is not null)b
WHERE b.rank1=1;
```

![XwbRTJ](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/XwbRTJ.jpg)