在本教程中，您将学习如何使用 MySQL `DATEDIFF` 函数来计算两个日期值之间的天数。

## MySQL DATEDIFF 函数介绍

MySQL `DATEDIFF` 函数计算两个 DATE，DATETIME 或 TIMESTAMP 值之间的天数。

MySQL `DATEDIFF` 函数的语法如下：

```sql
DATEDIFF(date_expression_1,date_expression_2);
```

`DATEDIFF` 函数接受两个任何有效日期或日期时间值的参数。如果您传递 `DATETIME` 或 `TIMESTAMP` 值，则 `DATEDIFF` 函数仅将日期部分用于计算，并忽略时间部分。

`DATEDIFF` 函数在许多情况下很有用，例如，您可以计算产品需要发送给客户的间隔时间。

## MySQL DATEDIFF 示例

我们来看一下使用 `DATEDIFF` 函数的一些例子。

** 示例 -1**

```sql
mysql> SELECT DATEDIFF('2017-08-17','2017-08-17'); 
+-------------------------------------+
| DATEDIFF('2017-08-17','2017-08-17') |
+-------------------------------------+
|                                   0 |
+-------------------------------------+
1 row in set
```

** 示例 -2**

```sql
mysql> SELECT DATEDIFF('2017-08-17','2017-08-08');
+-------------------------------------+
| DATEDIFF('2017-08-17','2017-08-08') |
+-------------------------------------+
|                                   9 |
+-------------------------------------+
1 row in set
```

SQL

** 示例 -3**

```sql
mysql> SELECT DATEDIFF('2017-08-08','2017-08-17');
+-------------------------------------+
| DATEDIFF('2017-08-08','2017-08-17') |
+-------------------------------------+
|                                  -9 |
+-------------------------------------+
1 row in set
```

请参阅示例数据库 (yiibaidb) 中的以下 `orders` 表，其结构如下 - 

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

假设使用 `DATEDIFF` 函数计算所需日期和订单发货日期之间的天数，如下所示：

```sql
SELECT 
    orderNumber, 
    DATEDIFF(requiredDate, shippedDate) daysLeft
FROM
    orders
ORDER BY daysLeft DESC;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+----------+
| orderNumber | daysLeft |
+-------------+----------+
|       10409 |       11 |
|       10410 |       10 |
|       10105 |        9 |
|       10135 |        9 |
|       10190 |        9 |
**** 此处省略了一大小波数据 ********
|       10423 | NULL     |
|       10424 | NULL     |
|       10425 | NULL     |
+-------------+----------+
327 rows in set
```

以下语句将获取状态正在处理 (`In Process`) 的所有订单，并计算订单日期和所需日期之间的天数：

```sql
SELECT 
    orderNumber,
    DATEDIFF(requiredDate, orderDate) remaining_days
FROM
    orders
WHERE
    status = 'In Process'
ORDER BY remaining_days;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+----------------+
| orderNumber | remaining_days |
+-------------+----------------+
|       10426 |              5 |
|       10423 |              6 |
|       10425 |              7 |
|       10421 |              8 |
|       10424 |              8 |
|       10420 |              9 |
|       10422 |             12 |
+-------------+----------------+
7 rows in set
```

要计算周或月作为间隔时间，可以将 `DATEDIFF` 函数的返回值除以 `7` 或 `30`，如下查询语句：

```sql
SELECT 
    orderNumber,
    ROUND(DATEDIFF(requiredDate, orderDate) / 7, 2) as weeks,
    ROUND(DATEDIFF(requiredDate, orderDate) / 30,2) as months
FROM
    orders
WHERE
    status = 'In Process';
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+-------+--------+
| orderNumber | weeks | months |
+-------------+-------+--------+
|       10420 | 1.29  | 0.3    |
|       10421 | 1.14  | 0.27   |
|       10422 | 1.71  | 0.4    |
|       10423 | 0.86  | 0.2    |
|       10424 | 1.14  | 0.27   |
|       10425 | 1     | 0.23   |
|       10426 | 0.71  | 0.17   |
+-------------+-------+--------+
7 rows in set
```

请注意，`ROUND` 函数用于舍入结果。

在本教程中，您已经学习了如何使用 MySQL `DATEDIFF` 函数来计算两个日期值之间的天数。