在本教程中，您将学习如何使用 MySQL AVG()函数来计算一组值或表达式的平均值。

## MySQL AVG()函数简介

MySQL AVG()函数是一个聚合函数，它用于计算一组值或表达式的平均值。

AVG()函数的语法如下：

```sql
AVG(DISTINCT expression)
```

您可以使用 AVG()函数中的 DISTINCT 运算符来计算不同值的平均值。 例如，如果您有一组值 `1`,`1`,`2`,`3`，具有 `DISTINCT` 操作的 AVG()函数将返回不同值的和，即：`(1 + 2 + 3)/3 = 2.00` 。

## MySQL AVG 示例

我们将在示例数据库 (yiibaidb) 中使用 `products` 表进行演示，下图是 `products` 表的结构 - 

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


要计算 `products` 表中所有产品的平均价格，可以使用 AVG 函数，如下查询：

```sql
SELECT AVG(buyprice) 'Avarage Price' FROM products;
```

SQL

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(buyprice) 'Avarage Price' FROM products;
+---------------+
| Avarage Price |
+---------------+
| 54.395182     |
+---------------+
1 row in set
```

请注意，`FORMAT` 函数用于格式化 `AVG` 函数返回的平均值。

您可以向 [SELECT](http://www.yiibai.com/mysql/select-statement-query-data.html "SELECT") 语句添加一个 [WHERE](http://www.yiibai.com/mysql/where.html "WHERE") 子句来计算子集值的平均值。 例如，要计算产品线为 `Classic Cars` 的产品的平均价格，您可以使用以下查询：

```sql
SELECT AVG(buyprice) 'Avarage Classic Cars Price'
FROM products
WHERE productline = 'Classic Cars';
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(buyprice) 'Avarage Classic Cars Price'
FROM products
WHERE productline = 'Classic Cars';
+----------------------------+
| Avarage Classic Cars Price |
+----------------------------+
| 64.446316                  |
+----------------------------+
1 row in set
```

### 具有 DISTINCT 的 MySQL AVG()函数

有些产品价格相同，可以使用以下查询来检查它：

```sql
SELECT COUNT(buyprice) - COUNT(DISTINCT buyprice) FROM products;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT COUNT(buyprice) - COUNT(DISTINCT buyprice) FROM products;
+--------------------------------------------+
| COUNT(buyprice) - COUNT(DISTINCT buyprice) |
+--------------------------------------------+
|                                          2 |
+--------------------------------------------+
1 row in set
```

可以使用 AVG()函数通过添加 `DISTINCT` 运算符来计算不同价格的平均值，如下所示：

```sql
SELECT AVG(DISTINCT buyprice) FROM products;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(DISTINCT buyprice) FROM products;
+------------------------+
| AVG(DISTINCT buyprice) |
+------------------------+
| 54.372870              |
+------------------------+
1 row in set
```

结果与使用 `DISTINCT` 操作符的平均价格略有不同。

### 具有 GROUP BY 子句的 MySQL AVG

我们经常使用 AVG 函数与 GROUP BY 子句一起计算表中每组行的平均值。

例如，要计算每个产品线的产品的平均价格，您将使用带有 `GROUP BY` 子句的 AVG 函数，如下查询语句：

```sql
SELECT productline,
       AVG(buyprice) 'Avarage Price'
FROM products
GROUP BY productline;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT productline,
       AVG(buyprice) 'Avarage Price'
FROM products
GROUP BY productline;
+------------------+---------------+
| productline      | Avarage Price |
+------------------+---------------+
| Classic Cars     | 64.446316     |
| Motorcycles      | 50.685385     |
| Planes           | 49.629167     |
| Ships            | 47.007778     |
| Trains           | 43.923333     |
| Trucks and Buses | 56.329091     |
| Vintage Cars     | 46.066250     |
+------------------+---------------+
7 rows in set
```

### 具有 HAVING 子句的 MySQL AVG

您可以使用 AVG 函数中的 HAVING 子句中为分组的平均值设置条件。 例如，如果要仅选择产品平均价格大于 `50` 的产品线，则可以使用以下查询：

```sql
SELECT productline, AVG(buyprice) 'Avarage Price' FROM products GROUP BY productline HAVING AVG(buyprice) > 50;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT productline, AVG(buyprice) 'Avarage Price' FROM products GROUP BY productline HAVING AVG(buyprice) > 50;
+------------------+---------------+
| productline      | Avarage Price |
+------------------+---------------+
| Classic Cars     | 64.446316     |
| Motorcycles      | 50.685385     |
| Trucks and Buses | 56.329091     |
+------------------+---------------+
3 rows in set
```

### MySQL AVG()函数与子查询

您可以在 SQL 语句中多次使用 AVG()函数来计算一组平均值的平均值。 例如，可以计算产品线平均购买价格的平均买价如下：

```sql
SELECT AVG(pl_avg) 'Average Product'
FROM (SELECT AVG(buyprice) pl_avg
    FROM products
    GROUP BY productline
) avgs;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(pl_avg) 'Average Product'
FROM (SELECT AVG(buyprice) pl_avg
    FROM products
    GROUP BY productline
) avgs;
+-----------------+
| Average Product |
+-----------------+
| 51.1553314286   |
+-----------------+
1 row in set
```

怎么运行的 - 

* 子查询根据产品线计算平均购买价格。
* 外部查询计算从子查询返回的产品线的平均购买价格的平均购买价格。

### 具有 NULL 值的 MySQL AVG 函数

AVG()函数忽略计算中的 `NULL` 值，请参阅以下示例：

_ 首先 _，创建一个名为 `t` 的新表，其中有两列 `id` 和 `val`，`val` 列可以包含 `NULL` 值。

```sql
CREATE TABLE IF NOT EXISTS t(
    id  int auto_increment primary key,
    val int
);
```


_ 其次 _，在 `t` 表中插入一些行，包括 `NULL` 值。

```sql
INSERT INTO t(val)
VALUES(1),(2),(nulL),(3);
```


_ 第三 _，使用 `AVG()` 函数计算 `val` 列中值的平均值：

```sql
SELECT AVG(val) FROM t;
```


执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(val) FROM t;
+----------+
| AVG(val) |
+----------+
| 2.0000   |
+----------+
1 row in set
```

该语句按预期返回 `2`，因为在 AVG 函数的计算中不包括 `NULL` 值。

## 具有控制流函数的 MySQL AVG

要计算列的平均值，并在单个语句中有条件地计算相同列的平均值，可以使用具有控制流函数的 AVG 函数。

例如，要计算 `Classic Cars` 产品线的平均价格与所有产品的平均价格的比例，请使用以下声明：

```sql
SELECT AVG(IF(productline='Classic Cars',buyprice,NULL)) / AVG(buyprice) 'Classic Cars/ Products'
FROM products;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT AVG(IF(productline='Classic Cars',buyprice,NULL)) / AVG(buyprice) 'Classic Cars/ Products'
FROM products;
+------------------------+
| Classic Cars/ Products |
+------------------------+
| 1.1847798580           |
+------------------------+
1 row in set
```

如果产品线是 `Classic Cars`，则 `IF(productline='Classic Cars',buyprice,NULL)` 表达式返回价格，否则返回 `NULL`。

因为 AVG 函数忽略了计算中的 `NULL` 值，所以 `AVG(IF(productline ='Classic Cars'，buyprice，NULL))` 表达式只计算产品线是 `Classic Cars` 的产品的平均价格。

在本教程中，我们向您展示了一些有用的技术，通过使用 MySQL AVG 函数来计算一组值的平均值。