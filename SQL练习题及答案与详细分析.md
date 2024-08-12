## 数据表介绍

--1.学生表  

Student(SId,Sname,Sage,Ssex) 

--SId 学生编号，Sname 学生姓名,Sage 出生年月,Ssex 学生性别

--2.课程表  

Course(CId,Cname,TId)  

--CId 课程编号,Cname 课程名称,TId 教师编号

--3.教师表  

Teacher(TId,Tname)  

--TId 教师编号,Tname 教师姓名

--4.成绩表  

SC(SId,CId,score)  

--SId 学生编号,CId 课程编号,score 分数

## 学生表 Student



```
create table Student(SId varchar(10),Sname varchar(10),Sage datetime,Ssex varchar(10));
insert into Student values('01' , '赵雷' , '1990-01-01' , '男');
insert into Student values('02' , '钱电' , '1990-12-21' , '男');
insert into Student values('03' , '孙风' , '1990-12-20' , '男');
insert into Student values('04' , '李云' , '1990-12-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吴兰' , '1992-01-01' , '女');
insert into Student values('07' , '郑竹' , '1989-01-01' , '女');
insert into Student values('09' , '张三' , '2017-12-20' , '女');
insert into Student values('10' , '李四' , '2017-12-25' , '女');
insert into Student values('11' , '李四' , '2012-06-06' , '女');
insert into Student values('12' , '赵六' , '2013-06-13' , '女');
insert into Student values('13' , '孙七' , '2014-06-01' , '女');
```

## 科目表 Course



```
create table Course(CId varchar(10),Cname nvarchar(10),TId varchar(10));
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');
```

## 教师表 Teacher



```
create table Teacher(TId varchar(10),Tname varchar(10));
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');
```

## 成绩表 SC



```
create table SC(SId varchar(10),CId varchar(10),score decimal(18,1));
insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '03' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);
```

---

## 练习题目

1.  查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

2. 查询同时存在" 01 "课程和" 02 "课程的情况

3. 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )

4. 查询不存在" 01 "课程但存在" 02 "课程的情况

5. 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩

6.  查询在 SC 表存在成绩的学生信息

7.  查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )

8.  查有成绩的学生信息

9.  查询「李」姓老师的数量

10.  查询学过「张三」老师授课的同学的信息

11.  查询没有学全所有课程的同学的信息

12.  查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息

13.  查询和" 01 "号的同学学习的课程   完全相同的其他同学的信息

14.  查询没学过"张三"老师讲授的任一门课程的学生姓名

15.  查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

16.  检索" 01 "课程分数小于 60，按分数降序排列的学生信息

17.  按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

18.  查询各科成绩最高分、最低分和平均分：

		以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
		
		及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
		
		要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列

19.  按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺

20. 按各科成绩进行排序，并显示排名， Score 重复时合并名次

21.  查询学生的总成绩，并进行排名，总分重复时保留名次空缺

22. 查询学生的总成绩，并进行排名，总分重复时不保留名次空缺

23.  统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比

24.  查询各科成绩前三名的记录

25.  查询每门课程被选修的学生数

26.  查询出只选修两门课程的学生学号和姓名

27.  查询男生、女生人数

28.  查询名字中含有「风」字的学生信息

29.  查询同名同性学生名单，并统计同名人数

30.  查询 1990 年出生的学生名单

31.  查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

32.  查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩

33.  查询课程名称为「数学」，且分数低于 60 的学生姓名和分数

34.  查询所有学生的课程及分数情况（存在学生没成绩，没选课的情况）

35.  查询任何一门课程成绩在 70 分以上的姓名、课程名称和分数

36.  查询不及格的课程

37.  查询课程编号为 01 且课程成绩在 80 分以上的学生的学号和姓名

38.  求每门课程的学生人数

39.  成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩

40.  成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩

41.  查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩

42.  查询每门功成绩最好的前两名

43.  统计每门课程的学生选修人数（超过 5 人的课程才统计）。

44.  检索至少选修两门课程的学生学号

45.  查询选修了全部课程的学生信息

46.  查询各学生的年龄，只按年份来算

47.  按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一

48.  查询本周过生日的学生

49.  查询下周过生日的学生

50.  查询本月过生日的学生

51.  查询下月过生日的学生


## 答案

---

1. 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数  

因为需要全部的学生信息，则需要在sc表中得到符合条件的SId后与student表进行join，可以left join 也可以 right join

