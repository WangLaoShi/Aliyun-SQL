在本教程中，您将学习如何使用MySQL `LEFT`函数返回指定长度的字符串的左侧部分。

## MySQL LEFT函数介绍

`LEFT()`函数是一个字符串函数，它返回具有指定长度的字符串的左边部分。

下面是`LEFT()`函数的语法 - 

```sql
LEFT(str,length);
```

`LEFT()`函数接受两个参数：

* `str`是要提取子字符串的字符串。
* `length`是一个正整数，指定将从左边返回的字符数。

`LEFT()`函数返回`str`字符串中最左边的长度字符。如果`str`或`length`参数为`NULL`，则返回`NULL`值。

如果`length`为`0`或为负，则`LEFT`函数返回一个空字符串。如果`length`大于`str`字符串的长度，则`LEFT`函数返回整个`str`字符串。

请注意，SUBSTRING(或SUBSTR)函数也提供与`LEFT`函数相同的功能。

```sql
SELECT LEFT('MySQL LEFT', 5);
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT LEFT('MySQL LEFT', 5);
+-----------------------+
| LEFT('MySQL LEFT', 5) |
+-----------------------+
| MySQL                 |
+-----------------------+
1 row in set
```

以下语句返回整个字符串，因为长度超过了字符串的长度。

```sql
mysql> SELECT LEFT('MySQL LEFT', 1000);
+--------------------------+
| LEFT('MySQL LEFT', 1000) |
+--------------------------+
| MySQL LEFT               |
+--------------------------+
1 row in set
```

以下语句返回一个空字符串，因为长度为`0`或为负。

```sql
mysql> SELECT LEFT('MySQL LEFT', 0);
SELECT LEFT('MySQL LEFT', -2);
+-----------------------+
| LEFT('MySQL LEFT', 0) |
+-----------------------+
|                       |
+-----------------------+
1 row in set

+------------------------+
| LEFT('MySQL LEFT', -2) |
+------------------------+
|                        |
+------------------------+
1 row in set
```

以下语句返回`NULL`值，因为长度为`NULL` - 

```sql
mysql> SELECT LEFT('MySQL LEFT', NULL);
+--------------------------+
| LEFT('MySQL LEFT', NULL) |
+--------------------------+
| NULL                     |
+--------------------------+
1 row in set
```

### 使用MySQL LEFT函数与列示例

我们来看看示例数据库(yiibaidb)中的`products`表，其表结构如下 - 

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

假设要在目录上显示产品名称和产品描述。因为产品描述很长，因此，只需要前`50`个字符来进行显示。

以下语句使用`LEFT`函数返回产品描述的前`50`个字符，如下查询语句  -

```sql
SELECT 
    productname, LEFT(productDescription, 50) summary
FROM
    products;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------------------------+------------------------------------------------------+
| productname                                 | summary                                              |
+---------------------------------------------+------------------------------------------------------+
| 1969 Harley Davidson Ultimate Chopper       | This replica features working kickstand, front sus   |
| 1952 Alpine Renault 1300                    | Turnable front wheels; steering function; detailed   |
| 1996 Moto Guzzi 1100i                       | Official Moto Guzzi logos and insignias, saddle ba   |
| 2003 Harley-Davidson Eagle Drag Bike        | Model features, official Harley Davidson logos and   |
**************** 此处省略一大波数据 ************************************
| The Titanic                                 | Completed model measures 19 1/2 inches long, 9 inc   |
| The Queen Mary                              | Exact replica. Wood and Metal. Many extras includi   |
| American Airlines: MD-11S                   | Polished finish. Exact replia with official logos    |
| Boeing X-32A JSF                            | 10" Wingspan with retractable landing gears.Comes    |
| Pont Yacht                                  | Measures 38 inches Long x 33 3/4 inches High. Incl   |
+---------------------------------------------+------------------------------------------------------+
110 rows in set
```

`LEFT`函数返回前`50`个字符，它不关心词组。

如果想获得前`50`个字符，而不用将词组从中间的切断。要实现此目的，请使用以下步骤：

(1). 取`productDescription`列左侧的`50`个字符。

```sql
SELECT 
    LEFT(productdescription, 50)
FROM
    products;
```

(2). 使用`REVERSE`函数反转子串。

```sql
SELECT 
    REVERSE(LEFT(productdescription, 50))
FROM
    products;
```

(3). 使用`LOCATE`函数获取反向子串中的第一个空格的位置。

```sql
SELECT 
    LOCATE(' ',REVERSE(LEFT(productdescription, 50))) first_space_pos
FROM
    products;
```

(4). 从位置减`1` 。 如果找不到任何空格，则保持位置为`0`。

```sql
SELECT
    IFNULL(NULLIF(LOCATE(' ', REVERSE(LEFT(productDescription, 50))), 0) - 1, 0)
FROM
    products;
```

(5). 从`50`减去位置，得到了一个新位置，把它称为`last_space_pos` 。

```sql
SELECT
 productDescription,
 (50 - IFNULL(NULLIF(LOCATE(' ', REVERSE(LEFT(productDescription, 50))), 0) - 1, 0)) last_space_pos
FROM
    products;
```

(6). 取最后一个`last_space_pos`字符的产品描述。

```sql
SELECT 
    productDescription, LEFT(productDescription, last_space_pos)
FROM
    (SELECT 
        productDescription,
            (50 - IFNULL(NULLIF(LOCATE(' ', REVERSE(LEFT(productDescription, 50))), 0) - 1, 0)) last_space_pos
    FROM
        products) AS t;
```

执行上面代码，得到以下结果 - 

![bp8YMP](https://oss.images.shujudaka.com/uPic/bp8YMP.jpg)

在本教程中，您已经学习了如何使用`LEFT`函数返回具有指定长度的字符串的左侧部分。