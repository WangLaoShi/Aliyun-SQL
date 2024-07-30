数据库中我们做常用的就是SQL基本查询语言，甚至有些人认为数据库就是SQL，SQL就是数据库。虽然这种观点是错误的，但是也确实从一个方面体现了这种面向结果的查询语言的重要性。

## SQL语言基本定义

---

#### 基本类型

SQL表中支持很多固有类型，包括：

类型                     | 含义                                              
---------------------- | ------------------------------------------------
char(n)                | 存放固定长度的字符串，用户指定长度为n。如果没有使用n个长度则会在末尾添加空格。        
varchar(n)             | 可变长度的字符串，用户指定最大长度n。char的改进版，大多数情况下我们最好使用varchar。
int                    | 整数类型                                            
smallint               | 小整数类型                                           
numeric(p,d)           | 定点数，精度由用户指定。这个数有p位数字（包括一个符号位）d位在小数点右边。          
real ,double precision | 浮点数和双精度浮点数。                                     
float(n)               | 精度至少位n位的浮点数                                     

#### 特殊关键字

SQL中用很多关键字来表达CRUD的操作（增删改查）。在这之外有很多特殊的关键字用来表示一些其他的含义，在总结SQL之前我们有必要进行一些了解。

类型                     | 含义                         | 示例                                              
---------------------- | -------------------------- | ------------------------------------------------
primary key            | 主键,后面括号中是作为主键的属性           | **primary key**（student_id）                     
foreign key references | 外键，括号中为外键，references后为外键的表 | **foreign key**(course_id) **references** Course
not null               | 不为空，前面为属性的定义               | name varchar(10) **not null**                   

## SQL插入/删除/修改语句

---

SQL语法使用最多的就是查询，除了查找语句之外，其他的语句内容都很少。

类型                 | 含义                  
------------------ | --------------------
create table       | 创建一张表               
insert into…values | 向表中插入一条信息           
delete from        | 从表中删除一条信息           
update…set…where   | 在where的位置，更新内容为set的值
drop table         | 删除表                 
alter table…add    | 向表中添加某个属性           
alter table…drop   | 将表中的某个属性删除          

#### create table

```sql
create table Student(
ID varchar(20) not null,
name varchar(10) not null, 
age int,
class varchar(50),
primary key (ID));
```

创建一张叫做Student的表，表中有四个属性，ID，姓名，年龄和班级，么个属性都有各自的类型。在这张表中主键是ID。

####  insert into…values

```sql
insert into Student(ID,name,class)
    values(10152510302,"Tom","class 1");
```

向表中添加一行信息，一个名叫Tom的学生的信息，因为age值不是not null，也就不是必须的，所以我们不添加age属性也没有问题。

####  delete from

```sql
delete form Student
    where name="Tom";
```

从表中删除所有名字叫做Tom的信息。如果delete from不写where查询条件表示清空这张表。

####  update…set…where

```sql
update Student
   set age=18
   where name="Tom";
```

将所有名字叫做Tom的信息的年龄设置为18。

####  drop table

```sql
drop table Student;
```

删除Student这张表。

####  alter table…add

```sql
alter table Student
   add sex varchar(5);
```

向表中添加性别属性，并且将表中以存放的信息的sex值设为null。所有通过这种方式添加的属性都不能被设置为not null类型。

####  alter table…drop

```sql
alter table Student
   drop class;
```

从表中将class这一列属性删除。

## SQL查询语句

---

SQL最为常用的就是查询，我们使用数据库并从中查找出我们希望的内容。在这个过程中，我们可能要编写很复杂的语句。这里我们分类别详细的总结具体的查询情况。

###  单关系查询