```sql
select * from Student RIGHT JOIN (
    select t1.SId, class1, class2 from
          (select SId, score as class1 from sc where sc.CId = '01')as t1, 
          (select SId, score as class2 from sc where sc.CId = '02')as t2
    where t1.SId = t2.SId AND t1.class1 > t2.class2
)r 
on Student.SId = r.SId;
```

```sql
select * from  (
    select t1.SId, class1, class2 
    from
        (SELECT SId, score as class1 FROM sc WHERE sc.CId = '01') AS t1, 
        (SELECT SId, score as class2 FROM sc WHERE sc.CId = '02') AS t2
    where t1.SId = t2.SId and t1.class1 > t2.class2
) r 
LEFT JOIN Student
ON Student.SId = r.SId;
```

2. 查询同时存在" 01 "课程和" 02 "课程的情况

```sql
select * from 
    (select * from sc where sc.CId = '01') as t1, 
    (select * from sc where sc.CId = '02') as t2
where t1.SId = t2.SId;
```

3. 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )  

这一道就是明显需要使用join的情况了，02可能不存在，即为left join的右侧或right join 的左侧即可.


```sql
select * from 
(select * from sc where sc.CId = '01') as t1
left join 
(select * from sc where sc.CId = '02') as t2
on t1.SId = t2.SId;
```


```sql
select * from 
(select * from sc where sc.CId = '02') as t2
right join 
(select * from sc where sc.CId = '01') as t1
on t1.SId = t2.SId;
```

4. 查询不存在" 01 "课程但存在" 02 "课程的情况


```sql
select * from sc
where sc.SId not in (
    select SId from sc 
    where sc.CId = '01'
) 
AND sc.CId= '02';
```

5.  查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩  

    这里只用根据学生ID把成绩分组，对分组中的score求平均值，最后在选取结果中AVG大于60的即可. 注意，这里必须要给计算得到的AVG结果一个alias.（AS ss）  

    得到学生信息的时候既可以用join也可以用一般的联合搜索


```sql
select student.SId,sname,ss from student,(
    select SId, AVG(score) as ss from sc  
    GROUP BY SId 
    HAVING AVG(score)> 60
    )r
where student.sid = r.sid;
```


```sql
select Student.SId, Student.Sname, r.ss from Student right join(
      select SId, AVG(score) AS ss from sc
      GROUP BY SId
      HAVING AVG(score)> 60
)r on Student.SId = r.SId;
```


```sql
select s.SId,ss,Sname from(
select SId, AVG(score) as ss from sc  
GROUP BY SId 
HAVING AVG(score)> 60
)r left join 
(select Student.SId, Student.Sname from
Student)s on s.SId = r.SId;
```

6.  查询在 SC 表存在成绩的学生信息


```sql
select DISTINCT student.*
from student,sc
where student.SId=sc.SId
```

7. 查询所有同学的学生编号、学生姓名、选课总数、所有课程的成绩总和  

联合查询不会显示没选课的学生：


```sql
select student.sid, student.sname,r.coursenumber,r.scoresum
from student,
(select sc.sid, sum(sc.score) as scoresum, count(sc.cid) as coursenumber from sc 
group by sc.sid)r
where student.sid = r.sid;
```

如要显示没选课的学生(显示为NULL)，需要使用join:


```sql
select s.sid, s.sname,r.coursenumber,r.scoresum
from (
    (select student.sid,student.sname 
    from student
    )s 
    left join 
    (select 
        sc.sid, sum(sc.score) as scoresum, count(sc.cid) as coursenumber
        from sc 
        group by sc.sid
    )r 
   on s.sid = r.sid
);
```

