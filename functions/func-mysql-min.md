在本教程中，您将学习如何使用 MySQL `MIN()` 函数来查询一组值中的最小值。

## MySQL MIN 函数

`MIN()` 函数返回一组值中的最小值。`MIN()` 函数在某些情况下非常有用，例如找到最小的数字，选择最便宜的产品，获得最低的信用额度等。

以下说明 `MIN()` 函数的语法：

```sql
MIN(DISTINCT expression);
```

如果指定 `DISTINCT` 运算符，则 `MIN` 函数返回不同值的最小值，与省略 `DISTINCT` 相同。换句话说，`DISTINCT` 运算符对 `MIN` 函数没有任何影响，它只是为了 `ISO` 兼容性。

请注意，`DISTINCT` 运算符在其他聚合函数 (如 SUM，AVG 和 COUNT) 中生效。

## MySQL MIN 函数示例

我们来看看示例数据库 (yiibaidb) 中的 `products` 表，其结构如下表所示 - 

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

要查询获得 `products` 表中最便宜的产品，请使用以下查询：

```sql
SELECT 
    MIN(buyPrice)
FROM
    products;
```

执行上面查询语句，得到以下结果  -

```sql
mysql> SELECT 
    MIN(buyPrice)
FROM
    products;
+---------------+
| MIN(buyPrice) |
+---------------+
| 15.91         |
+---------------+
1 row in set
```

### MySQL MIN 与子查询

要不仅选择价格，还要查询产品代码和产品名称等其他产品信息，可以在子查询中使用 `MIN` 函数，如下所示：

```sql
SELECT 
    productCode, productName, buyPrice
FROM
    products
WHERE
    buyPrice = (
        SELECT 
            MIN(buyPrice)
        FROM
            products);
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+-------------------------------------+----------+
| productCode | productName                         | buyPrice |
+-------------+-------------------------------------+----------+
| S24_2840    | 1958 Chevy Corvette Limited Edition | 15.91    |
+-------------+-------------------------------------+----------+
1 row in set
```

上面语句怎么运行？

* 子查询返回 `products` 表中最低的价格产品。
* 外部查询查询价格等于从子查询返回的最低价格的商品。

### MySQL MIN 与 GROUP BY

当您将 `MIN` 函数与 SELECT 语句中的 GROUP BY 子句相结合使用时，可以获取每个组的最小值。

例如，要查询每个产品线的最低价格产品，请使用以下语句：

```sql
SELECT 
    productline, MIN(buyprice)
FROM
    products
GROUP BY productline;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT 
    productline, MIN(buyprice)
FROM
    products
GROUP BY productline;
+------------------+---------------+
| productline      | MIN(buyprice) |
+------------------+---------------+
| Classic Cars     | 15.91         |
| Motorcycles      | 24.14         |
| Planes           | 29.34         |
| Ships            | 33.3          |
| Trains           | 26.72         |
| Trucks and Buses | 24.92         |
| Vintage Cars     | 20.61         |
+------------------+---------------+
7 rows in set
```

如果您不仅要选择产品线，还要查询 `products` 表中的其他列，例如产品代码和产品名称，则需要使用相关的子查询。

### MySQL MIN 与相关子查询

以下查询通过将 `MIN()` 函数与相关子查询相结合来查询每个产品线中的最低价格产品：

```sql
SELECT 
    productline, productCode, productName, buyprice
FROM
    products a
WHERE
    buyprice = (
        SELECT 
            MIN(buyprice)
        FROM
            products b
        WHERE
            b.productline = a.productline);
```

执行上面查询语句，得到以下结果 - 

```sql
+------------------+-------------+-------------------------------------------+----------+
| productline      | productCode | productName                               | buyprice |
+------------------+-------------+-------------------------------------------+----------+
| Trucks and Buses | S18_2432    | 1926 Ford Fire Engine                     | 24.92    |
| Vintage Cars     | S24_2022    | 1938 Cadillac V-16 Presidential Limousine | 20.61    |
| Classic Cars     | S24_2840    | 1958 Chevy Corvette Limited Edition       | 15.91    |
| Planes           | S24_3949    | Corsair F4U (Bird Cage)                  | 29.34    |
| Motorcycles      | S32_2206    | 1982 Ducati 996 R                         | 24.14    |
| Trains           | S32_3207    | 1950s Chicago Surface Lines Streetcar    | 26.72    |
| Ships            | S72_3212    | Pont Yacht                                | 33.3     |
+------------------+-------------+-------------------------------------------+----------+
7 rows in set
```

对于来自外部查询的每个产品线，相关子查询选择产品线中的最低价格产品并返回最低价格。 然后将返回的最低价格用作外部查询的输入，以选择相关产品数据，包括产品线，产品代码，产品名称和价格。

如果要在不使用 `MIN` 函数和子查询的情况下实现相同的结果，则可以使用带有 `LEFT JOIN` 子句的自联接，如下查询语句：

```sql
SELECT 
    a.productline, a.productCode, a.productName, a.buyprice
FROM
    products a
        LEFT JOIN
    products b ON a.productline = b.productline
        AND b.buyprice < a.buyprice
WHERE
    b.productcode IS NULL;
```

执行上面查询语句，得到以下结果 - 

```sql
+------------------+-------------+-------------------------------------------+----------+
| productline      | productCode | productName                               | buyprice |
+------------------+-------------+-------------------------------------------+----------+
| Trucks and Buses | S18_2432    | 1926 Ford Fire Engine                     | 24.92    |
| Vintage Cars     | S24_2022    | 1938 Cadillac V-16 Presidential Limousine | 20.61    |
| Classic Cars     | S24_2840    | 1958 Chevy Corvette Limited Edition       | 15.91    |
| Planes           | S24_3949    | Corsair F4U (Bird Cage)                  | 29.34    |
| Motorcycles      | S32_2206    | 1982 Ducati 996 R                         | 24.14    |
| Trains           | S32_3207    | 1950's Chicago Surface Lines Streetcar    | 26.72    |
| Ships            | S72_3212    | Pont Yacht                                | 33.3     |
+------------------+-------------+-------------------------------------------+----------+
7 rows in set
```

在本教程中，您已经学习了如何使用 MySQL `MIN` 函数来查找一组值中的最小值。