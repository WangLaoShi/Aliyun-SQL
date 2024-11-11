在本教程中，您将学习如何使用MySQL `DATE_FORMAT`函数来格式化基于特定格式的日期值。

## MySQL DATE_FORMAT函数简介

要将日期值格式化为特定格式，请使用`DATE_FORMAT`函数。 `DATE_FORMAT`函数的语法如下：

```sql
DATE_FORMAT(date,format);
```

`DATE_FORMAT()`函数接受两个参数：

* `date`：是要格式化的有效日期值
* `format`：是由预定义的说明符组成的格式字符串，每个说明符前面都有一个百分比字符(`%`)。有关预定义说明符的列表，请参见下表。

`DATE_FORMAT`函数返回字符集和校对规则取决于客户端连接的设置的字符串。

下表说明了可用于构建日期格式字符串的说明符及其含义：

**限定符** | **含义**                                                   
------- | ---------------------------------------------------------
`%a`    | 三个字符缩写的工作日名称，例如:_Mon_, _Tue_, _Wed_,等                    
`%b`    | 三个字符缩写的月份名称，例如：_Jan_，_Feb_，_Mar_等                        
`%c`    | 以数字表示的月份值，例如：1, 2, 3…12                                  
`%D`    | 英文后缀如：_0th_, _1st_, _2nd_等的一个月之中的第几天                     
`%d`    | 如果是`1`个数字(小于`10`)，那么一个月之中的第几天表示为加前导加`0`，如：00, 01,02, …31
`%e`    | 没有前导零的月份的日子，例如：1,2，… 31                                  
`%f`    | 微秒，范围在`000000..999999`                                   
`%H`    | 24小时格式的小时，前导加`0`，例如：00,01..23                            
`%h`    | 小时，12小时格式，带前导零，例如：01，02 … 12                             
`%I`    | 与`%h`相同                                                  
`%i`    | 分数为零，例如：00,01，… 59                                       
`%j`    | 一年中的的第几天，前导为`0`，例如，001,002，… 366                         
`%k`    | 24小时格式的小时，无前导零，例如：0,1,2 … 23                             
`%l`    | 12小时格式的小时，无前导零，例如：0,1,2 … 12                             
`%M`    | 月份全名称，例如：January, February,…December                     
`%m`    | 具有前导零的月份名称，例如：00,01,02，… 12                              
`%p`    | `AM`或`PM`，取决于其他时间说明符                                     
`%r`    | 表示时间，`12`小时格式`hh:mm:ss AM`或`PM`                          
`%S`    | 表示秒，前导零，如：00,01，… 59                                     
`%s`    | 与`%S`相同                                                  
`%T`    | 表示时间，24小时格式`hh:mm:ss`                                    
`%U`    | 周的第一天是星期日，例如：00,01,02 … 53时，前导零的周数                       
`%u`    | 周的第一天是星期一，例如：00,01,02 … 53时，前导零的周数                       
`%V`    | 与`%U`相同，它与`%X`一起使用                                       
`%v`    | 与`%u`相同，它与`%x`一起使用                                       
`%W`    | 工作日的全称，例如：Sunday, Monday,…, Saturday                     
`%w`    | 工作日，以数字来表示(0 = 星期日，1 = 星期一等)                             
`%X`    | 周的四位数表示年份，第一天是星期日; 经常与`%V`一起使用                           
`%x`    | 周的四位数表示年份，第一天是星期日; 经常与`%v`一起使用                           
`%Y`    | 表示年份，四位数，例如2000，2001，…等。                                 
`%y`    | 表示年份，两位数，例如00，01，…等。                                     
`%%`    | 将百分比(`%`)字符添加到输出                                         

以下是一些常用的日期格式字符串：

DATE_FORMAT字符串       | 格式化日期                          
-------------------- | -------------------------------
`%Y-%m-%d`           | 2017/4/30                      
`%e/%c/%Y`           | 4/7/2013                       
`%c/%e/%Y`           | 7/4/2013                       
`%d/%m/%Y`           | 4/7/2013                       
`%m/%d/%Y`           | 7/4/2013                       
`%e/%c/%Y %H:%i`     | 4/7/2013 11:20                 
`%c/%e/%Y %H:%i`     | 7/4/2013 11:20                 
`%d/%m/%Y %H:%i`     | 4/7/2013 11:20                 
`%m/%d/%Y %H:%i`     | 7/4/2013 11:20                 
`%e/%c/%Y %T`        | 4/7/2013 11:20                 
`%c/%e/%Y %T`        | 7/4/2013 11:20                 
`%d/%m/%Y %T`        | 4/7/2013 11:20                 
`%m/%d/%Y %T`        | 7/4/2013 11:20                 
`%a %D %b %Y`        | Thu 4th Jul 2013               
`%a %D %b %Y %H:%i`  | Thu 4th Jul 2013 11:20         
`%a %D %b %Y %T`     | Thu 4th Jul 2013 11:20:05      
`%a %b %e %Y`        | Thu Jul 4 2013                 
`%a %b %e %Y %H:%i`  | Thu Jul 4 2013 11:20           
`%a %b %e %Y %T`     | Thu Jul 4 2013 11:20:05        
`%W %D %M %Y`        | Thursday 4th July 2013         
`%W %D %M %Y %H:%i`  | Thursday 4th July 2013 11:20   
`%W %D %M %Y %T`     | Thursday 4th July 2013 11:20:05
`%l:%i %p %b %e, %Y` | 7/4/2013 11:20                 
`%M %e, %Y`          | 4-Jul-13                       
`%a, %d %b %Y %T`    | Thu, 04 Jul 2013 11:20:05      