8. 查有成绩的学生信息  
这一题涉及到in和exists的用法，在这种小表中，两种方法的效率都差不多，但是请参考[SQL查询中in和exists的区别分析](https://www.jianshu.com/p/f212527d76ff)  
当表2的记录数量非常大的时候，选用exists比in要高效很多.  
EXISTS用于检查子查询是否至少会返回一行数据，该子查询实际上并不返回任何数据，而是返回值True或False.  
结论：IN()适合B表比A表数据小的情况  
结论：EXISTS()适合B表比A表数据大的情况


```sql
select * from student 
where exists (select sc.sid from sc where student.sid = sc.sid);
```


```sql
select * from student
where student.sid in (select sc.sid from sc);
```

9.  查询「李」姓老师的数量


```sql
select count(*)
from teacher
where tname like '李%';
```

10.  查询学过「张三」老师授课的同学的信息  

    多表联合查询


```sql
select student.* from student,teacher,course,sc
where 
    student.sid = sc.sid 
    and course.cid=sc.cid 
    and course.tid = teacher.tid 
    and tname = '张三';
```

11.  查询没有学全所有课程的同学的信息  

    因为有学生什么课都没有选，反向思考，先查询选了所有课的学生，再选择这些人之外的学生.


```sql
select * from student
where student.sid not in (
  select sc.sid from sc
  group by sc.sid
  having count(sc.cid)= (select count(cid) from course)
);
```

12.  查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息  

    这个用联合查询也可以，但是逻辑不清楚，我觉得较为清楚的逻辑是这样的：从sc表查询01同学的所有选课cid--从sc表查询所有同学的sid如果其cid在前面的结果中--从student表查询所有学生信息如果sid在前面的结果中


```sql
select * from student 
where student.sid in (
    select sc.sid from sc 
    where sc.cid in(
        select sc.cid from sc 
        where sc.sid = '01'
    )
);
```

13. 查询和" 01 "号的同学学习的课程完全相同的其他同学的信息  
不会做。


```sql

```

14. 查询没学过"张三"老师讲授的任一门课程的学生姓名  
仍然还是嵌套，三层嵌套， 或者多表联合查询


```sql
select * from student
    where student.sid not in(
        select sc.sid from sc where sc.cid in(
            select course.cid from course where course.tid in(
                select teacher.tid from teacher where tname = "张三"
            )
        )
    );
```


```sql
select * from student
where student.sid not in(
    select sc.sid from sc,course,teacher 
    where
        sc.cid = course.cid
        and course.tid = teacher.tid
        and teacher.tname= "张三"
);
```

15. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩  
从SC表中选取score小于60的，并group by sid，having count 大于1  
(更新采用评论1中的解法)


```sql
select student.SId, student.Sname,b.avg
from student RIGHT JOIN
(select sid, AVG(score) as avg from sc
    where sid in (
              select sid from sc 
              where score<60 
              GROUP BY sid 
              HAVING count(score)>1)
    GROUP BY sid) b on student.sid=b.sid;
```

16.  检索" 01 "课程分数小于 60，按分数降序排列的学生信息  

    双表联合查询，在查询最后可以设置排序方式，语法为ORDER BY ***** DESC\ASC;


```sql
select student.*, sc.score from student, sc
where student.sid = sc.sid
and sc.score < 60
and cid = "01"
ORDER BY sc.score DESC;
```

17.  按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩



```sql
select *  from sc 
left join (
    select sid,avg(score) as avscore from sc 
    group by sid
    )r 
on sc.sid = r.sid
order by avscore desc;
```

18.  查询各科成绩最高分、最低分和平均分：

以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率

及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90

要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列


```sql
select 
sc.CId ,
max(sc.score)as 最高分,
min(sc.score)as 最低分,
AVG(sc.score)as 平均分,
count(*)as 选修人数,
sum(case when sc.score>=60 then 1 else 0 end )/count(*)as 及格率,
sum(case when sc.score>=70 and sc.score<80 then 1 else 0 end )/count(*)as 中等率,
sum(case when sc.score>=80 and sc.score<90 then 1 else 0 end )/count(*)as 优良率,
sum(case when sc.score>=90 then 1 else 0 end )/count(*)as 优秀率 
from sc
GROUP BY sc.CId
ORDER BY count(*)DESC, sc.CId ASC
```

19.  按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺  

    这一道题有点tricky，可以用变量，但也有更为简单的方法，即自交（左交）  

    用sc中的score和自己进行对比，来计算“比当前分数高的分数有几个”。


```sql
select a.cid, a.sid, a.score, count(b.score)+1 as rank
from sc as a 
left join sc as b 
on a.score<b.score and a.cid = b.cid
group by a.cid, a.sid,a.score
order by a.cid, rank ASC;
```

22.  查询学生的总成绩，并进行排名，总分重复时不保留名次空缺  

    这里主要学习一下使用变量。在SQL里面变量用@来标识。


```sql
set @crank=0;
select q.sid, total, @crank := @crank +1 as rank from(
select sc.sid, sum(sc.score) as total from sc
group by sc.sid
order by total desc)q;
```

23.  统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比  

    有时候觉得自己真是死脑筋。group by以后的查询结果无法使用别名，所以不要想着先单表group by计算出结果再从第二张表里添上课程信息，而应该先将两张表join在一起得到所有想要的属性再对这张总表进行统计计算。这里就不算百分比了，道理相同。  

    注意一下，用case when 返回1 以后的统计不是用count而是sum


```sql
select course.cname, course.cid,
sum(case when sc.score<=100 and sc.score>85 then 1 else 0 end) as "[100-85]",
sum(case when sc.score<=85 and sc.score>70 then 1 else 0 end) as "[85-70]",
sum(case when sc.score<=70 and sc.score>60 then 1 else 0 end) as "[70-60]",
sum(case when sc.score<=60 and sc.score>0 then 1 else 0 end) as "[60-0]"
from sc left join course
on sc.cid = course.cid
group by sc.cid;
```

24.  查询各科成绩前三名的记录  

	大坑比。mysql不能group by 了以后取limit，所以不要想着讨巧了，我快被这一题气死了。思路有两种，第一种比较暴力，计算比自己分数大的记录有几条，如果小于3 就select，因为对前三名来说不会有3个及以上的分数比自己大了，最后再对所有select到的结果按照分数和课程编号排名即可。


```sql
select * from sc
where (
select count(*) from sc as a 
where sc.cid = a.cid and sc.score<a.score 
)< 3
order by cid asc, sc.score desc;
```

第二种比较灵巧一些，用自身左交，但是有点难以理解。  
先用自己交自己，条件为a.cid = b.cid and a.score<b.score，其实就是列出同一门课内所有分数比较的情况。  
想要查看完整的表可以


```sql
select * from sc a 
left join sc b on a.cid = b.cid and a.score<b.score
order by a.cid,a.score;
```

查看，发现结果是47行的一个表，列出了类似 01号课里“30分小于50，也小于70，也小于80，也小于90”“50分小于70，小于80，小于90”.....  
所以理论上，对任何一门课来说，分数最高的那三个记录，在这张大表里，通过a.sid和a.cid可以联合确定这个同学的这门课的这个分数究竟比多少个其他记录高/低，  
如果这个特定的a.sid和a.cid组合出现在这张表里的次数少于3个，那就意味着这个组合（学号+课号+分数）是这门课里排名前三的。  
所以下面这个计算中having count 部分其实count(_)或者任意其他列都可以，这里制定了一个列只是因为比count(_)运行速度上更快。


```sql
select a.sid,a.cid,a.score from sc a 
left join sc b on a.cid = b.cid and a.score<b.score
group by a.cid, a.sid
having count(b.cid)<3
order by a.cid;
```

25.  查询每门课程被选修的学生数


```sql
select cid, count(sid) from sc 
group by cid;
```

26.  查询出只选修两门课程的学生学号和姓名  

    嵌套查询


```sql
select student.sid, student.sname from student
where student.sid in
(select sc.sid from sc
group by sc.sid
having count(sc.cid)=2
);
```

联合查询


```sql
select student.SId,student.Sname
from sc,student
where student.SId=sc.SId  
GROUP BY sc.SId
HAVING count(*)=2；
```

27. 查询男生、女生人数


```sql
select ssex, count(*) from student
group by ssex;
```

28.  查询名字中含有「风」字的学生信息


```sql
select *
from student 
where student.Sname like '%风%'
```

29. 查询同名学生名单，并统计同名人数  

找到同名的名字并统计个数

```sql
select sname, count(*) from student
group by sname
having count(*)>1;
```

嵌套查询列出同名的全部学生的信息


```sql
select * from student
where sname in (
select sname from student
group by sname
having count(*)>1
);
```

30. 查询 1990 年出生的学生名单


```sql
select *
from student
where YEAR(student.Sage)=1990;
```

31. 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列


```sql
select sc.cid, course.cname, AVG(SC.SCORE) as average from sc, course
where sc.cid = course.cid
group by sc.cid 
order by average desc,cid asc;
```

32. 查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩  
having也可以用来截取结果表，在这里就先得到平均成绩总表，再截取AVG大于85的即可.


```sql
select student.sid, student.sname, AVG(sc.score) as aver from student, sc
where student.sid = sc.sid
group by sc.sid
having aver > 85;
```

33.  查询课程名称为「数学」，且分数低于 60 的学生姓名和分数


```sql
select student.sname, sc.score from student, sc, course
where student.sid = sc.sid
and course.cid = sc.cid
and course.cname = "数学"
and sc.score < 60;
```

34.  查询所有学生的课程及分数情况（存在学生没成绩，没选课的情况）


```sql
select student.sname, cid, score from student
left join sc
on student.sid = sc.sid;
```

35.  查询任何一门课程成绩在 70 分以上的姓名、课程名称和分数


```sql
select student.sname, course.cname,sc.score from student,course,sc
where sc.score>70
and student.sid = sc.sid
and sc.cid = course.cid;
```

36. 查询存在不及格的课程  

可以用group by 来取唯一，也可以用distinct


```sql
select cid from sc
where score< 60
group by cid;
```


```sql
select DISTINCT sc.CId
from sc
where sc.score <60;
```

37. 查询课程编号为 01 且课程成绩在 80 分及以上的学生的学号和姓名


```sql
select student.sid,student.sname 
from student,sc
where cid="01"
and score>=80
and student.sid = sc.sid;
```

38.  求每门课程的学生人数


```sql
select sc.CId,count(*) as 学生人数
from sc
GROUP BY sc.CId;
```

39.  成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩  

    用having max()理论上也是对的，但是下面那种按分数排序然后取limit 1的更直观可靠


```sql
select student.*, sc.score, sc.cid from student, teacher, course,sc 
where teacher.tid = course.tid
and sc.sid = student.sid
and sc.cid = course.cid
and teacher.tname = "张三"
having max(sc.score);
```


```sql
select student.*, sc.score, sc.cid from student, teacher, course,sc 
where teacher.tid = course.tid
and sc.sid = student.sid
and sc.cid = course.cid
and teacher.tname = "张三"
order by score desc
limit 1;
```

40.  成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩  

    为了验证这一题，先修改原始数据


```sql
UPDATE sc SET score=90
where sid = "07"
and cid ="02";
```

这样张三老师教的02号课就有两个学生同时获得90的最高分了。  
这道题的思路继续上一题，我们已经查询到了符合限定条件的最高分了，这个时候只用比较这张表，找到全部score等于这个最高分的记录就可，看起来有点繁复。


```sql
select student.*, sc.score, sc.cid from student, teacher, course,sc 
where teacher.tid = course.tid
and sc.sid = student.sid
and sc.cid = course.cid
and teacher.tname = "张三"
and sc.score = (
    select Max(sc.score) 
    from sc,student, teacher, course
    where teacher.tid = course.tid
    and sc.sid = student.sid
    and sc.cid = course.cid
    and teacher.tname = "张三"
);
```

41.  查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩  

    同上，在这里用了inner join后会有概念是重复的记录：“01 课与 03课”=“03 课与 01 课”，所以这里取唯一可以直接用group by



```sql
select  a.cid, a.sid,  a.score from sc as a
inner join 
sc as b
on a.sid = b.sid
and a.cid != b.cid
and a.score = b.score
group by cid, sid;
```

42. 查询每门功成绩最好的前两名  
同上19题


```sql
select a.sid,a.cid,a.score from sc as a 
left join sc as b 
on a.cid = b.cid and a.score<b.score
group by a.cid, a.sid
having count(b.cid)<2
order by a.cid;
```

43. 统计每门课程的学生选修人数（超过 5 人的课程才统计）


```sql
select sc.cid, count(sid) as cc from sc
group by cid
having cc >5;
```

44. 检索至少选修两门课程的学生学号


```sql
select sid, count(cid) as cc from sc
group by sid
having cc>=2;
```

45.  查询选修了全部课程的学生信息


```sql
select student.*
from sc ,student 
where sc.SId=student.SId
GROUP BY sc.SId
HAVING count(*) = (select DISTINCT count(*) from course )
```

46. 查询各学生的年龄，只按年份来算  

不想做，一般都用41题的方法精确到天


```sql

```

47.  按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一


```sql
select student.SId as 学生编号,student.Sname  as  学生姓名,
TIMESTAMPDIFF(YEAR,student.Sage,CURDATE()) as 学生年龄
from student
```

48. 查询本周过生日的学生


```sql
select *
from student 
where WEEKOFYEAR(student.Sage)=WEEKOFYEAR(CURDATE());
```

49.  查询下周过生日的学生


```sql
select *
from student 
where WEEKOFYEAR(student.Sage)=WEEKOFYEAR(CURDATE())+1;
```

50. 查询本月过生日的学生


```sql
select *
from student 
where MONTH(student.Sage)=MONTH(CURDATE());
```

51. 查询下月过生日的学生


```sql
select *
from student 
where MONTH(student.Sage)=MONTH(CURDATE())+1;
```
