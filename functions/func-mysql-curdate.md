在本教程中，您将学习如何使用 MySQL `CURDATE()` 函数获取当前日期。

## MySQL CURDATE 功能介绍

如果在数字上下文中使用字符串上下文或 `YYYMMDD` 格式，`CURDATE()` 函数将以“`YYYY-MM-DD`”格式的值返回当前日期。

以下示例显示了如何在字符串上下文中使用 `CURDATE()` 函数。

```sql
sql> SELECT CURDATE();
+------------+
| CURDATE()  |
+------------+
| 2017-08-10 |
+------------+
1 row in set (0.00 sec)
```

以下示例说明 `CURDATE()` 函数如何在数字上下文中使用：

```sql
mysql> SELECT CURDATE() + 0;
+---------------+
| CURDATE() + 0 |
+---------------+
|      20170810 |
+---------------+
1 row in set
```

`CURRENT_DATE` 和 `CURRENT_DATE()` 是 `CURDATE()` 的同义词。

```sql
mysql> SELECT CURRENT_DATE(), CURRENT_DATE, CURDATE();
+----------------+--------------+------------+
| CURRENT_DATE()| CURRENT_DATE | CURDATE()  |
+----------------+--------------+------------+
| 2017-08-10     | 2017-08-10   | 2017-08-10 |
+----------------+--------------+------------+
1 row in set
```

## CURDATE 与 NOW 函数

`CURDATE()` 函数只返回当前日期，而 NOW() 函数返回当前时间的日期和时间部分。`CURDATE()` 函数的结果等同于以下表达式：

```sql
mysql> SELECT DATE(NOW());
+-------------+
| DATE(NOW()) |
+-------------+
| 2017-08-10  |
+-------------+
1 row in set
```

在本教程中，您学习了如何使用 MySQL `CURDATE()` 函数获取当前日期值。