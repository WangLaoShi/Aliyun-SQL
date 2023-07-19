在本教程中，您将学习使用 MySQL `CONCAT` 和 `CONCAT_WS` 函数将两个或多个字符串连接在一起的各种方法。

要连接两个或多个引用的字符串值，请将字符串放在一起，如下所示：

```sql
SELECT 'MySQL' 'String' 'Concatenation';
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT 'MySQL' 'String' 'Concatenation';
+----------------------------+
| MySQL                      |
+----------------------------+
| MySQL String Concatenation |
+----------------------------+
1 row in set
```

与其他数据库管理系统相比，MySQL 字符串连接更为清晰。 例如，如果您使用 PostgreSQL 或 Oracle，则必须使用字符串连接运算符 `||`。 在 Microsoft SQL Server 中，您可以使用加法算术运算符 (`+`) 连接字符串值。

除了使用空格进行字符串连接之外，MySQL 还提供了两个连接字符串值的函数：`CONCAT` 和 `CONCAT_WS`。

## MySQL CONCAT 函数

MySQL `CONCAT()` 函数需要一个或多个字符串参数，并将它们连接成一个字符串。`CONCAT()` 函数需要至少一个参数，否则会引起错误。

下面说明了 `CONCAT()` 函数的语法。

```sql
CONCAT(string1,string2, ...);
```

`CONCAT()` 函数在连接之前将所有参数转换为字符串类型。如果任何参数为 `NULL`，则 `CONCAT()` 函数返回 `NULL` 值。

以下语句连接两个引用的字符串：`MySQL` 和 `CONCAT`。

```sql
SELECT CONCAT('MySQL','CONCAT');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT CONCAT('MySQL','CONCAT');
+--------------------------+
| CONCAT('MySQL','CONCAT') |
+--------------------------+
| MySQLCONCAT              |
+--------------------------+
1 row in set
```

如果添加 `NULL` 值，则 `CONCAT` 函数将返回一个 `NULL` 值，如下所示：

```sql
mysql> SELECT CONCAT('MySQL',NULL,'CONCAT');
+-------------------------------+
| CONCAT('MySQL',NULL,'CONCAT') |
+-------------------------------+
| NULL                          |
+-------------------------------+
1 row in set
```

请参见示例数据库 (yiibaidb) 中的 `customers` 表，其结构如下所示 - 

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

要获取联系人的全名，您可以使用 `CONCAT` 函数将名字，空格，姓氏连接，如下查询语句：

```sql
SELECT 
    concat(contactFirstName,' ',contactLastName) Fullname
FROM
    customers;
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT 
    concat(contactFirstName,' ',contactLastName) Fullname
FROM
    customers;
+--------------------------+
| Fullname                 |
+--------------------------+
| Carine  Schmitt          |
| Jean King                |
| Peter Ferguson           |
| Janine  Labrune          |
| Jonas  Bergulfsen        |
***** 此处省略了一大波数据 ****
| Sue Taylor               |
| Thomas  Minsu            |
| Valarie Franco           |
| Tony Snowden             |
+--------------------------+
122 rows in set
```

## MySQL CONCAT_WS 函数：使用分隔符连接字符串

MySQL 提供了一种特殊形式的 `CONCAT()` 函数：`CONCAT_WS()` 函数。`CONCAT_WS()` 函数将两个或多个字符串值与预定义的分隔符相连接。

下面说明了 `CONCAT_WS()` 函数的语法：

```sql
CONCAT_WS(seperator,string1,string2, ...);
```

第一个参数是其他参数：`string1`，`string2`，`...` 的分隔符。

`CONCAT_WS` 函数在字符串参数之间添加分隔符，并返回单个字符串，并在字符串参数之间插入分隔符。

以下语句连接两个字符串值：`Max` 和 `Su`，并用逗号分隔这两个字符串：

```sql
SELECT CONCAT_WS(',','Max','Su');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT CONCAT_WS(',','Max','Su');
+---------------------------+
| CONCAT_WS(',','Max','Su') |
+---------------------------+
| Max,Su                    |
+---------------------------+
1 row in set
```

当且仅当作为分隔符的第一个参数为 `NULL` 时，`CONCAT_WS` 函数才返回 `NULL`。请参阅以下示例：

```sql
mysql> SELECT CONCAT_WS(NULL ,'Jonathan', 'Minsu');
+--------------------------------------+
| CONCAT_WS(NULL ,'Jonathan', 'Minsu') |
+--------------------------------------+
| NULL                                 |
+--------------------------------------+
1 row in set
```

与 `CONCAT` 函数不同，`CONCAT_WS` 函数在分隔符参数之后跳过 `NULL` 值。 换句话说，它忽略 `NULL` 值。

```sql
mysql> SELECT CONCAT_WS(',','Jonathan', 'Minsu',NULL);
+-----------------------------------------+
| CONCAT_WS(',','Jonathan', 'Minsu',NULL) |
+-----------------------------------------+
| Jonathan,Minsu                          |
+-----------------------------------------+
1 row in set
```

以下语句使用 `CONCAT_WS` 函数构造完整的地址：

```sql
SELECT 
    CONCAT_WS(CHAR(13),
            CONCAT_WS(' ', contactLastname, contactFirstname),
            addressLine1,
            addressLine2,
            CONCAT_WS(' ', postalCode, city),
            country,
            CONCAT_WS(CHAR(13), '')) AS Customer_Address
FROM
    customers;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------------------------------------------------------------------------+
| Customer_Address                                                                 |
+----------------------------------------------------------------------------------+
| Schmitt Carine 
54, rue Royale
44000 Nantes
France |
************ 此处省略一大波数据 *******
```

在本教程中，您已经学习了如何使用 MySQL `CONCAT` 和 `CONCAT_WS` 函数将一个或多个字符串值连接到成单个字符串。