## MySQL DATE_FORMAT示例

我们来看看示例数据库(yiibaidb)中的`orders`表，其结果如下所示 - 

```sql
mysql> desc orders;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| orderNumber    | int(11)     | NO   | PRI | NULL    |       |
| orderDate      | date        | NO   |     | NULL    |       |
| requiredDate   | date        | NO   |     | NULL    |       |
| shippedDate    | date        | YES  |     | NULL    |       |
| status         | varchar(15) | NO   |     | NULL    |       |
| comments       | text        | YES  |     | NULL    |       |
| customerNumber | int(11)     | NO   | MUL | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
7 rows in set
```

要选择订单的数据并格式化日期值，请使用以下语句：

```sql
SELECT 
    orderNumber,
    DATE_FORMAT(orderdate, '%Y-%m-%d') orderDate,
    DATE_FORMAT(requireddate, '%a %D %b %Y') requireddate,
    DATE_FORMAT(shippedDate, '%W %D %M %Y') shippedDate
FROM
    orders;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+------------+-------------------+------------------------------+
| orderNumber | orderDate  | requireddate      | shippedDate                  |
+-------------+------------+-------------------+------------------------------+
|       10100 | 2013-01-06 | Sun 13th Jan 2013 | Thursday 10th January 2013   |
|       10101 | 2013-01-09 | Fri 18th Jan 2013 | Friday 11th January 2013     |
|       10102 | 2013-01-10 | Fri 18th Jan 2013 | Monday 14th January 2013     |
|       10103 | 2013-01-29 | Thu 7th Feb 2013  | Saturday 2nd February 2013   
************* 此处省略了一大波数据 *********************************
|       10417 | 2015-05-13 | Tue 19th May 2015 | Tuesday 19th May 2015        |
|       10418 | 2015-05-16 | Sun 24th May 2015 | Wednesday 20th May 2015      |
|       10419 | 2015-05-17 | Thu 28th May 2015 | Tuesday 19th May 2015        
|       10425 | 2015-05-31 | Sun 7th Jun 2015  | NULL                         |
|       10426 | 2017-07-21 | Wed 26th Jul 2017 | Sunday 23rd July 2017        |
+-------------+------------+-------------------+------------------------------+
327 rows in set
```

要根据格式字符串指定的不同日期格式来格式化订单日期，所需日期和每个订单的发货日期。

**MySQL DATE_FORMAT与ORDER BY**

请参阅以下示例：

```sql
SELECT 
    orderNumber,
    DATE_FORMAT(shippeddate, '%W %D %M %Y') shippeddate
FROM
    orders
WHERE
    shippeddate IS NOT NULL
ORDER BY shippeddate;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+------------------------------+
| orderNumber | shippeddate                  |
+-------------+------------------------------+
|       10101 | Friday 11th January 2013     |
|       10156 | Friday 11th October 2013     |
|       10356 | Friday 12th December 2014    |
|       10376 | Friday 13th February 2015    |
|       10129 | Friday 14th June 2013        |
|       10279 | Friday 15th August 2014      |
|       10181 | Friday 15th November 2013    |
********* 此处省略了一大波数据 **************** 
|       10348 | Wednesday 5th November 2014  |
|       10411 | Wednesday 6th May 2015       |
|       10267 | Wednesday 9th July 2014      |
|       10300 | Wednesday 9th October 2013   |
+-------------+------------------------------+
313 rows in set
```

在查询中，我们选择了发货日期不为`NULL`的所有订单，并按发货日期对订单进行排序。但是，订单未正确排序。

原因是将`shippingdate`用作`DATE_FORMAT`函数的输出的[别名](http://www.yiibai.com/mysql/alias.html "别名")，它是一个字符串，[ORDER BY](http://www.yiibai.com/mysql/order-by.html "ORDER BY")子句根据字符串值，而不是日期值对别名进行排序。

要解决这个问题，我们必须使用不同于列名的别名; 见下列声明：

```
SELECT 
    orderNumber,
    DATE_FORMAT(shippeddate, '%W %D %M %Y') 'Shipped date'
FROM
    orders
WHERE
    shippeddate IS NOT NULL
ORDER BY shippeddate;
```

SQL

执行上面查询语句，得到以下结果 - 

```
+-------------+------------------------------+
| orderNumber | Shipped date                 |
+-------------+------------------------------+
|       10100 | Thursday 10th January 2013   |
|       10101 | Friday 11th January 2013     |
|       10102 | Monday 14th January 2013     |
|       10104 | Friday 1st February 2013     |
|       10103 | Saturday 2nd February 2013   |
|       10105 | Tuesday 12th February 2013   |
********* 此处省略了一大波数据 **************** 
|       10413 | Saturday 9th May 2015        |
|       10415 | Tuesday 12th May 2015        |
|       10416 | Thursday 14th May 2015       |
|       10417 | Tuesday 19th May 2015        |
|       10419 | Tuesday 19th May 2015        |
|       10418 | Wednesday 20th May 2015      |
|       10426 | Sunday 23rd July 2017        |
+-------------+------------------------------+
313 rows in set
```

SQL

在本教程中，我们向您展示了如何使用MySQL `DATE_FORMAT`函数根据指定的格式格式化日期。