在本教程中，我们将向您展示如何使用 MySQL `TRIM()` 函数从字符串中删除不必要的前导和后缀字符。

## MySQL TRIM 函数介绍

用户输入的数据通常不是我们所预期的。有时候，它的格式不正确，例如错误的情况，甚至有些甚至包含前导和尾随空格以及其他不需要的字符。

为了保持数据格式正确，在数据库中插入或更新数据之前，需要对其进行清理。 数据清理中最重要的任务之一是删除不必要的前导和尾随字符。

MySQL 提供了一个非常有用的名称为 `TRIM()` 的字符串函数，以帮助您清理数据。下面说明了 `TRIM()` 函数的语法。

```sql
TRIM([{BOTH|LEADING|TRAILING} [removed_str]] FROM str);
```

## TRIM 函数提供了许多选项

您可以使用 `LEADING`，`TRAILING` 或 `BOTH` 选项明确指示 `TRIM()` 函数从字符串中删除前导，尾随或前导和尾随的不必要的字符。

如果您没有指定任何内容，`TRIM()` 函数默认使用 `BOTH` 选项。

`[removed_str]` 是要删除的字符串。默认情况下，它是一个空格。这意味着如果不指定特定的字符串，则 `TRIM()` 函数仅删除空格。

`str` 是要删除子字符 `removed_str` 的字符串。

`TRIM()` 函数返回一个字符串，删除不需要的字符。

## MySQL TRIM 函数示例

以下语句从字符串中除去前导和尾随空格。

```sql
mysql> SELECT TRIM('MySQL TRIM Function');
+-------------------------------+
| TRIM('MySQL TRIM Function') |
+-------------------------------+
| MySQL TRIM Function           |
+-------------------------------+
1 row in set
```

以下语句仅删除前导空格 -

```sql
mysql> SELECT TRIM(LEADING FROM 'MySQL TRIM Function');
+-------------------------------------------------+
| TRIM(LEADING FROM 'MySQL TRIM Function') |
+-------------------------------------------------+
| MySQL TRIM Function                             |
+-------------------------------------------------+
1 row in set
```

以下语句仅删除尾随空格 - 

```sql
mysql> SELECT TRIM(TRAILING FROM 'MySQL TRIM Function');
+--------------------------------------------------+
| TRIM(TRAILING FROM 'MySQL TRIM Function') |
+--------------------------------------------------+
|     MySQL TRIM Function                          |
+--------------------------------------------------+
1 row in set
```

以下语句删除字符串末尾的换行符 - 

```sql
-- 方式一
SELECT 
    TRIM(TRAILING '\n' FROM field_name)
FROM table_name;

-- 方式二
SELECT 
    TRIM(TRAILING '\r' FROM field_name)
FROM table_name;

-- 方式三
SELECT 
    TRIM(TRAILING '\r\n' FROM field_name)
FROM table_name;
```

请注意，基于平台，新行可以是 `\n`(Unix 或 Linux)，`\r`(Mac)或两者(`\r\n`)。

如果数据已经存在，并且要清理空格或任何其他不需要的字符，则可以在 UPDATE 语句中使用 `TRIM()` 函数。

我们将在示例数据库 (yiibaidb) 中的 `products` 表中进行演示，如下所示 - 

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

以下语句将删除 `products` 表中产品名称的所有空格并更新，如下查询语句 - 

```sql
UPDATE products 
SET 
    productname = TRIM(productname);
```

请注意，`TRIM` 函数仅从字符串中删除不需要的前导和 / 或后缀字符。如果要删除字符串中间不需要的字符，则应使用 [REPLACE](http://www.mysqltutorial.org/mysql-string-replace-function.aspx "REPLACE") 函数。

## MySQL LTRIM 和 RTRIM 函数

如果要仅删除前导或尾随空格，则可以使用其他字符串函数：`LTRIM` 和 `RTRIM`。

以下语句使用 `LTRIM` 函数来删除字符串的前导空格。

```sql
SELECT LTRIM('MySQL LTRIM function');
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SELECT LTRIM('MySQL LTRIM function');
+---------------------------------+
| LTRIM('MySQL LTRIM function') |
+---------------------------------+
| MySQL LTRIM function            |
+---------------------------------+
1 row in set
```

以下语句使用 `RTRIM()` 函数来删除字符串的尾随空格。

```sql
SELECT RTRIM('MySQL RTRIM function');
```

执行上面查询语句，得到以下结果 - 

```
mysql> SELECT RTRIM('MySQL RTRIM function');
+----------------------------------+
| RTRIM('MySQL RTRIM function') |
+----------------------------------+
| MySQL RTRIM function             |
+----------------------------------+
1 row in set
```

在本教程中，您已经学习了如何使用 `TRIM()` 函数从字符串中删除不需要的前导和后缀字符。