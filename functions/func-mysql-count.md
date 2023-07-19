在本教程中，您将学习如何使用 MySQL `COUNT()` 函数来计算表中的行数。

## MySQL COUNT()函数介绍

`COUNT()` 函数返回表中的行数。 `COUNT()` 函数允许您对表中符合特定条件的所有行进行计数。

`COUNT()` 函数的语法如下 - 

```sql
COUNT(expression)
```

`COUNT()` 函数的返回类型为 `BIGINT`。 如果没有找到匹配的行，则 `COUNT()` 函数返回 `0`。

`COUNT` 函数有几种形式：`COUNT(*)`，`COUNT(expression)` 和 `COUNT(DISTINCT expression)`。

**MySQL COUNT(*)函数 **

`COUNT(*)` 函数返回由 SELECT 语句返回的结果集中的行数。`COUNT(*)` 函数计算包含 `NULL` 和非 `NULL` 值的行，即：所有行。

如果使用 `COUNT(*)` 函数对表中的数字行进行计数，而不使用 WHERE 子句选择其他列，则其执行速度非常快。

这种优化仅适用于 _MyISAM_ 表，因为 _MyISAM_ 表的行数存储在 `information_schema` 数据库的 `tables` 表的 `table_rows` 列中; 因此，MySQL 可以很快地检索它。

**MySQL COUNT(expression)**

`COUNT(expression)` 返回不包含 `NULL` 值的行数。

**MySQL COUNT(DISTINCT expression)**

`MySQL COUNT(DISTINCT expression)` 返回不包含 `NULL` 值的唯一行数。

## MySQL COUNT 示例

我们来创建一个名为 `demo` 的新表，并插入一些示例数据。

```sql
USE testdb;
-- create a demos table
CREATE TABLE IF NOT EXISTS demos(
 id int auto_increment primary key,
 val int 
);
-- insert some sample data
INSERT INTO demos(val)
VALUES(1),(1),(2),(2),(NULL),(3),(4),(NULL),(5);
-- select data from demos table
SELECT * FROM demos;
```

执行上面查询语句，得到以下结果 - 

```
+----+------+
| id | val  |
+----+------+
|  1 |    1 |
|  2 |    1 |
|  3 |    2 |
|  4 |    2 |
|  5 | NULL |
|  6 |    3 |
|  7 |    4 |
|  8 | NULL |
|  9 |    5 |
+----+------+
9 rows in set
```

要计算 `demos` 表中的所有行，请使用 `COUNT(*)` 函数，如下所示：

```sql
mysql> SELECT COUNT(*) FROM demos;
+----------+
| COUNT(*) |
+----------+
|        9 |
+----------+
1 row in set
```

您可以添加一个 `WHERE` 子句来指定一个条件来计数，例如，只计算 `val` 列包含值等于 `2` 的行，使用以下查询：

```sql
mysql> SELECT COUNT(*) FROM demos WHERE val = 2;
+----------+
| COUNT(*) |
+----------+
|        2 |
+----------+
1 row in set
```

如果在 `COUNT` 函数中指定 `val` 列，则 `COUNT` 函数计数其 `val` 列仅包含非 `NULL` 值的所有行。 请参阅以下查询：

```sql
SELECT COUNT(*) FROM demos WHERE val = 2;
```

`val` 列中的两个 `NULL` 值将被忽略。

要计算 `demos` 表中的唯一行，可以将 `DISTINCT` 运算符添加到 `COUNT` 函数中，如下查询语句：

```sql
SELECT COUNT(DISTINCT val) FROM demos;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT COUNT(DISTINCT val) FROM demos;
+---------------------+
| COUNT(DISTINCT val) |
+---------------------+
|                   5 |
+---------------------+
1 row in set
```

在计数中忽略两个重复值 `1`,`2` 和两个 `NULL` 值。

### 具有 GROUP BY 的 MySQL COUNT

我们经常将 `COUNT` 函数与 GROUP BY 子句结合使用来统计不同分组中的数据。请参见以下 `products` 表的结构 - 

