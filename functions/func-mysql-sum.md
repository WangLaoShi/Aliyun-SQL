在本教程中，您将学习如何使用 MySQL `SUM` 函数来计算一组值或表达式的总和。

## MySQL SUM()函数介绍

`SUM()` 函数用于计算一组值或表达式的总和，`SUM()` 函数的语法如下：

```sql
SUM(DISTINCT expression)
```

`SUM()` 函数是如何工作的？

* 如果在没有返回匹配行 SELECT 语句中使用 `SUM` 函数，则 `SUM` 函数返回 `NULL`，而不是 `0`。
* `DISTINCT` 运算符允许计算集合中的不同值。
* `SUM` 函数忽略计算中的 `NULL` 值。

## MySQL SUM()函数示例

我们来看看示例数据库 (yiibaidb) 中的 `orderdetails` 表。

可以使用 `SUM()` 函数来计算订单编号 `10100` 的总金额，如下查询所示：

```sql
SELECT FORMAT(SUM(quantityOrdered * priceEach),2) total FROM orderdetails WHERE orderNumber = 10100;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT FORMAT(SUM(quantityOrdered * priceEach),2) total FROM orderdetails WHERE orderNumber = 10100;
+-----------+
| total     |
+-----------+
| 10,223.83 |
+-----------+
1 row in set
```

请注意，`FORMAT()` 函数用于格式化 `SUM()` 函数的返回值。

### MySQL SUM 与 GROUP BY 子句

当与 `GROUP BY` 子句组合时，`SUM()` 函数计算 GROUP BY 子句中指定的每个分组的总和。

例如，可以使用具有 `GROUP BY` 子句的 `SUM` 函数计算每个订单的总金额，如下所示：

```sql
SELECT orderNumber,
       FORMAT(SUM(quantityOrdered * priceEach),2) total
FROM orderdetails
GROUP BY orderNumber
ORDER BY SUM(quantityOrdered * priceEach) DESC;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------+-----------+
| orderNumber | total     |
+-------------+-----------+
|       10165 | 67,392.85 |
|       10287 | 61,402.00 |
|       10310 | 61,234.67 |
|       10212 | 59,830.55 |
*** 此处省略了一大波数据 *****
|       10116 | 1,627.56  |
|       10158 | 1,491.38  |
|       10144 | 1,128.20  |
|       10408 | 615.45    |
+-------------+-----------+
327 rows in set
```

### MySQL SUM 与 HAVING

您可以使用 HAVING 子句中在 `SUM` 函数中来根据特定条件过滤结果。例如，您可以计算总订单量，只能选择总金额大于 `60000` 的订单。如下查询语句 - 

```sql
SELECT orderNumber,
       FORMAT(SUM(quantityOrdered * priceEach),2)
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 60000
ORDER BY SUM(quantityOrdered * priceEach);
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT orderNumber,
       FORMAT(SUM(quantityOrdered * priceEach),2)
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 60000
ORDER BY SUM(quantityOrdered * priceEach);
+-------------+--------------------------------------------+
| orderNumber | FORMAT(SUM(quantityOrdered * priceEach),2) |
+-------------+--------------------------------------------+
|       10310 | 61,234.67                                  |
|       10287 | 61,402.00                                  |
|       10165 | 67,392.85                                  |
+-------------+--------------------------------------------+
3 rows in set
```

### MySQL SUM 与 LIMIT

假设您想要计算 `products` 表中前十名最昂贵的产品的总和，可以提出以下查询：

```sql
SELECT SUM(buyprice)
FROM products
ORDER BY buyprice DESC
LIMIT 10;
```

执行上面查询语句，得到以下结果 -

```sql
mysql> SELECT SUM(buyprice)
FROM products
ORDER BY buyprice DESC
LIMIT 10;
+---------------+
| SUM(buyprice) |
+---------------+
| 5983.47       |
+---------------+
1 row in set
```

它不起作用，因为具有 `SUM` 函数的 `SELECT` 语句只返回一行，`LIMIT` 子句约束要返回的行数无效。

要解决此问题，请使用以下子查询：

```sql
SELECT FORMAT(SUM(buyprice),2) FROM
(SELECT buyprice
FROM products
ORDER BY buyprice DESC
LIMIT 10) price;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------------------+
| FORMAT(SUM(buyprice),2) |
+-------------------------+
| 958.71                  |
+-------------------------+
1 row in set
```

上面语句是怎么运行的？

* 子查询选择十大价格最高的产品。
* 外部查询计算从子查询返回的前 `10` 个价格最高的产品的总和。

### MySQL SUM 与 NULL

如果没有匹配的行，则 `SUM` 函数返回 `NULL` 值。 有时，您希望 `SUM` 函数返回 `0` 而不是 `NULL`。 在这种情况下，可以使用 `COALESCE` 函数。`COALESCE` 函数接受两个参数，如果第一个参数为 `NULL`，则返回第二个参数，否则返回第一个参数; 参考以下查询语句：

```sql
SELECT COALESCE(SUM(quantityOrdered * priceEach),0)
FROM orderdetails
WHERE productCode = 'S1_212121';
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT COALESCE(SUM(quantityOrdered * priceEach),0)
FROM orderdetails
WHERE productCode = 'S1_212121';
+----------------------------------------------+
| COALESCE(SUM(quantityOrdered * priceEach),0) |
+----------------------------------------------+
| 0.00                                         |
+----------------------------------------------+
1 row in set
```

### MySQL SUM 与连接语句

您可以使用 SELECT JOIN 语句中的 `SUM` 函数根据另一个表中的值指定的条件来计算表中的值的总和。

例如，要计算取消订单金额的总和，请使用以下语句：

```sql
SELECT FORMAT(SUM(quantityOrdered * priceEach),2) loss
FROM orderdetails
INNER JOIN orders USING(orderNumber)
WHERE status = 'Cancelled'
```

在本教程中，您学习了如何使用 MySQL `SUM` 函数来计算列，表达式和分组值的总和。