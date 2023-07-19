在本教程中，您将学习如何使用MySQL `DATE_SUB()`函数从日期中减去时间值。

## MySQL DATE_SUB函数简介

`DATE_SUB()`函数从DATE或DATETIME值中减去时间值(或间隔)。 下面说明了`DATE_SUB()`函数的语法：

```sql
DATE_SUB(start_date,INTERVAL expr unit);
```

`DATE_SUB()`函数接受两个参数：

* `start_date`是`DATE`或`DATETIME`的起始值。
* `expr`是一个字符串，用于确定从起始日期减去的间隔值。`unit`是`expr`可解析的间隔单位，例如`DAY`，`HOUR`等

以下语句使用`DATE_SUB()`函数从`2017年7月4日`减去`1`天：

```sql
mysql> SELECT DATE_SUB('2017-09-04',INTERVAL 1 DAY) result;
+------------+
| result     |
+------------+
| 2017-09-03 |
+------------+
1 row in set
-- 求昨天的日期值： 将今天的日期值减去 1 天
mysql> SELECT DATE_SUB(curdate(),INTERVAL 1 DAY) result;
+------------+
| result     |
+------------+
| 2017-08-09 |
+------------+
1 row in set
```

在这个例子中，开始日期是`2017-09-04`，它是`yyyy-mm-dd`格式。 `INTERVAL 1 DAY`被解析为`1`天的时间间隔。`DATE_SUB()`函数的结果是`2017-09-03`的字符串值。

类似于DATE_ADD()函数，`DATE_SUB()`函数的返回值的数据类型可以是：

* 如果第一个参数是`DATETIME`，则返回值应为`DATETIME`，或者该间隔具有时间元素，如小时，分钟，秒等。
* 否则返回一个字符串。

请参阅以下示例：

**示例-1**

```sql
mysql> SELECT DATE_SUB('2017-09-04',INTERVAL 3 HOUR) result;
+---------------------+
| result              |
+---------------------+
| 2017-09-03 21:00:00 |
+---------------------+
1 row in set
```

因为间隔为`3`小时，`DATE_SUB`函数的结果为`DATETIME`值。

**示例-2 MySQL DATE_SUB：负间隔值**

`expr`在间隔值可以为正或负数值。 如果`expr`为负数，则`DATE_SUB()`函数的行为与`DATE_ADD()`函数类似，如下例所示：

```sql
mysql> SELECT DATE_SUB('2017-07-03',INTERVAL -1 DAY) result;
+------------+
| result     |
+------------+
| 2017-07-04 |
+------------+
1 row in set
```

**示例-3 MySQL DATE_SUB：无效或格式错误的日期**  
如果`DATE_SUB()`函数的第一个参数格式错误，日期无效或`NULL`，则`DATE_SUB()`函数返回`NULL`。

```sql
mysql> SELECT DATE_SUB('2017-02-29', INTERVAL - 1 DAY) result;
+--------+
| result |
+--------+
| NULL   |
+--------+
1 row in set
```

在这个例子中，`2017-02-29`是一个无效的日期，因此结果为`NULL`。 此外，MySQL发出警告，可通过以下查询查看语句。

```sql
mysql> SHOW WARNINGS;
+---------+------+----------------------------------------+
| Level   | Code | Message                                |
+---------+------+----------------------------------------+
| Warning | 1292 | Incorrect datetime value: '2017-02-29' |
+---------+------+----------------------------------------+
1 row in set
```

以下示例演示了将异常日期或`NULL`传递给`DATE_SUB`函数，效果如下所示：

```sql
mysql> SELECT DATE_SUB('03/07/2017', INTERVAL 1 DAY) result;
+--------+
| result |
+--------+
| NULL   |
+--------+
1 row in set

mysql> SELECT DATE_SUB(NULL, INTERVAL 1 DAY) result;
+--------+
| result |
+--------+
| NULL   |
+--------+
1 row in set
```

**示例-3 MySQL DATE_SUB：自动调整日**

如果从最大日期的日期减去`MONTH`，`YEAR`或`YEAR_MONTH`的间隔，则该日期将被调整为新月份的最大日期。

下面来看看以下语句：

```sql
mysql> SELECT DATE_SUB('2017-03-30', INTERVAL 1 MONTH) result;
+------------+
| result     |
+------------+
| 2017-02-28 |
+------------+
1 row in set
```

在这个例子中，我们从2017年3月30日起减去1个月，结果是2017年2月28日。这一天被调整到28日而不是30日，因为2017年2月份只有28天。

在本教程中，您已经学习了如何使用MySQL `DATE_SUB()`函数从`DATE`或`DATETIME`值中减去时间间隔。