在本教程中，我们将向您展示如何使用 MySQL `CASE` 表达式来构造条件查询。

## MySQL CASE 表达式简介

MySQL `CASE` 表达式是一个流控制结构，允许您在查询中构造条件，例如：SELECT 或 WHERE 子句。 MySQL 为您提供了两种形式的 `CASE` 表达式。

以下说明了 `CASE` 表达式的第一种形式。

```sql
CASE value
WHEN compare_value_1 THEN result_1
WHEN compare_value_2 THEN result_2
…
ELSE result END
```

如果 `value` 等于 `compare_value`，例如 `compare_value_1`，`compare_value_2` 等，则 `CASE` 表达式返回相应的结果，即 `result_1`，`result_2`。 如果值不与任何 `compare_value` 匹配，则 `CASE` 表达式将返回 `ELSE` 子句中指定的结果。

`CASE` 表达式的第二种形式如下：

```sql
CASE
WHEN condition_1 THEN result_1
WHEN condition_2 THEN result_2
…
ELSE result END
```

在第二种形式中，如果条件为 `True`，则 `CASE` 表达式返回结果，如 `result_1`，`result_2` 等。 如果所有条件都为 `false`，则返回 `ELSE` 部分中的结果。如果省略 `ELSE` 部分，`CASE` 表达式将返回 `NULL`。

`CASE` 表达式返回的数据类型取决于使用它的上下文的结果。 例如，如果在字符串上下文中使用 `CASE` 表达式，则会以字符串形式返回结果。 如果在数值上下文中使用 `CASE` 表达式，则会以整数，小数或实数值的形式返回结果。

## MySQL CASE 函数示例

让我们来看看示例数据库 (yiibaidb) 中的 `customers` 表，其结构如下所示 - 

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

假设您要按状态对客户进行排序，如果状态为 `NULL`，则要使用国家作为排序标准。要实现这一点，您可以使用第一种形式的 `CASE` 表达式如下：

```sql
SELECT 
    customerName, state, country
FROM
    customers
ORDER BY (CASE
    WHEN state IS NULL THEN country
    ELSE state
END);
```

执行上面查询语句，得到以下结果 - 

```sql
+------------------------------------+---------------+--------------+
| customerName                       | state         | country      |
+------------------------------------+---------------+--------------+
| Salzburg Collectables              | NULL          | Austria      |
| Mini Auto Werke                    | NULL          | Austria      |
| Canadian Gift Exchange Network     | BC            | Canada       |
| Royal Canadian Collectables, Ltd.  | BC            | Canada       |
| Petit Auto                         | NULL          | Belgium      |
| Royale Belge                       | NULL          | Belgium      |
| Mini Gifts Distributors Ltd.       | CA            | USA          |
| Mini Wheels Co.                    | CA            | USA          |
************ 此处省略了一大波数据 *************************************
| AV Stores, Co.                     | NULL          | UK           |
| UK Collectables, Ltd.              | NULL          | UK           |
| Stylish Desk Decors, Co.           | NULL          | UK           |
| Double Decker Gift Stores, Ltd     | NULL          | UK           |
| Australian Collectors, Co.         | Victoria      | Australia    |
| Australian Collectables, Ltd       | Victoria      | Australia    |
+------------------------------------+---------------+--------------+
122 rows in set
```

在本示例中，我们使用 ORDER BY 子句中的 `CASE` 表达式来确定要排序的字段为： `state` 或 `country` 。

在接下来的一个示例中，我们将使用示例数据库 (yiibaidb) 中的 `orders` 表来演示 `CASE` 表达式的第二种形式。

如果您希望通过按状态查看销售订单数量，例如发货订单数量，待发货订单等，则可以使用 `CASE` 表达式的第二种形式，如下所示：

```sql
SELECT 
    SUM(CASE
        WHEN status = 'Shipped' THEN 1
        ELSE 0
    END) AS 'Shipped',
    SUM(CASE
        WHEN status = 'On Hold' THEN 1
        ELSE 0
    END) AS 'On Hold',
    SUM(CASE
        WHEN status = 'In Process' THEN 1
        ELSE 0
    END) AS 'In Process',
    SUM(CASE
        WHEN status = 'Resolved' THEN 1
        ELSE 0
    END) AS 'Resolved',
    SUM(CASE
        WHEN status = 'Cancelled' THEN 1
        ELSE 0
    END) AS 'Cancelled',
    SUM(CASE
        WHEN status = 'Disputed' THEN 1
        ELSE 0
    END) AS 'Disputed',
    COUNT(*) AS Total
FROM
    orders;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------+---------+------------+----------+-----------+----------+-------+
| Shipped | On Hold | In Process | Resolved | Cancelled | Disputed | Total |
+---------+---------+------------+----------+-----------+----------+-------+
| 303     | 4       | 7          | 4        | 6         | 3        |   327 |
+---------+---------+------------+----------+-----------+----------+-------+
1 row in set
```

在 SELECT 语句中，如果状态等于 `Shipped`，`On Hold` 等，则 `CASE` 表达式返回 `1`，否则返回 `0`，我们使用 `SUM` 函数计算每种状态的订单的销售总数。

在本教程中，我们向您展示了如何在 `SELECT` 语句中使用 MySQL `CASE` 表达式来构造条件查询。