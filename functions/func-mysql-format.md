本教程将向您展示如何使用 MySQL `FORMAT` 函数格式化各种语言环境中的十进制数。

## MySQL FORMAT 函数简介

有时，您使用表达式或聚合函数 (如 AVG) 来计算数据库中的值，例如库存周转率，产品的平均价格，平均发票值等。

表达式的结果是十进制数，并带有许多小数位。要格式化这些数字，您可以使用具有以下语法的 `FORMAT` 函数：

```sql
FOMRAT(N,D,locale);
```

`FORMAT` 函数将数字 N 格式化为格式，如 `"#,###,###.##"`，舍入到 `D` 位小数。它返回一个值作为字符串。

`FORMAT` 函数接受三个参数：

* `N` 是要格式化的数字。
* `D` 是要舍入的小数位数。
* `locale` 是一个可选参数，用于确定千个分隔符和分隔符之间的分组。如果省略 `locale` 操作符，MySQL 将默认使用 `en_US`。以下链接提供 MySQL 支持的所有区域名称：http://dev.mysql.com/doc/refman/5.7/en/locale-support.html

## MySQL FORMAT 函数示例

请参阅使用 `FORMAT` 函数的示例 - 

```sql
mysql> SELECT FORMAT(14500.2018, 2);
+-----------------------+
| FORMAT(14500.2018, 2) |
+-----------------------+
| 14,500.20             |
+-----------------------+
1 row in set
```

以下语句使用 `FORMAT` 函数，第二个参数为 `0`，因此，结果没有任何小数位。

```sql
mysql> SELECT FORMAT(12500.2015, 0);
+-----------------------+
| FORMAT(12500.2015, 0) |
+-----------------------+
| 12,500                |
+-----------------------+
1 row in set
```

以下语句使用 `de_DE` 语言环境而不是 `en_US` 语言环境：

```sql
mysql> SELECT FORMAT(12500.2015, 2,'de_DE');
+-------------------------------+
| FORMAT(12500.2015, 2,'de_DE') |
+-------------------------------+
| 12.500,20                     |
+-------------------------------+
1 row in set
```

正如在上面的结果中看到的那样，`de_DE` 语言环境使用点 (`.`) 来分隔千位和逗号 (`，`) 来分隔小数点。

我们来看看示例数据库 (yiibaidb) 中的 `products` 表，其结构如下所示 - 

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

要计算每个产品的总价值，可以使用库存数量乘以价格，如下查询语句：

```sql
SELECT 
    productname, quantityInStock * buyPrice stock_value
FROM
    products;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------------------------+-------------+
| productname                                 | stock_value |
+---------------------------------------------+-------------+
| 1969 Harley Davidson Ultimate Chopper       | 387209.73   |
| 1952 Alpine Renault 1300                    | 720126.90   |
| 1996 Moto Guzzi 1100i                       | 457058.75   |
********** 此处省略了一大波数据 ******************************
| The Titanic                                 | 99932.04    |
| The Queen Mary                              | 272869.44   |
| American Airlines: MD-11S                   | 319901.40   |
| Boeing X-32A JSF                            | 159163.89   |
| Pont Yacht                                  | 13786.20    |
+---------------------------------------------+-------------+
110 rows in set
```

上面查询结果显示对阅读不太友好，因为有很多位小数。

为了使结果更好阅读，您可以组合两个函数：`FORMAT` 和 `CONCAT`。 `FORMAT` 函数将库存值格式舍入为 `2` 位小数。 并且 CONCAT 函数在库存值字符串的开头添加人民币符号(`￥`)：

```sql
SELECT 
    productname,
    CONCAT('￥',
            FORMAT(quantityInStock * buyPrice, 2)) stock_value
FROM
    products;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------------------------+--------------+
| productname                                 | stock_value  |
+---------------------------------------------+--------------+
| 1969 Harley Davidson Ultimate Chopper       | ￥387,209.73 |
| 1952 Alpine Renault 1300                    | ￥720,126.90 |
| 1996 Moto Guzzi 1100i                       | ￥457,058.75 |
| 2003 Harley-Davidson Eagle Drag Bike        | ￥508,073.64 |
| 1972 Alfa Romeo GTA                         | ￥278,631.36 |
********** 此处省略了一大波数据 ******************************
| American Airlines: MD-11S                   | ￥319,901.40 |
| Boeing X-32A JSF                            | ￥159,163.89 |
| Pont Yacht                                  | ￥13,786.20  |
+---------------------------------------------+--------------+
110 rows in set
```

请注意，`FORMAT` 函数返回一个字符串值。这意味着如果要使用 ORDER BY 子句对 `FORMAT` 函数的结果进行排序，MySQL 将使用基于字符串而非基于数字的方式对结果进行排序。

例如，以下语句按字母顺序排列 `stock_value` 值。

```sql
SELECT 
    productname,
    CONCAT('$',
            FORMAT(quantityInStock * buyPrice, 2)) stock_value
FROM
    products
ORDER BY stock_value;
```

执行上面查询语句，得到以下结果(部分) - 

![jGIVWN](https://oss.images.shujudaka.com/uPic/jGIVWN.jpg)

要以数字方式对 `stock_value` 值进行排序，请将表达式放在 `ORDER BY` 子句中，如下所示：

```sql
SELECT 
    productname,
    CONCAT('￥',
            FORMAT(quantityInStock * buyPrice, 2)) stock_value
FROM
    products
ORDER BY quantityInStock * buyPrice;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------------------------+--------------+
| productname                                 | stock_value  |
+---------------------------------------------+--------------+
| 1960 BSA Gold Star DBD34                    | ￥559.80     |
| 1928 Ford Phaeton Deluxe                    | ￥4,490.72   |
| 1968 Ford Mustang                           | ￥6,483.12   |
| 1997 BMW F650 ST                            | ￥11,911.76  |
| Pont Yacht                                  | ￥13,786.20  |
********** 此处省略了一大波数据 ******************************
| 1976 Ford Gran Torino                       | ￥670,743.23 |
| 1968 Dodge Charger                          | ￥685,684.68 |
| 1962 LanciaA Delta 16V                      | ￥702,325.22 |
| 1952 Alpine Renault 1300                    | ￥720,126.90 |
| 1995 Honda Civic                            | ￥917,493.08 |
+---------------------------------------------+--------------+
110 rows in set
```

在本教程中，我们向您展示了如何使用 MySQL `FORMAT` 函数来格式化各种语言环境中的数字值。