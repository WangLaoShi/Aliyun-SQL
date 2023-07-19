在本教程中，您将学习如何使用MySQL `FIND_IN_SET()`函数返回指定字符串在以逗号分隔的字符串列表中的位置。

## MySQL FIND_IN_SET函数简介

MySQL提供了一个名为`FIND_IN_SET()`的内置字符串函数，允许您在逗号分隔的字符串列表中查找指定字符串的位置。

下面说明了`FIND_IN_SET()`函数的语法。

```sql
FIND_IN_SET(needle,haystack);
```

`FIND_IN_SET()`函数接受两个参数：

* 第一个参数`needle`是要查找的字符串。
* 第二个参数`haystack`是要搜索的逗号分隔的字符串列表。

`FIND_IN_SET()`函数根据参数的值返回一个整数或一个`NULL`值：

* 如果`needle`或`haystack`为`NULL`，则函数返回`NULL`值。
* 如果`needle`不在`haystack`中，或者`haystack`是空字符串，则返回零。
* 如果`needle`在`haystack`中，则返回一个正整数。

请注意，如果`needle`包含逗号(`，`)，该函数将无法正常工作。 此外，如果`needle`是一个常量字符串，而且`haystack`是一个类型为`SET`的列，MySQL将使用位算术优化。

## MySQL FIND_IN_SET示例

下面让我们举一些例子来了解和学习MySQL `FIND_IN_SET`的工作原理。

**MySQL FIND_IN_SET：简单的例子**

以下语句返回`2`，因为字符`'y'`是`'x，y，z'`字符串中的第二个位置。

```sql
mysql> SELECT FIND_IN_SET('y','x,y,z');
+--------------------------+
| FIND_IN_SET('y','x,y,z') |
+--------------------------+
|                        2 |
+--------------------------+
1 row in set
```

以下语句返回`0`，因为`'a'`不在`'x，y，z'`字符串列表中。

```sql
mysql> SELECT FIND_IN_SET('a','x,y,z');
+--------------------------+
| FIND_IN_SET('a','x,y,z') |
+--------------------------+
|                        0 |
+--------------------------+
1 row in set
```

以下语句也返回`0`，因为第二个参数是一个空字符串。

```sql
mysql> SELECT FIND_IN_SET('a','');
+---------------------+
| FIND_IN_SET('a','') |
+---------------------+
|                   0 |
+---------------------+
1 row in set
```

以下语句返回`NULL`，因为第一个参数为`NULL`。

```sql
SELECT FIND_IN_SET(NULL,'x,y,z');
```

以下语句也返回`NULL`，因为第二个参数为`NULL`。

```sql
mysql> SELECT FIND_IN_SET('a',NULL);
+-----------------------+
| FIND_IN_SET('a',NULL) |
+-----------------------+
| NULL                  |
+-----------------------+
1 row in set
```

**MySQL FIND_IN_SET：从表查询数据示例** 

为了演示目的，这里将创建一个名为`divisions`的新表。

_首先_，使用以下语句创建`divisions`表  -

```sql
USE testdb;
CREATE TABLE IF NOT EXISTS divisions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    belts VARCHAR(200) NOT NULL
);
```

_其次_，将几行数据插入到`divisions`表。

```sql
INSERT INTO divisions(name,belts)
VALUES ('O-1','white,yellow,orange'),
 ('O-2','purple,green,blue'),
 ('O-3','brown,red,black'),
 ('O-4','white,yellow,orange'),
 ('O-5','purple,green,blue'),
 ('O-6','brown,red'),
 ('O-7','black'),
 ('O-8','white,yellow,orange'),
 ('O-9','purple,green,blue'),
 ('O-10','brown,red');
```

_第三_，要井底接受`red`皮带的部门，可以使用`FIND_IN_SET`函数，如下所示：

```sql
SELECT 
    name, belts
FROM
    divisions
WHERE
    FIND_IN_SET('red', belts);
```

执行上面查询语句，得到以下结果 - 

```sql
+------+-----------------+
| name | belts           |
+------+-----------------+
| O-3  | brown,red,black |
| O-6  | brown,red       |
| O-10 | brown,red       |
+------+-----------------+
3 rows in set
```

**MySQL NOT FIND_IN_SET示例**

因为`FIND_IN_SET()`函数在第二个参数中找不到第一个参数时返回`0`。 因此，您可以使用`NOT`运算符来否定`FIND_IN_SET()`函数返回的结果值。

例如，要找到不接受黑(`black`)皮带的部门，请使用以下语句：

```sql
SELECT 
    name, belts
FROM
    divisions
WHERE
    NOT FIND_IN_SET('black', belts);
```

执行上面语句，得到以下结果 - 

```sql
+------+---------------------+
| name | belts               |
+------+---------------------+
| O-1  | white,yellow,orange |
| O-2  | purple,green,blue   |
| O-4  | white,yellow,orange |
| O-5  | purple,green,blue   |
| O-6  | brown,red           |
| O-8  | white,yellow,orange |
| O-9  | purple,green,blue   |
| O-10 | brown,red           |
+------+---------------------+
8 rows in set
```

**MySQL FIND_IN_SET函数与IN运算符**

IN运算符确定值是否匹配指定值列表。 例如，要查找名称为`O-1`或`O-2`的部门，请按如下所示使用`IN`运算符。

```sql
SELECT 
    name, belts
FROM
    divisions
WHERE
    name IN ('O-1' , 'O-2');
```

执行上面查询语句，得到以下结果 - 

```sql
+------+---------------------+
| name | belts               |
+------+---------------------+
| O-1  | white,yellow,orange |
| O-2  | purple,green,blue   |
+------+---------------------+
2 rows in set
```

可以使用`FIND_IN_SET`函数获得与上面查询相同的结果：

```sql
SELECT 
    name, belts
FROM
    divisions
WHERE
    FIND_IN_SET(name, 'O-1,O-2');
```

因此，`column IN (x, y, z)`表达式与`FIND_IN_SET(column, 'x,y,z')`相同。

`IN`运算符可以接受任意数量的参数，每个参数用逗号分隔。 但是，`FIND_IN_SET`函数只有两个参数。

当您希望将值与数据库中的值列表进行匹配时，可以使用`IN`运算符。 并且当希望将值与数据库中以逗号分隔存储的值列表进行匹配时，可以使用`FIND_IN_SET`函数。

在本教程中，您已经学习了如何使用`FIND_IN_SET`函数查找在以逗号分隔的字符串列表中的某个字符串。