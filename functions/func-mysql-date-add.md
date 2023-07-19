在本教程中，您将学习如何使用 MySQL `DATE_ADD` 函数将时间值添加到 `DATE` 或 `DATETIME` 值。

## MySQL DATE_ADD 函数简介

`DATE_ADD` 函数将间隔时间添加到 DATE 或 DATETIME 值。 下面说明了 `DATE_ADD` 函数的语法：

```sql
DATE_ADD(start_date, INTERVAL expr unit);
```

`DATE_ADD` 函数有两个参数：

* `start_date` 是 `DATE` 或 `DATETIME` 的起始值。
* `INTERVAL expr unit` 是要添加到起始日期值的间隔值。

根据参数，`DATE_ADD` 函数可能会返回一个 `DATETIME` 值或一个字符串：

* `DATETIME` - 如果第一个参数是 `DATETIME` 值，或者如果间隔值具有时间元素，如小时，分钟或秒等。
* 否则返回字符串。

## MySQL DATE_ADD 函数示例

我们来看几个例子来了解 `DATE_ADD` 函数的工作原理。

** 示例 -1** 加 `1` 秒到时间：`2017-12-31 23:59:59`：

```sql
mysql> SELECT DATE_ADD('2017-12-31 23:59:59', INTERVAL 1 SECOND) result;
+---------------------+
| result              |
+---------------------+
| 2018-01-01 00:00:00 |
+---------------------+
1 row in set
```

** 示例 -2** - 添加 `1` 天到时间：`2017-12-31 00:00:01`：

```sql
mysql> SELECT DATE_ADD('2017-12-31 00:00:01',INTERVAL 1 DAY) result;
+---------------------+
| result              |
+---------------------+
| 2018-01-01 00:00:01 |
+---------------------+
1 row in set
```

** 示例 -3** - 在时间 `2017-12-31 23:59:59` 上加 `1` 分 `1` 秒。

```sql
mysql> SELECT DATE_ADD('2017-12-31 23:59:59', INTERVAL '1:1' MINUTE_SECOND) result;
+---------------------+
| result              |
+---------------------+
| 2018-01-01 00:01:00 |
+---------------------+
1 row in set
```

** 示例 -4** - 在时间 `2000-01-01 00:00:00` 上加 `-1` 天 `5` 小时。

```sql
mysql> SELECT DATE_ADD('2000-01-01 00:00:00', INTERVAL '-1 5' DAY_HOUR) result;
+---------------------+
| result              |
+---------------------+
| 1999-12-30 19:00:00 |
+---------------------+
1 row in set
```

** 示例 -5** - 添加 `1` 秒和 `999999` 微秒到时间：`2017-12-31 23：59：59.000002`：

```sql
mysql> SELECT DATE_ADD('2017-12-31 23:59:59.000002',INTERVAL '1.999999' SECOND_MICROSECOND) result;
+----------------------------+
| result                     |
+----------------------------+
| 2018-01-01 00:00:01.000001 |
+----------------------------+
1 row in set
```

## MySQL DATE_ADD 函数使用说明

** 间隔处理 **

在间隔期间 - 

```sql
INTERVAL expr unit
```

`expr` 被视为一个字符串，因此，当 ` 为 expr` 使用非字符串值时，您应该小心。 例如，间隔为 `HOUR_MINUTE`，`5/2` 求值结果为 `2.5000`(不是 `2.5`)，并被视为 `2` 小时 `5000` 分钟，如下面的语句所示：

```sql
mysql> SELECT DATE_ADD('2017-01-01', INTERVAL 5 / 2 HOUR_MINUTE) result;
+---------------------+
| result              |
+---------------------+
| 2017-01-04 13:20:00 |
+---------------------+
1 row in set
```

为了确保非串间隔值的正确解释，您应该使用 `CAST` 函数，如下所示：

```sql
mysql> SELECT DATE_ADD('2017-01-01', INTERVAL CAST(6/4 AS DECIMAL(3,1)) HOUR_MINUTE) result;
+---------------------+
| result              |
+---------------------+
| 2017-01-01 01:05:00 |
+---------------------+
1 row in set
```

** 自动 DATETIME 转换 **

如果您将时间值添加到日期值，则结果为 DATETIME 值，如以下示例所示：

```sql
mysql> SELECT DATE_ADD('2017-01-01', INTERVAL 12 HOUR) result;
+---------------------+
| result              |
+---------------------+
| 2017-01-01 12:00:00 |
+---------------------+
1 row in set
```

** 起始日期无效 **

如果对第一个参数使用无效的日期，`DATE_ADD` 函数将返回 `NULL`，例如：

```sql
mysql> SELECT DATE_ADD('2017-02-30', INTERVAL 1 DAY) result;
+--------+
| result |
+--------+
| NULL   |
+--------+
1 row in set
```

如果要详细看到警告，请使用 `SHOW WARNINGS` 语句：

```sql
mysql> SHOW WARNINGS;
+---------+------+----------------------------------------+
| Level   | Code | Message                                |
+---------+------+----------------------------------------+
| Warning | 1292 | Incorrect datetime value: '2017-02-30' |
+---------+------+----------------------------------------+
1 row in set
```

** 调整日，月或年 **

如果您将 `MONTH`，`YEAR` 或 `YEAR_MONTH` 的间隔添加到导致日期大于新月份的最大日期的日期，则该日期将被调整为新月份的最大日期。

请看看以下示例：

```sql
mysql> SELECT DATE_ADD('2017-01-30', INTERVAL 1 MONTH) result;
+------------+
| result     |
+------------+
| 2017-02-28 |
+------------+
1 row in set
```

在这个例子中，我们在 2017 年 1 月 30 日相加上了 1 个月，结果是 2017 年 2 月 28 日。这一天被调整到 2017 年 2 月的最大天数。

如果是 `2` 月份有 `29` 天，日期也将调整为第 `29` 天，如下所示：

```sql
mysql> SELECT DATE_ADD('2012-01-30', INTERVAL 1 MONTH) result;
+------------+
| result     |
+------------+
| 2012-02-29 |
+------------+
1 row in set
```

在本教程中，您已经学习了如何使用 MySQL `DATE_ADD` 函数将间隔添加到 `DATE` 或 `DATETIME` 值。