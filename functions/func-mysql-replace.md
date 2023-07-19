在本教程中，我们将向您展示如何使用MySQL字符串`REPLACE()`函数在字符串中替换另一个子字符串。

## MySQL REPLACE字符串函数简介

MySQL为您提供了一个有用的字符串函数`REPLACE()`，它允许您用新的字符串替换表的列中的字符串。

`REPLACE()`函数的语法如下：

```sql
REPLACE(str,old_string,new_string);
```

`REPLACE()`函数有三个参数，它将`string`中的`old_string`替换为`new_string`字符串。

> 注意: 有一个也叫作REPLACE的语句用于插入或更新数据。所以不要将`REPLACE`语句与这里的`REPLACE`字符串函数混淆。

`REPLACE()`函数非常方便搜索和替换表中的文本，例如更新过时的URL，纠正拼写错误等。

在UPDATE语句中使用`REPLACE`函数的语法如下：

```sql
UPDATE tbl_name 
SET 
    field_name = REPLACE(field_name,
        string_to_find,
        string_to_replace)
WHERE
    conditions;
```

请注意，当搜索要替换的文本时，MySQL使用区分大小写匹配来执行要替换的字符串的搜索。

## MySQL REPLACE字符串函数示例

例如，如果要更正示例数据库(yiibaidb)中的`products`表中的拼写错误，请使用`REPLACE`函数，如下所示：

```sql
UPDATE products 
SET 
    productDescription = REPLACE(productDescription,
        'abuot',
        'about');
```

查询查找所有出现的拼写错误词：`abuot`，并通过`products`表的`productDescription`列中使用正确单词将其替换。

非常重要的是，在`REPLACE`函数中，第一个参数是不带引号(`"`)的列名。 如果将引号括起来，就像`"field_name"`这样的字段名称，查询将会将该列的内容更新为`"field_name"`，导致意外的数据丢失。

`REPLACE`函数不支持正则表达式，因此如果需要使用外部库中需要使用MySQL用户定义函数(`UDF`)的模式替换文本字符串，有关`MySQL UDF`请查看这里： http://launchpad.net/mysql/udf-regexp