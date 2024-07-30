在本教程中，您将学习如何使用 MySQL `GROUP_CONCAT` 函数将分组中的字符串与各种选项进行连接。

## MySQL GROUP_CONCAT 函数介绍

MySQL `GROUP_CONCAT()` 函数将组中的字符串连接成为具有各种选项的单个字符串。

下面说明了 `GROUP_CONCAT()` 函数的语法：

```sql
GROUP_CONCAT(DISTINCT expression
    ORDER BY expression
    SEPARATOR sep);
```

以下是演示 `GROUP_CONCAT()` 函数如何工作的一个示例。

```sql
USE testdb;
CREATE TABLE t (v CHAR);

INSERT INTO t(v) VALUES('A'),('B'),('C'),('B');

SELECT 
    GROUP_CONCAT(DISTINCT v
        ORDER BY v ASC
        SEPARATOR ';')
FROM
    t;
-- SELECT v FROM t GROUP BY v;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------------------------------------------------+
| GROUP_CONCAT(DISTINCT v
        ORDER BY v ASC
        SEPARATOR ';') |
+---------------------------------------------------------------------+
| A;B;C                                                               |
+---------------------------------------------------------------------+
1 row in set
```

> 注：上面语句类似于把 `SELECT v FROM t GROUP BY v;` 语句的结果串接起来。

参考以下图解 - 

![3eIaPk](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/3eIaPk.jpg)

DISTINCT 子句用于在连接分组之前消除组中的重复值。

ORDER BY 子句允许您在连接之前按升序或降序排序值。 默认情况下，它按升序排序值。 如果要按降序对值进行排序，则需要明确指定 `DESC` 选项。

`SEPARATOR` 指定在组中的值之间插入的文字值。如果不指定分隔符，则 `GROUP_CONCAT` 函数使用逗号 (`，`) 作为默认分隔符。

`GROUP_CONCAT` 函数忽略 `NULL` 值，如果找不到匹配的行，或者所有参数都为 `NULL` 值，则返回 `NULL`。

`GROUP_CONCAT` 函数返回二进制或非二进制字符串，这取决于参数。 默认情况下，返回字符串的最大长度为 `1024`。如果您需要更多的长度，可以通过在 `SESSION` 或 `GLOBAL` 级别设置 `group_concat_max_len` 系统变量来扩展最大长度。

## MySQL GROUP_CONCAT 示例

让我们来看看示例数据库 (yiibaidb) 中的 `customers` 表，其表结构如下所示 - 

```sql
mysql> desc customers;
+------------------------+---------------+------+-----+---------+-------+
| Field                  | Type          | Null | Key | Default | Extra |
+------------------------+---------------+------+-----+---------+-------+
| customerNumber         | int(11)       | NO   | PRI | NULL    |       |
| customerName           | varchar(50)   | NO   |     | NULL    |       |
| contactLastName        | varchar(50)   | NO   |     | NULL    |       |
| contactFirstName       | varchar(50)   | NO   |     | NULL    |       |
| phone                  | varchar(50)   | NO   |     | NULL    |       |
| addressLine1           | varchar(50)   | NO   |     | NULL    |       |
| addressLine2           | varchar(50)   | YES  |     | NULL    |       |
| city                   | varchar(50)   | NO   |     | NULL    |       |
| state                  | varchar(50)   | YES  |     | NULL    |       |
| postalCode             | varchar(15)   | YES  |     | NULL    |       |
| country                | varchar(50)   | NO   |     | NULL    |       |
| salesRepEmployeeNumber | int(11)       | YES  | MUL | NULL    |       |
| creditLimit            | decimal(10,2) | YES  |     | NULL    |       |
+------------------------+---------------+------+-----+---------+-------+
13 rows in set
```

要获取客户所在的国家 / 地区，以逗号分隔的字符串，您可以使用 `GROUP_CONCAT` 函数，如下所示：

```sql
SELECT 
    GROUP_CONCAT(country)
FROM
    customers;
```

