在本教程中，我们将向您介绍MySQL `SUBSTRING`函数从字符串中提取子字符串。

`SUBSTRING`函数从特定位置开始的字符串返回一个给定长度的子字符串。 MySQL提供了各种形式的子串功能。

我们将在以下部分中检查`SUBSTRING`函数的每种形式。

```sql
SUBSTRING(string,position);
SUBSTRING(string FROM position);
```

有两个参数：

* `string`参数是要提取子字符串的字符串。
* `position`参数是一个整数，用于指定子串的起始字符，`position`可以是正或负整数。

如果`position`为正，则`SUBSTRING`函数从字符串的开始处提取子字符串。请参阅以下字符串。

![fx1U87](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/fx1U87.jpg)

例如，要从“`MySQL SUBSTRING`”字符串中获取子字符串：“`SUBSTRING`”，子串的位置必须从`7`开始，如以下SELECT语句：

```sql
mysql> SELECT SUBSTRING('MYSQL SUBSTRING', 7);
+---------------------------------+
| SUBSTRING('MYSQL SUBSTRING', 7) |
+---------------------------------+
| SUBSTRING                       |
+---------------------------------+
1 row in set
```

请注意，如果`position`参数为零，则`SUBSTRING`函数返回一个空字符串：

```sql
mysql> SELECT SUBSTRING('MYSQL SUBSTRING', 0);
+---------------------------------+
| SUBSTRING('MYSQL SUBSTRING', 0) |
+---------------------------------+
|                                 |
+---------------------------------+
1 row in set
```

除了特定于MySQL的语法之外，可以使用SQL标准语法与`FROM`关键字一起调用`SUBSTRING`函数。

例如，以下语句使用SQL标准语法从`"MySQL SUBSTRING"`字符串中获取`"SUBSTRING"`：

```sql
mysql> SELECT SUBSTRING('MySQL SUBSTRING' FROM -10);
+---------------------------------------+
| SUBSTRING('MySQL SUBSTRING' FROM -10) |
+---------------------------------------+
|  SUBSTRING                            |
+---------------------------------------+
1 row in set
```

### MySQL SUBSTRING具有位置和长度

如果要指定要从字符串中提取的子字符串的长度，可以使用以下形式的`SUBSTRING`函数：

```sql
SUBSTRING(string,position,length);
```

以下是上述语句的SQL标准版本，它更长，但更具表现力。

```sql
SUBSTRING(string FROM position FOR length);
```

除了`string`和`position`参数之外，`SUBSTRING`函数还有一个额外的`length`参数。`length`是一个正整数，用于指定子字符串的字符数。

如果`position`和`length`的总和大于字符串的字符数，则`SUBSTRING`函数将返回一个从位置开始到字符串末尾的子串。

例如，要从`"MySQL SUBSTRING"`获取`"MySQL"`，请使用以下语句：

![ZGZwYF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/ZGZwYF.jpg)

```sql
mysql> SELECT SUBSTRING('MySQL SUBSTRING',1,5);
+----------------------------------+
| SUBSTRING('MySQL SUBSTRING',1,5) |
+----------------------------------+
| MySQL                            |
+----------------------------------+
1 row in set
```

又或者 - 

```sql
mysql> SELECT SUBSTRING('MySQL SUBSTRING' FROM 1 FOR 5);
+-------------------------------------------+
| SUBSTRING('MySQL SUBSTRING' FROM 1 FOR 5) |
+-------------------------------------------+
| MySQL                                     |
+-------------------------------------------+
1 row in set
```

或者使用`FROM FOR`语法：

```sql
mysql> SELECT SUBSTRING('MySQL SUBSTRING' FROM -15 FOR 5);
+---------------------------------------------+
| SUBSTRING('MySQL SUBSTRING' FROM -15 FOR 5) |
+---------------------------------------------+
| MySQL                                       |
+---------------------------------------------+
1 row in set
```

`SUBSTR()`函数是`SUBSTRING()`函数的同义词，所以可以互换使用它们。

在本教程中，您已经了解了和使用`SUBSTRING()`函数从指定位置开始的字符串中提取具有给定长度的子字符串。