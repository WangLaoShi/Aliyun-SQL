在本教程中，您将了解MySQL `NULLIF`函数以及如何使用它来防止查询中的除以零错误。

## MySQL NULLIF函数简介

`NULLIF`函数是接受`2`个参数的控制流函数之一。如果第一个参数等于第二个参数，则`NULLIF`函数返回`NULL`，否则返回第一个参数。

`NULLIF`函数的语法如下：

```sql
NULLIF(expression_1,expression_2);
```

如果`expression_1 = expression_2`为`true`，则`NULLIF`函数返回`NULL`，否则返回`expression_1` 。

请注意，`NULLIF`函数与以下使用`CASE`的表达式类似：

```sql
CASE WHEN expression_1 = expression_2
   THEN NULL
ELSE
   expression_1
END;
```

> 请注意，不要将`NULLIF`函数与[IFNULL函数](functions/func-mysql-ifnull.md)混淆。

## MySQL NULLIF示例

我们来看一下使用`NULLIF`函数来了解它的工作原理的一些例子。

**示例-1**

```sql
mysql> SELECT NULLIF(1,1);
+-------------+
| NULLIF(1,1) |
+-------------+
| NULL        |
+-------------+
1 row in set
```

**示例-2**

```sql
mysql> SELECT NULLIF(1,2);
+-------------+
| NULLIF(1,2) |
+-------------+
|           1 |
+-------------+
1 row in set
```

**示例-3**

```sql
mysql> SELECT NULLIF('MySQL NULLIF','MySQL NULLIF');
+---------------------------------------+
| NULLIF('MySQL NULLIF','MySQL NULLIF') |
+---------------------------------------+
| NULL                                  |
+---------------------------------------+
1 row in set
```

**示例-4**

```sql
mysql> SELECT NULLIF('MySQL NULLIF','MySQL IFNULL');
+---------------------------------------+
| NULLIF('MySQL NULLIF','MySQL IFNULL') |
+---------------------------------------+
| MySQL NULLIF                          |
+---------------------------------------+
1 row in set
```

**示例-6**

```sql
mysql> SELECT NULLIF(1,NULL);
+----------------+
| NULLIF(1,NULL) |
+----------------+
|              1 |
+----------------+
1 row in set
```

**示例-7**

```sql
mysql> SELECT NULLIF(NULL,1);
+----------------+
| NULLIF(NULL,1) |
+----------------+
| NULL           |
+----------------+
1 row in set
```

上面示例中的语句是如何工作的？

* `NULIF(1,1)`返回`NULL`，因为`1`等于`1`。
* `NULLIF(1,2)`返回`1`，这是第一个参数，因为`1`不等于`2`。
* `NULLIF('MySQL NULLIF'，'MySQL NULLIF')`返回`NULL`，因为两个参数是相同的字符串。
* `NULLIF('MySQL NULLIF'，'MySQL NULLIF')`返回MySQL `NULLIF`，因为两个字符串不相等。
* `NULLIF(1，NULL)`返回`1`，因为`1`不等于`NULL`。
* `NULLIF(NULL，1)`返回第一个参数，即`NULL`，因为`NULL`不等于`1`。

## 使用NULLIF函数来防止除零错误

我们经常使用`NULLIF`函数来阻止在查询中除以零错误。如果MySQL服务器启用了`ERROR_FOR_DIVISION_BY_ZERO`模式，则当发生零除数时将发出错误。

见下列查询语句：

```sql
SELECT 1/0; -- cause error
```

上面语句得到以下结果 - 

```sql
mysql> SELECT 1/0; 
+------+
| 1/0  |
+------+
| NULL |
+------+
1 row in set
```

在这种情况下，您可以使用`NULLIF`函数来阻止除以零，如下所示：

```sql
SELECT 1/NULLIF(0,0); -- return NULL
```

因为`0`等于`0`，所以`NULLIF(0,0)`表达式返回`NULL`。结果语句返回`NULL`。

我们来看看示例数据库(yiibaidb)中的`orders`表，其结构如下所示 -

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

_首先_，要获取2013年6月创建的所有订单，请使用以下查询：

```sql
SELECT 
    orderNumber, orderdate, requiredDate, shippedDate, status
FROM
    orders
WHERE
    orderDate BETWEEN '2013-06-01' AND '2013-06-30';
```

执行上面查询语句得到以下结果 - 

```sql
+-------------+------------+--------------+-------------+---------+
| orderNumber | orderdate  | requiredDate | shippedDate | status  |
+-------------+------------+--------------+-------------+---------+
|       10127 | 2013-06-03 | 2013-06-09   | 2013-06-06  | Shipped |
|       10128 | 2013-06-06 | 2013-06-12   | 2013-06-11  | Shipped |
|       10129 | 2013-06-12 | 2013-06-18   | 2013-06-14  | Shipped |
|       10130 | 2013-06-16 | 2013-06-24   | 2013-06-21  | Shipped |
|       10131 | 2013-06-16 | 2013-06-25   | 2013-06-21  | Shipped |
|       10132 | 2013-06-25 | 2013-07-01   | 2013-06-28  | Shipped |
|       10133 | 2013-06-27 | 2013-07-04   | 2013-07-03  | Shipped |
+-------------+------------+--------------+-------------+---------+
7 rows in set
```

_第二_，计算2013年6月发货订单数量/取消订单数量，可使用[SUM](http://www.yiibai.com/mysql/sum.html "SUM")和[IF](http://www.yiibai.com/mysql/if-function.html "IF")函数。

```sql
SELECT SUM(IF(status = 'Shipped',1,0)) / 
       SUM(IF(status = 'Cancelled',1,0))
FROM orders
WHERE orderDate BETWEEN '2013-06-01' and '2013-06-30';
```

执行上面查询语句，得到以下结果  - 

```sql
+------------------------------------------------------------------------+
| SUM(IF(status = 'Shipped',1,0)) /SUM(IF(status = 'Cancelled',1,0)) |
+------------------------------------------------------------------------+
| NULL                                                                       |
+------------------------------------------------------------------------+
1 row in set
```

MySQL发出错误，因为在2013年6月没有创建取消订单。 这意味着表达式`SUM(IF(status ='Cancelled'，1,0))`返回`0`。

_第三_，为了防止除`0`错误，您可以使用`NULLIF`函数，如下查询：

```sql
SELECT 
    SUM(IF(status = 'Shipped', 1, 0)) /NULLIF(SUM(IF(status = 'Cancelled', 1, 0)), 0)
FROM
    orders
WHERE
    orderDate BETWEEN '2013-06-01' AND '2013-06-30';
```

执行上面查询语句，得到以下结果  - 

```sql
+-------------------------------------------------------------------------+
| SUM(IF(status = 'Shipped', 1, 0)) /NULLIF(SUM(IF(status = 'Cancelled', 1, 0)), 0) |
+-------------------------------------------------------------------------+
| NULL                                                                              |
+-------------------------------------------------------------------------+
1 row in set
```

因为2013年6月没有创建取消订单，所以`SUM(IF(status ='Cancelled'，1,0))`返回`0`，这也使得`NULLIF(SUM(IF(status ='Cancelled'，1,0) ，0)`表达式返回`NULL`值。

在本教程中，我们向您介绍了`NULLIF`函数，这在某些情况下非常方便，例如阻止查询中的零错误。