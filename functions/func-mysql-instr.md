本教程将向您展示如何使用 MySQL `INSTR()` 函数返回字符串第一次出现的位置。

## MySQL INSTR 函数简介

有时，您想要在字符串中查找子字符串或检查字符串中是否存在子字符串。在这种情况下，您可以使用字符串内置 `INSTR()` 函数。

`INSTR()` 函数返回字符串中子字符串第一次出现的位置。如果在 `str` 中找不到子字符串，则 `INSTR()` 函数返回零(`0`)。

下面说明了 `INSTR` 函数的语法。

```sql
INSTR(str,substr);
```

`INSTR` 函数接受两个参数：

* `str` 是要搜索的字符串。
* `substr` 是要搜索的子字符串。

`INSTR()` 函数不区分大小写。这意味着如果通过小写，大写，标题大小写等，结果总是一样的。

如果希望 `INSTR` 函数在非二进制字符串上以区分大小写的方式执行搜索，则可以使用 `BINARY` 运算符将 `INSTR` 函数的参数从非二进制字符串转换为二进制字符串。

## MySQL INSTR 函数示例

以下语句返回 `MySQL INSTR` 字符串中的子字符串 `SQL` 的位置。

```sql
SELECT INSTR('MySQL INSTR', 'SQL');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT INSTR('MySQL INSTR', 'SQL');
+-----------------------------+
| INSTR('MySQL INSTR', 'SQL') |
+-----------------------------+
|                           3 |
+-----------------------------+
1 row in set
```

以下语句返回相同的结果，因为 `INSTR` 函数不区分大小写。

```sql
SELECT INSTR('MySQL INSTR', 'sql');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT INSTR('MySQL INSTR', 'sql');
+-----------------------------+
| INSTR('MySQL INSTR', 'sql') |
+-----------------------------+
|                           3 |
+-----------------------------+
1 row in set
```

要强制 `INSTR` 函数根据以区分大小写的方式进行搜索，请按如下所示使用 `BINARY` 运算符：

```sql
SELECT INSTR('MySQL INSTR', BINARY 'sql');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT INSTR('MySQL INSTR', BINARY 'sql');
+------------------------------------+
| INSTR('MySQL INSTR', BINARY 'sql') |
+------------------------------------+
|                                  0 |
+------------------------------------+
1 row in set
```

结果是不同的，因为现在使用 `BINARY` 运算符，因为 `sql` 与 `SQL` 是不同的字符串。

## INSTR 函数与 LIKE 运算符

我们将使用示例数据库(yiibaidb)中的 `products` 表，其表结构如下 - 

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


假设要查找名称包含 `car` 关键字的产品，可以使用 `INSTR` 函数，如下所示：

```sql
SELECT 
    productName
FROM
    products
WHERE
    INSTR(productname,'Car') > 0;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------------------------------+
| productName                            |
+----------------------------------------+
| 1911 Ford Town Car                     |
| 1999 Indy 500 Monte Carlo SS           |
| 18th Century Vintage Horse Carriage    |
| 1917 Maxwell Touring Car               |
| 1950s Chicago Surface Lines Streetcar |
| 1962 City of Detroit Streetcar         |
+----------------------------------------+
6 rows in set
```

除了 `INSTR` 函数，可以使用 `LIKE` 运算符来匹配 `Car` 模式。

```sql
SELECT 
    productname
FROM
    products
WHERE
    productname LIKE '%Car%';
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------------------------------+
| productname                            |
+----------------------------------------+
| 1911 Ford Town Car                     |
| 1999 Indy 500 Monte Carlo SS           |
| 18th Century Vintage Horse Carriage    |
| 1917 Maxwell Touring Car               |
| 1950s Chicago Surface Lines Streetcar |
| 1962 City of Detroit Streetcar         |
+----------------------------------------+
6 rows in set
```

两个查询返回相同的结果。那么哪一个更快，`INSTR` 还是 `LIKE` 操作符？

答案是它们是一样的，它们都区分大小写，并执行全表扫描。

让我们在 `productname` 列创建一个索引。

```sql
CREATE INDEX idx_products_name ON products(productname);
```

如果您使用具有前缀搜索的 `LIKE` 运算符，则在此索引列上，`LIKE` 运算符的执行速度要比 `INSTR` 函数快。

请参阅以下查询语句 - 

```sql
SELECT 
    productname
FROM
    products
WHERE
    productname LIKE '1900%';
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------------------+
| productname             |
+-------------------------+
| 1900s Vintage Bi-Plane  |
| 1900s Vintage Tri-Plane |
+-------------------------+
2 rows in set
```

您可以使用 `EXPLAIN` 语句检查它：

```sql
EXPLAIN SELECT 
    productname
FROM
    products
WHERE
    productname LIKE '1900%';
```

执行查询分析，得到以下结果 - 

![P8ei6S](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/P8ei6S.jpg)

下面使用 `INSTR` 函数执行查询分析，以进行比较，参考以下语句 - 

```sql
EXPLAIN SELECT 
    productname
FROM
    products
WHERE
    instr(productname,'1900');
```

执行查询分析，得到以下结果 - 

![6ydg6X](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/6ydg6X.jpg)

即使 `productname` 列具有索引，`INSTR` 函数也执行表扫描。 这是因为 MySQL 不能对 `INSTR` 函数的语义做任何假设，MySQL 可以利用其对 `LIKE` 运算符语义的理解。

测试字符串中是否存在子字符串的最快方法是使用全文索引。 但是，需要正确配置和维护索引。

在本教程中，您已经学习了如何使用 `INSTR` 函数来查找字符串中子字符串第一次出现的位置。