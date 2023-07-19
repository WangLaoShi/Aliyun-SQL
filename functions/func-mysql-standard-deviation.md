在本教程中，您将学习如何使用MySQL标准偏差函数来计算填充标准偏差和样本标准偏差。

## 标准差介绍

标准差是衡量数据集中值的分布情况，标准偏差显示平均值(平均值)存在多少变化。

低标准偏差表明数据集中的值接近于平均值。 而高标准偏差表示数据集的值在大范围的值上分散。

标准偏差是方差的平方根，可以通过以下步骤计算：

* _步骤1_ - 计算数据集中所有值的平均值以获得平均值或平均值，例如，假设数据集由`1`,`2`和`3`组成，平均值为`(1 + 2 + 3)/ 3 = 2`。

* _步骤2_ - 计算值与每个值的平均值的差，并且对每个值的每个的结果进行平方，也就是：
  
$$
(1-2)^2=(-1)^2=1,(2-2)^2=(0)^2=0,(3-2)^2=(1)^2=1 .
$$


* _步骤3_ - 计算_步骤2_中产生方差的平均值。然后取方差的平方根以获得数据集中所有值的标准偏差，例如`((1 + 0 + 1)/ 3)`的平方根 = `0.816497` 。

**总体标准差与样本标准偏差**

如果数据集中的所有值都被纳入计算，则该标准偏差称为总体标准偏差。 然而，如果将一个子集的值或一个样本作为计算，则该标准偏差称为样本标准偏差。

西格玛字母(`σ`)表示标准偏差。以下等式说明如何计算总体标准偏差和样本标准差：

总体标准偏差：

$$
\sigma=\sqrt{\frac{1}{N} \sum_{i=1}^N\left(x_i-\mu\right)^2}
$$


样品标准偏差：

$$
s=\sqrt{\frac{1}{N-1} \sum_{i=1}^N\left(x_i-\bar{x}\right)^2}
$$


总体标准差和样本标准差的计算略有不同。当计算样本标准偏差的方差时，除以`N-1`而不是`N`，其中`N`是数据集中的值的数量。

## MySQL标准偏差函数

MySQL可以方便您计算总体标准偏差和样本标准偏差。

要计算总体标准偏差，请使用以下功能之一：

* `STD(expression)` - 返回表达式的总体标准偏差。如果没有匹配的行，则`STD`函数返回`NULL`。
* `STDDEV(expression)` – 相当于`STD`函数，仅提供与Oracle数据库兼容。
* `STDEV_POP(expression)` - 相当于`STD`函数。

要计算样本标准差，请使用`STDDEV_SAMP(expression)`函数。

MySQL还为总体偏差和样本方差计算提供了一些函数：

* `VAR_POP(expression)` – 计算表达式的总体标准差。
* `VARIANCE(expression)` – 相当于`VAR_POP`函数。
* `VAR_SAMP(expression)` – 计算表达式的样本标准差。

## MySQL标准偏差函数的例子

我们来看看示例数据库(yiibaidb)中的`orders`表，其表结构如下所示 - 

```sql
mysql> desc orders;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| orderNumber    | int(11)     | NO   | PRI | NULL    |       |
| orderDate      | date        | NO   |     | NULL    |       |
| requiredDate   | date        | NO   |     | NULL    |       |
| shippedDate    | date        | YES  |     | NULL    |       |
| status         | varchar(15) | NO   |     | NULL    |       |
| comments       | text        | YES  |     | NULL    |       |
| customerNumber | int(11)     | NO   | MUL | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
7 rows in set
```

### 总体标准偏差函数的例子

_首先_，以下查询从`orders`表中返回客户编号及其订单数：

```sql
SELECT customerNumber, 
       COUNT(*) orderCount
FROM orders
WHERE status = 'Shipped'
GROUP BY customerNumber;
```

执行上面查询语句，得到以下结果 - 

```sql
+----------------+------------+
| customerNumber | orderCount |
+----------------+------------+
|            103 |          3 |
|            112 |          3 |
|            114 |          5 |
|            119 |          3 |
|            121 |          4 |
|            124 |         16 |
***** 此处省略了一大波数据 *****
|            489 |          2 |
|            495 |          2 |
|            496 |          3 |
+----------------+------------+
98 rows in set
```

_第二步_，以下陈述计算客户订单数量的总体标准差：

```sql
SELECT FORMAT(STD(orderCount),2)
FROM (SELECT customerNumber, count(*) orderCount
FROM orders
GROUP BY customerNumber) t;
```

执行上面查询语句，得到以下结果 - 

```sql
+---------------------------+
| FORMAT(STD(orderCount),2) |
+---------------------------+
| 2.84                      |
+---------------------------+
1 row in set
```

请注意，FORMAT函数用于格式化`STD`函数的结果。

**样本标准偏差函数的示例**

假设您只想在`orders`表中仅仅想要计算那些已发货的订单。

_首先_，以下查询返回客户编号及其发货订单编号：

```sql
SELECT customerNumber, count(*) orderCount
FROM orders
WHERE status = 'Shipped'
GROUP BY customerNumber;
```

_第二_，以下查询使用`STDDEV_SAMP`函数计算样本标准偏差：

```sql
SELECT FORMAT(STDDEV_SAMP(orderCount),2)
FROM (SELECT customerNumber, count(*) orderCount
FROM orders
WHERE status = 'Shipped'
GROUP BY customerNumber) t;
```

执行上面查询语句，得到以下结果 - 

```sql
+-----------------------------------+
| FORMAT(STDDEV_SAMP(orderCount),2) |
+-----------------------------------+
| 2.48                              |
+-----------------------------------+
1 row in set
```

在本教程中，我们向您介绍了标准偏差。 然后，向您展示了如何使用MySQL标准偏差函数来计算表达式的总体标准偏差和样本标准偏差。
