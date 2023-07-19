在本教程中，您将了解 MySQL `IFNULL()` 函数，这是一个非常方便的控制流函数来处理 `NULL` 值。

## MySQL IFNULL 函数简介

MySQL `IFNULL` 函数是 MySQL 控制流函数之一，它接受两个参数，如果不是 `NULL`，则返回第一个参数。 否则，`IFNULL` 函数返回第二个参数。

两个参数可以是文字值或表达式。

以下说明了 `IFNULL` 函数的语法：

```sql
IFNULL(expression_1,expression_2);
```

如果 `expression_1` 不为 `NULL`，则 `IFNULL` 函数返回 `expression_1`; 否则返回 `expression_2` 的结果。

`IFNULL` 函数根据使用的上下文返回字符串或数字。

如果要返回基于 `TRUE` 或 `FALSE` 条件的值，而不是 `NULL`，则应使用 IF 函数。

## MySQL 的 IFNULL 函数示例

请参见以下 `IFNULL` 函数示例：

** 示例 -1**

```sql
SELECT IFNULL(1,0); -- returns 1
```

** 示例 -2**

```sql
SELECT IFNULL('',1); -- returns''
```

** 示例 -3**

```sql
SELECT IFNULL(NULL,'IFNULL function'); -- returns IFNULL function
```

上面示例中的语句是怎么运行的？

* `IFNULL(1,0)` 返回 `1`，因为 `1` 不为 `NULL`。
* `IFNULL(''，1)` 返回 `''`，因为 `''` 字符串不为 `NULL`。
* `IFNULL(NULL，'IFNULL function')` 返回 `IFNULL` 函数字符串，因为第一个参数为 `NULL`。  

我们来看一下使用 `IFNULL` 函数的实例。

_ 首先 _，使用以下语句创建一个名为 `contacts` 的新表：

```sql
USE testdb;
CREATE TABLE IF NOT EXISTS contacts (
    contactid INT AUTO_INCREMENT PRIMARY KEY,
    contactname VARCHAR(20) NOT NULL,
    bizphone VARCHAR(15),
    homephone VARCHAR(15)
);
```

每个联系人都有一个名字，业务电话和家庭电话。

_ 其次 _，将数据插入到 `contacts` 表中：

```sql
INSERT INTO contacts(contactname,bizphone,homephone)
VALUES('John Doe','(541) 754-3009',NULL),
      ('Cindy Minsu',NULL,'(541) 754-3110'),
      ('Sue Greenspan','(541) 754-3010','(541) 754-3011'),
      ('Lily Bush',NULL,'(541) 754-3111');
```

一些联系人只有家庭电话或商务电话。要从 `contacts` 表中获取所有联系人姓名和电话，请使用以下查询：

```sql
SELECT 
    contactName, bizphone, homephone
FROM
    contacts;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------+----------------+----------------+
| contactName   | bizphone       | homephone      |
+---------------+----------------+----------------+
| John Doe      | (541) 754-3009 | NULL           |
| Cindy Minsu   | NULL           | (541) 754-3110 |
| Sue Greenspan | (541) 754-3010 | (541) 754-3011 |
| Lily Bush     | NULL           | (541) 754-3111 |
+---------------+----------------+----------------+
4 rows in set
```

如果联系人的商务电话不可用，可以通过查询获得联系人的家庭电话也是一个获取联系方式的办法 - 

```sql
SELECT 
    contactname, IFNULL(bizphone, homephone) phone
FROM
    contacts;
```

这可以使用 `IFNULL()` 函数来解决。如果 `bizphone` 为 `NULL`，则 `IFNULL` 函数将返回 `homephone` 的值。

_ 第三 _，使用以下查询获取所有联系人的姓名和电话：

```sql
mysql> SELECT 
    contactname, IFNULL(bizphone, homephone) phone
FROM
    contacts;
+---------------+----------------+
| contactname   | phone          |
+---------------+----------------+
| John Doe      | (541) 754-3009 |
| Cindy Minsu   | (541) 754-3110 |
| Sue Greenspan | (541) 754-3010 |
| Lily Bush     | (541) 754-3111 |
+---------------+----------------+
4 rows in set
```

请注意，应避免在 WHERE 子句中使用 `IFNULL` 函数，因为它会降低查询的性能。

如果要检查值是否为 `NULL`，则可以在 `WHERE` 子句中使用 `IS NULL` 或 `IS NOT NULL`。

在本教程中，我们向您介绍了 MySQL `IFNULL` 函数，并向您展示了如何在查询中使用 `IFNULL` 函数。