执行上面查询语句，得到以下结果 - 

![w6Nnk9](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/w6Nnk9.jpg)

然而，一些客户位于同一个国家。要删除重复的国家 / 地区名称，请将 `DISTINCT` 子句添加到函数，如下查询：

```sql
mysql> SELECT 
    GROUP_CONCAT(DISTINCT country)
FROM
    customers;
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| GROUP_CONCAT(DISTINCT country)                                                                                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| France,USA,Australia,Norway,Poland,Germany,Spain,Sweden,Denmark,Singapore,Portugal,Japan,Finland,UK,Ireland,Canada,Hong Kong,Italy,Switzerland,Netherlands,Belgium,New Zealand,South Africa,Austria,Philippines,Russia,Israel |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set
```

如果国家的名称按升序排列，则可读性更高。要在连接之前排序国家的名称，请使用 `ORDER BY` 子句如下：

```sql
SELECT 
    GROUP_CONCAT(DISTINCT country
        ORDER BY country)
FROM
    customers;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT 
    GROUP_CONCAT(DISTINCT country
        ORDER BY country)
FROM
    customers;
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| GROUP_CONCAT(DISTINCT country
        ORDER BY country)                                                                                                                                                                        |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Australia,Austria,Belgium,Canada,Denmark,Finland,France,Germany,Hong Kong,Ireland,Israel,Italy,Japan,Netherlands,New Zealand,Norway,Philippines,Poland,Portugal,Russia,Singapore,South Africa,Spain,Sweden,Switzerland,UK,USA |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set
```

要将返回的字符串的默认分隔符从逗号 (`，`) 更改为分号(`;`)，请使用 `SEPARATOR` 子句作为以下查询：

```sql
SELECT 
    GROUP_CONCAT(DISTINCT country
        ORDER BY country
        SEPARATOR ';')
FROM
    customers;
```

执行上面查询语句，得到以下结果 - 

```sql
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| GROUP_CONCAT(DISTINCT country
        ORDER BY country
        SEPARATOR ';')                                                                                                                                                   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Australia;Austria;Belgium;Canada;Denmark;Finland;France;Germany;Hong Kong;Ireland;Israel;Italy;Japan;Netherlands;New Zealand;Norway;Philippines;Poland;Portugal;Russia;Singapore;South Africa;Spain;Sweden;Switzerland;UK;USA |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set
```

经过上面几个简单示例，现在您应该知道 `GROUP_CONCAT` 函数是如何工作，现在把它应用在一个实际的例子中。

每个客户都有一个或多个销售代表。 换句话说，每个销售人员都负责一个或多个客户。 要了解谁负责哪些客户，使用 inner join 子句如下：

```sql
SELECT 
    employeeNumber, firstname, lastname, customername
FROM
    employees
        INNER JOIN
    customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
ORDER BY firstname , lastname;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------+-----------+-----------+------------------------------------+
| employeeNumber | firstname | lastname  | customername                       |
+----------------+-----------+-----------+------------------------------------+
|           1611 | Andy      | Fixter    | Souveniers And Things Co.          |
|           1611 | Andy      | Fixter    | Australian Collectables, Ltd       |
|           1611 | Andy      | Fixter    | Australian Gift Network, Co        |
|           1611 | Andy      | Fixter    | Australian Collectors, Co.         |
|           1611 | Andy      | Fixter    | Anna's Decorations, Ltd            |
|           1504 | Barry     | Jones     | Baane Mini Imports                 |
|           1504 | Barry     | Jones     | Toms Spezialitten, Ltd             |
************* 此处省略了一大波数据 *********************************************
|           1216 | Steve     | Patterson | Auto-Moto Classics Inc.            |
|           1216 | Steve     | Patterson | Gifts4AllAges.com                  |
|           1216 | Steve     | Patterson | FunGiftIdeas.com                   |
|           1216 | Steve     | Patterson | Diecast Classics Inc.              |
|           1216 | Steve     | Patterson | Online Diecast Creations Co.       |
+----------------+-----------+-----------+------------------------------------+
122 rows in set
```

