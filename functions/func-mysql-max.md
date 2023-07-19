在本教程中，您将学习如何使用 MySQL `MAX` 函数来获取一组值中的最大值。

## MySQL MAX 函数介绍

MySQL `MAX()` 函数返回一组值中的最大值。`MAX()` 函数在许多查询中非常方便，例如查找最大数量，最昂贵的产品以及客户的最大付款。

`MAX()` 函数的语法如下：

```sql
MAX(DISTINCT expression);
```

如果添加 `DISTINCT` 运算符，则 `MAX` 函数返回不同值的最大值，它与所有值的最大值相同。 这意味着 `DISTINCT` 运算符不会对 `MAX` 函数产生任何影响(用不用 `DISTINCT` 运算符都可以)。

请注意，`DISTINCT` 运算符在其他聚合函数 (如 COUNT，SUM 和 AVG) 中生效。

## MySQL MAX 函数示例

我们来看看示例数据库 (yiibaidb) 中的 `payments` 表，其表结构如下所示 - 

```sql
mysql> desc payments;
+----------------+---------------+------+-----+---------+-------+
| Field          | Type          | Null | Key | Default | Extra |
+----------------+---------------+------+-----+---------+-------+
| customerNumber | int(11)       | NO   | PRI | NULL    |       |
| checkNumber    | varchar(50)   | NO   | PRI | NULL    |       |
| paymentDate    | date          | NO   |     | NULL    |       |
| amount         | decimal(10,2) | NO   |     | NULL    |       |
+----------------+---------------+------+-----+---------+-------+
4 rows in set
```

要在 `payments` 表中获得最大的付款，您可以使用以下查询：

```sql
SELECT 
    MAX(amount)
FROM
    payments;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT 
    MAX(amount)
FROM
    payments;
+-------------+
| MAX(amount) |
+-------------+
| 120166.58   |
+-------------+
1 row in set
```

### MySQL MAX 函数在子查询中

不仅要获得最大的付款金额，还要获得其他付款信息，如客户编号，支票号码和付款日期，您可以在子查询中使用 `MAX` 函数，如下所示：

```sql
SELECT 
    *
FROM
    payments
WHERE
    amount = (
 SELECT 
            MAX(amount)
        FROM
            payments);
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------+-------------+-------------+-----------+
| customerNumber | checkNumber | paymentDate | amount    |
+----------------+-------------+-------------+-----------+
|            141 | JE105477    | 2015-03-18  | 120166.58 |
+----------------+-------------+-------------+-----------+
1 row in set
```

上面查询语句是怎么运行的？

* 子查询返回所有的最大付款金额。
* 外部查询获取的金额等于从子查询返回的最大金额的其他相关付款信息。

不使用 `MAX` 函数的另一种方法是使用 ORDER BY 子句以降序对结果集进行排序，并使用 LIMIT 子句获取第一行，如下查询：

```sql
SELECT 
    *
FROM
    payments
ORDER BY amount DESC
LIMIT 1;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------+-------------+-------------+-----------+
| customerNumber | checkNumber | paymentDate | amount    |
+----------------+-------------+-------------+-----------+
|            141 | JE105477    | 2015-03-18  | 120166.58 |
+----------------+-------------+-------------+-----------+
1 row in set
```

如果您没有在 `amount` 列上创建索引，则第二个查询执行速度更快，因为它会检查 `payments` 表中的所有行，而第一个查询会检查 `payments` 表中的所有行两次，一次是在子查询中，另一次在外部查询中。 但是，如果 `amount` 列被索引，则第一个查询将执行得更快。

### 具有 GROUP BY 子句的 MySQL MAX

要找到每个组的最大值，您可以在 SELECT 语句中使用 `MAX` 函数与 GROUP BY 子句。

对于每个客户，查询获得客户已支付的最大付款，可使用以下查询：

```sql
SELECT 
    customerNumber, MAX(amount)
FROM
    payments
GROUP BY customerNumber
ORDER BY MAX(amount);
```

执行上面查询语句，得到以下查询结果 - 

```sql
+----------------+-------------+
| customerNumber | MAX(amount) |
+----------------+-------------+
|            219 | 4465.85     |
|            198 | 9658.74     |
|            381 | 14379.9     |
|            103 | 14571.44    |
|            473 | 17746.26    |
|            362 | 18473.71    |
******* 此处省略一大波数据 ******
|            148 | 105743      |
|            124 | 111654.4    |
|            141 | 120166.58   |
+----------------+-------------+
98 rows in set
```

### 具有 HAVING 子句的 MySQL MAX

您可以在 HAVING 子句中使用 `GROUP BY` 子句中的 `MAX` 函数，以根据指定的条件为分组添加过滤器。

例如，以下查询查找每个客户的最大付款; 并根据返回款项，如下面查询语句，只查询金额超过 `80000` 的付款 - 

```sql
SELECT 
    customerNumber, MAX(amount)
FROM
    payments
GROUP BY customerNumber
HAVING MAX(amount) > 80000;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------+-------------+
| customerNumber | MAX(amount) |
+----------------+-------------+
|            114 | 82261.22    |
|            124 | 111654.4    |
|            141 | 120166.58   |
|            148 | 105743      |
|            167 | 85024.46    |
|            239 | 80375.24    |
|            321 | 85559.12    |
+----------------+-------------+
7 rows in set
```

在本教程中，我们向您展示了如何使用 MySQL `MAX` 函数来查找一组值中的最大值。