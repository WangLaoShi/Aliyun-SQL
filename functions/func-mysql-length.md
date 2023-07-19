在本教程中，您将了解MySQL字符串长度函数，使您可以以字节为单位获取字符串的长度。

MySQL支持各种字符集，如`latin1`，`utf8`等。可以使用`SHOW CHARACTER SET`语句来获取MySQL数据库服务器支持的所有字符集。

```sql
mysql> SHOW CHARACTER SET;
+----------+---------------------------------+---------------------+--------+
| Charset  | Description                     | Default collation   | Maxlen |
+----------+---------------------------------+---------------------+--------+
| big5     | Big5 Traditional Chinese        | big5_chinese_ci     |      2 |
| dec8     | DEC West European               | dec8_swedish_ci     |      1 |
| cp850    | DOS West European               | cp850_general_ci    |      1 |
| hp8      | HP West European                | hp8_english_ci      |      1 |
| koi8r    | KOI8-R Relcom Russian           | koi8r_general_ci    |      1 |
| latin1   | cp1252 West European            | latin1_swedish_ci   |      1 |
| latin2   | ISO 8859-2 Central European     | latin2_general_ci   |      1 |
| swe7     | 7bit Swedish                    | swe7_swedish_ci     |      1 |
| ascii    | US ASCII                        | ascii_general_ci    |      1 |
| ujis     | EUC-JP Japanese                 | ujis_japanese_ci    |      3 |
| sjis     | Shift-JIS Japanese              | sjis_japanese_ci    |      2 |
| hebrew   | ISO 8859-8 Hebrew               | hebrew_general_ci   |      1 |
| tis620   | TIS620 Thai                     | tis620_thai_ci      |      1 |
| euckr    | EUC-KR Korean                   | euckr_korean_ci     |      2 |
| koi8u    | KOI8-U Ukrainian                | koi8u_general_ci    |      1 |
| gb2312   | GB2312 Simplified Chinese       | gb2312_chinese_ci   |      2 |
| greek    | ISO 8859-7 Greek                | greek_general_ci    |      1 |
| cp1250   | Windows Central European        | cp1250_general_ci   |      1 |
| gbk      | GBK Simplified Chinese          | gbk_chinese_ci      |      2 |
| latin5   | ISO 8859-9 Turkish              | latin5_turkish_ci   |      1 |
| armscii8 | ARMSCII-8 Armenian              | armscii8_general_ci |      1 |
| utf8     | UTF-8 Unicode                   | utf8_general_ci     |      3 |
| ucs2     | UCS-2 Unicode                   | ucs2_general_ci     |      2 |
| cp866    | DOS Russian                     | cp866_general_ci    |      1 |
| keybcs2  | DOS Kamenicky Czech-Slovak      | keybcs2_general_ci  |      1 |
| macce    | Mac Central European            | macce_general_ci    |      1 |
| macroman | Mac West European               | macroman_general_ci |      1 |
| cp852    | DOS Central European            | cp852_general_ci    |      1 |
| latin7   | ISO 8859-13 Baltic              | latin7_general_ci   |      1 |
| utf8mb4  | UTF-8 Unicode                   | utf8mb4_general_ci  |      4 |
| cp1251   | Windows Cyrillic                | cp1251_general_ci   |      1 |
| utf16    | UTF-16 Unicode                  | utf16_general_ci    |      4 |
| utf16le  | UTF-16LE Unicode                | utf16le_general_ci  |      4 |
| cp1256   | Windows Arabic                  | cp1256_general_ci   |      1 |
| cp1257   | Windows Baltic                  | cp1257_general_ci   |      1 |
| utf32    | UTF-32 Unicode                  | utf32_general_ci    |      4 |
| binary   | Binary pseudo charset           | binary              |      1 |
| geostd8  | GEOSTD8 Georgian                | geostd8_general_ci  |      1 |
| cp932    | SJIS for Windows Japanese       | cp932_japanese_ci   |      2 |
| eucjpms  | UJIS for Windows Japanese       | eucjpms_japanese_ci |      3 |
| gb18030  | China National Standard GB18030 | gb18030_chinese_ci  |      4 |
+----------+---------------------------------+---------------------+--------+
41 rows in set
```

`Maxlen`列存储字符集的字节数。在MySQL中，一个字符串可以是任何字符集。 如果一个字符串包含`1`个字节的字符，则其字符长度和以字节为单位测量的长度相等。 但是，如果字符串包含多字节字符，则其字节长度通常大于字符长度。

要获取以字节为单位的字符串长度，请使用`LENGTH`函数，如下所示：

```sql
LENGTH(str);
```

可以使用`CHAR_LENGTH`函数获取字符串的长度，以字符为单位计算长度，如下所示：

```sql
CHAR_LENGTH(str);
```

## LENGTH和CHAR_LENGTH函数的示例

我们来看看下面的内容：