现在，我们可以按员工编号对结果集进行分组，并使用 `GROUP_CONCAT` 函数连接正在负责员工的所有员工，如下所示：

```sql
SELECT 
    employeeNumber,
    firstName,
    lastName,
    GROUP_CONCAT(DISTINCT customername
        ORDER BY customerName)
FROM
    employees
        INNER JOIN
    customers ON customers.salesRepEmployeeNumber = employeeNumber
GROUP BY employeeNumber
ORDER BY firstName , lastname;
```

上面查询语句，执行结果如下 - 

![dMCcZF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/dMCcZF.jpg)

如下所示的结果更容易阅读。

### 具有 CONCAT_WS 函数的 MySQL GROUP_CONCAT 函数的示例

有时，`GROUP_CONCAT` 函数可以与 CONCAT_WS 函数相结合，使查询结果更有用。

例如，制作客户分号分隔值列表：

* 首先，使用 `CONCAT_WS` 函数连接每个客户联系人的姓氏和名字，结果是联系人的全名。
* 然后，使用 `GROUP_CONCAT` 函数来创建列表。

以下查询使客户的分号分隔值列表。

```sql
SELECT 
    GROUP_CONCAT(CONCAT_WS(',', contactLastName, contactFirstName)
        SEPARATOR ';')
FROM
    customers;
```

请注意，`GROUP_CONCAT` 函数将字符串值连接在不同的行中，而 `CONCAT_WS` 或 CONCAT 函数将不同列中的两个或多个字符串值连接起来。

### MySQL GROUP_CONCAT 函数：常见错误

`GROUP_CONCAT` 函数返回单个字符串，而不是值列表。 这意味着您不能在 `IN` 操作符中使用 `GROUP_CONCAT` 函数的结果，例如在子查询中使用。

例如，`GROUP_CONCAT` 函数返回值的结果：`1`, `2` 和 `3` 连接成为字符串：`1,2,3` 。

如果将此结果提供给 `IN` 运算符，则查询不能正常工作。因此，查询可能不返回任何结果。例如，以下查询将无法正常工作。

因为 IN 运算符接受诸如 `(1,2,3)` 的值的列表，而不是由值列表 `('1,2,3')` 组成的字符串。 因此，以下查询将无法正常工作。

```sql
SELECT 
    id, name
FROM
    table_name
WHERE
    id IN GROUP_CONCAT(id);
```

因为 `GROUP_CONCAT` 函数是一个聚合函数，要对值进行排序，必须在函数内使用 `ORDER BY` 子句，而不是 SELECT 语句中的 `ORDER BY`。

以下示例演示了在使用 `GROUP_CONCAT` 函数的上下文中 `ORDER BY` 子句的不正确使用：

```sql
SELECT 
    GROUP_CONCAT(DISTINCT country
        SEPARATOR ';')
FROM
    customers
ORDER BY country;
```

`SELECT` 子句返回一个字符串值，因此 `ORDER BY` 子句在此语句中不起作用。

### MySQL GROUP_CONCAT 应用程序

在许多情况下，您可以应用 `GROUP_CONCAT` 函数来产生有用的结果。 以下列表是使用 `GROUP_CONCAT` 函数的一些常见示例。

* 用逗号分隔的用户角色，如“管理员，作者，编辑人员”。
* 生成逗号分隔的用户的爱好，如“设计，编程，阅读”。
* 为博客帖子，文章或产品创建标签，例如“mysql，mysql 聚合函数，mysql 教程”。

在本教程中，我们介绍了 MySQL `GROUP_CONCAT` 函数，将非空值从一组字符串连接到具有各种选项的字符串中。

** 参考 **

MySQL GROUP_CONCAT 函数 :  
http://dev.mysql.com/doc/refman/5.7/en/group-by-functions.html#function_group-concat