```sql
mysql> desc products;
+--------------------+---------------+------+-----+---------+------------------+
| Field              | Type          | Null | Key | Default | Extra            |
+--------------------+---------------+------+-----+---------+------------------+
| productCode        | varchar(15)   | NO   | PRI |         |                  |
| productName        | varchar(70)   | NO   | MUL | NULL    |                  |
| productLine        | varchar(50)   | NO   | MUL | NULL    |                  |
| productScale       | varchar(10)   | NO   |     | NULL    |                  |
| productVendor      | varchar(50)   | NO   |     | NULL    |                  |
| productDescription | text          | NO   |     | NULL    |                  |
| quantityInStock    | smallint(6)   | NO   |     | NULL    |                  |
| buyPrice           | decimal(10,2) | NO   |     | NULL    |                  |
| MSRP               | decimal(10,2) | NO   |     | NULL    |                  |
| stockValue         | double        | YES  |     | NULL    | STORED GENERATED |
+--------------------+---------------+------+-----+---------+------------------+
10 rows in set
```

例如，要查找每个产品系列中的产品数量，可以使用 `COUNT` 函数与 `GROUP BY` 子句，如下查询所示：

```sql
SELECT productline, count(*) FROM products GROUP BY productline;
```

执行上面代码，得到以下结果 - 

```sql
mysql> SELECT productline, count(*) FROM products GROUP BY productline;
+------------------+----------+
| productline      | count(*) |
+------------------+----------+
| Classic Cars     |       38 |
| Motorcycles      |       13 |
| Planes           |       12 |
| Ships            |        9 |
| Trains           |        3 |
| Trucks and Buses |       11 |
| Vintage Cars     |       24 |
+------------------+----------+
7 rows in set
```

要查找供应商提供的产品数量，请使用以下查询：

```sql
SELECT productvendor, count(*) FROM products GROUP BY productvendor;
```

执行上面代码，得到以下结果 - 

```sql
mysql> SELECT productvendor, count(*) FROM products GROUP BY productvendor;
+---------------------------+----------+
| productvendor             | count(*) |
+---------------------------+----------+
| Autoart Studio Design     |        8 |
| Carousel DieCast Legends  |        9 |
| Classic Metal Creations   |       10 |
| Exoto Designs             |        9 |
| Gearbox Collectibles      |        9 |
| Highway 66 Mini Classics  |        9 |
| Min Lin Diecast           |        8 |
| Motor City Art Classics   |        9 |
| Red Start Diecast         |        7 |
| Second Gear Diecast       |        8 |
| Studio M Art Models       |        8 |
| Unimax Art Galleries      |        8 |
| Welly Diecast Productions |        8 |
+---------------------------+----------+
13 rows in set
```

要查找哪个供应商提供至少 `9` 个产品，您可以使用 `HAVING` 子句在 `COUNT` 函数中，如以下查询语句所示：

```sql
SELECT productvendor, count(*) FROM products GROUP BY productvendor
HAVING count(*) >= 9;
```

执行上面代码，得到以下结果 - 

```sql
mysql> SELECT productvendor, count(*) FROM products GROUP BY productvendor
HAVING count(*) >= 9;
+--------------------------+----------+
| productvendor            | count(*) |
+--------------------------+----------+
| Carousel DieCast Legends |        9 |
| Classic Metal Creations  |       10 |
| Exoto Designs            |        9 |
| Gearbox Collectibles     |        9 |
| Highway 66 Mini Classics |        9 |
| Motor City Art Classics  |        9 |
+--------------------------+----------+
6 rows in set
```

### MySQL COUNT IF

可以使用 `COUNT` 函数中的控制流程功能，例如 IF，IFNULL，`CASE` 等来计数其值与条件匹配的行。

例如，以下查询可以查找有多少被取消，暂停和有争议的订单：

```sql
SELECT COUNT(IF(status='Cancelled',1, NULL)) 'Cancelled',
       COUNT(IF(status='On Hold',1, NULL)) 'On Hold',
       COUNT(IF(status='Disputed',1, NULL)) 'Disputed'
FROM orders;
```

执行上面代码，得到以下结果 - 

```sql
mysql> SELECT COUNT(IF(status='Cancelled',1, NULL)) 'Cancelled',
       COUNT(IF(status='On Hold',1, NULL)) 'On Hold',
       COUNT(IF(status='Disputed',1, NULL)) 'Disputed'
FROM orders;
+-----------+---------+----------+
| Cancelled | On Hold | Disputed |
+-----------+---------+----------+
|         6 |       4 |        3 |
+-----------+---------+----------+
1 row in set
```

如果订单的状态被取消，保留或有争议，IF 函数将返回 `1`，否则返回 `NULL`。 `COUNT` 函数只计数 `1`，而不是 `NULL` 值，因此查询根据相应的状态返回订单数。

在本教程中，您已经学习了使用 MySQL `COUNT` 函数计算表中行数的各种技术。