单关系查询是指只一张表中的内容查询有关信息，不涉及其他的表，这是查询中最为基本的一种情况。我们通过这种情况来总结一些基本的[SQL语句](https://so.csdn.net/so/search?q=SQL%E8%AF%AD%E5%8F%A5&spm=1001.2101.3001.7020)编写方法。下面先给出一些涉及到的关键字。

类型       | 含义                          
-------- | ----------------------------
select   | 表示要查找出的表所含有的属性              
from     | 表示要操作的表                     
where    | 判断条件，根据该判断条件选择信息            
distinct | 在select后加入关键字distinct表示将结果去重
all      | 在select后加入关键字all表示不去重（默认）   
and      | 在where中使用and表示将判断条件连接起来     
or       | 在where中使用or表示判断条件多选一        
not      | 在where中使用not表示判断条件取反        

在下面的查询语句中，我们仍旧使用Student这张表来进行操作。先回顾一下这张表的字段。

```sql
create table Student(
ID varchar(20) not null,
name varchar(10) not null, 
age int,
class varchar(50),
primary key (ID));
```

#### 示例：

```sql
select name distinct
from Student
where age=18 and class="A";
```

在Student这张表中查询所有年龄是18岁，并且班级是A的学生的名字，并将结果去重。

###  多关系查询

多关系查询是指在多个表中通过一些操作查找出希望的信息。除去上面已有的关键字，我们还会使用到下面这些。

类型                | 含义                             
----------------- | -------------------------------
A，B               | 在from后面通过逗号连接多张表，表示将这些表进行笛卡儿积运算
natural join      | 将natural join关键字前后的两张表进行自然连接运算 
A join B using(c) | 将A和B通过c属性自然连接                  

为了能够进行多关系查询，我们需要有除了Student的另外一张表。再建一张表，表示上数学课的所有学生的信息和成绩情况。（实际上这两张表建的都不好，不能满足基本的几个范式，但是为了方便起见用来举例）

```sql
create table Math(
   ID varchar(20) not null,
   name varchar(10) not null,
   sex varchar(5),
   score int,
   primary key(ID));
```

#### 示例：

```sql
select score
form Student natural join Math
where class<>"B" and sex="men"
```

将Student表和Math表自然连接，所得的结果查询出不是B班的男生的成绩。

###  附加运算查询

我们已经总结了单关系和多关系运算的查询方法，但是只有这些

类型                      | 含义                                
----------------------- | ----------------------------------
as                      | 将as前的关系起一个别名，在此语句中，可以用别名来代指这个表    
\*                      | 在select中通过: “表名.*” 来表示查找出这个表中所有的属性
order by                | 让查询结果中的信息按照给定的属性排序（默认升序，上小下大）     
desc                    | 在order by之后的属性后使用，表示采用降序排序        
asc                     | 在order by之后的属性后使用，表示采用升序排序（默认）    
between                 | 在where中使用between表示一个数在两个数值之间取值    
not between             | between的反义词，在两个数之外取值              
union/union all         | 将两个SQL语句做并运算，并且自动去重，添加all表示不去重    
intersect/intersect all | 将两个SQL语句做交运算，并且自动去重，添加all表示不去重    
except/except all       | 将两个SQL语句做差运算，并且自动去重，添加all表示不去重    
is null                 | 在where中使用is null表示这个值是空值          
is not null             | 在where中使用is not null表示这个值不是空值     

#### 示例：

```sql
select S.*
from Student as S,Math as M
where S.ID = M.ID
```

将Student和Math两张表做笛卡儿积，结果中所有ID相同的信息，取出他们属于Student属性的部分作为结果。

```sql
select name
from Student natural join Math
where class="A" and sex="women"
order by score desc;
```

在Student和Math自然连接的结果中，找出A班的女生的姓名，并且按照成绩的降序把名字排列出来。

```sql
select name
from Math
where score between 60 and 90;
order by score asc;
```

在Math表中，找出成绩在60分到90分之间的学生姓名，并且将姓名按照成绩的升序排列出来。

```sql
(select name
from Student natural join Math
where class="A" and sex="women"
order by score desc)
union
(select name
from Math
where score between 60 and 90;
order by score);
```

将上面两个查出来的结果做并集，并且去重。

```sql
select name
from Student 
where age is null;
```

在Student表中记录的年龄值未填写（为空）的所有人的姓名查出来。

###  聚集函数运算查询

已经总结了SQL语句的很多关键字，现在我们可任意的进行排序、查找。但是如果我们要获得一些与数据相关的统计信息，但是这些信息在数据库中没有，那么我们要使用SQL中的聚集函数来进行操作。

类型       | 含义                         
-------- | ---------------------------
avg      | 平均值                        
min      | 最小值                        
max      | 最大值                        
sum      | 总和                         
count    | 计数                         
distinct | 表示将distinct后的属性去重          
group by | 将在group by上取值相同的信息分在一个组里   
having   | 对group by产生的分组进行筛选，可以使用聚集函数

#### 示例：

```sql
select class,avg(score) as avg_score
from Student natural join Math
group by class
having avg(score) < 60;
```

在Student与Math表自然连接的结果中按照班级分组，并且去除那些班级的平均成绩没到60的班级，剩下的班级和该班成绩的平均数（该班成绩的平均数这个属性被重命名为avg_score）作为一张新表被输出出来。