```sql
mysql> SET @s = CONVERT('MySQL String Length' USING ucs2);
SELECT CHAR_LENGTH(@s), LENGTH(@s);
Query OK, 0 rows affected

+-----------------+------------+
| CHAR_LENGTH(@s) | LENGTH(@s) |
+-----------------+------------+
|              19 |         38 |
+-----------------+------------+
1 row in set
```

上面查询语句是如何工作的？

* _首先_，我们将MySQL字符串长度字符串转换为`ucs2`字符集，这是`UCS-2 Unicode`，指定一个字符存储为`2`个字节。
* _其次_，分别使用`CHAR_LENGTH`和`LENGTH`函数来获取`@s`字符串的长度(以字节为单位)。因为`@s`字符串以`2`个字节来存储每个字符，所以其字符长度为`19`，而字节长度为`38` 。

以下语句演示了`LENGTH`和`CHAR_LENGTH`函数如何使用`1`个字节来存储每个字符：

```sql
SET @s = CONVERT('MySQL string length' USING latin1);
SELECT LENGTH(@s), CHAR_LENGTH(@s);
```

执行上面查询语句，得到以下结果 - 

```sql
+------------+-----------------+
| LENGTH(@s) | CHAR_LENGTH(@s) |
+------------+-----------------+
|         19 |              19 |
+------------+-----------------+
1 row in set
```

我们使用`latin1`字符集来存储`@s`字符串。 `latin1`字符集是使用`1`个字节来存储每个字符的; 因此，其字节长度和字符长度相等。

请注意，某些字符集可以更改字符的存储字节数，例如，`utf8`字符集：

```sql
SET @s = CONVERT('MySQL String Length' USING utf8);
SELECT CHAR_LENGTH(@s), LENGTH(@s);
```

执行上面查询语句，得到以下结果 - 

```sql
mysql> SET @s = CONVERT('MySQL String Length' USING utf8);
SELECT CHAR_LENGTH(@s), LENGTH(@s);
Query OK, 0 rows affected

+-----------------+------------+
| CHAR_LENGTH(@s) | LENGTH(@s) |
+-----------------+------------+
|              19 |         19 |
+-----------------+------------+
1 row in set
```

`CHAR_LENGTH`和`LENGTH`返回相同的结果。 但是，如果一个字符串有特殊字符，结果是不同的。 请参阅以下示例：

```sql
mysql> SET @s = CONVERT('á' USING utf8);
SELECT CHAR_LENGTH(@s), LENGTH(@s);
Query OK, 0 rows affected

+-----------------+------------+
| CHAR_LENGTH(@s) | LENGTH(@s) |
+-----------------+------------+
|               1 |          2 |
+-----------------+------------+
1 row in set
```

中文字符串存储多少位？看看下面查询就知道了 - 

```sql
mysql> SET @s = CONVERT('易百教程' USING utf8);
SELECT CHAR_LENGTH(@s), LENGTH(@s);
Query OK, 0 rows affected

+-----------------+------------+
| CHAR_LENGTH(@s) | LENGTH(@s) |
+-----------------+------------+
|               4 |         12 |
+-----------------+------------+
1 row in set
```

## 一个应用程序的MySQL字符串长度函数

假设我们有一个`posts`表，用于存储具有四列：`postid`, `title`, `excerpt` 和 `content`(为了演示目的，所以`posts`表尽可能简单)。

首先，我们使用CREATE TABLE语句创建`posts`表：

```sql
USE testdb;
CREATE TABLE posts(
  postid int auto_increment primary key,
  title varchar(255) NOT NULL,
  excerpt varchar(255) NOT NULL,
  content text,
  pubdate datetime
)Engine=InnoDB;
```

SQL

_其次_，通过使用INSERT语句将一些博客帖子插入到`posts`表中：

```sql
INSERT INTO posts(title,excerpt,content)
VALUES('MySQL Length','MySQL string length function tutorial','dummy'),
      ('Second blog post','Second blog post','dummy');
```

我们可以使用`CHAR_LENGTH`函数来检查是否有超过`20`个字符，如果超过了，则附加省略号(`...`)，如下查询语句：

```sql
SELECT postid,
       title,
       IF(CHAR_LENGTH(excerpt) > 20,
          CONCAT(LEFT(excerpt,20), '...'),
          excerpt) summary
FROM posts;
```

执行上面查询语句，得到以下结果 - 

```sql
+--------+------------------+-------------------------+
| postid | title            | summary                 |
+--------+------------------+-------------------------+
|      1 | MySQL Length     | MySQL string length ... |
|      2 | Second blog post | Second blog post        |
+--------+------------------+-------------------------+
2 rows in set
```

在SELECT语句中，我们使用`IF`函数来检查摘录列的长度是否大于`20`，并使用CONCAT语句将`excerpt`列的值与省略号(`...`)连接起来，否则只是获取全部摘录(`excerpt`)内容。

在本教程中，我们向您展示了如何使用MySQL字符串长度函数来获取字符串的长度(以字节为单位)。