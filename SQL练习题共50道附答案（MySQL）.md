1.学生表 
student(s_id,s_name,s_birth,s_sex) 

-- 学生编号，学生姓名， 出生年月，学生性别 

2.课程表 
course(c_id,c_name,t_id) 

-- 课程编号, 课程名称, 教师编号 

3.教师表 
teacher(t_id,t_name) 

-– 教师编号,教师姓名 

4.成绩表 
score(s_id,c_id,s_score) 

--学生编号,课程编号,分数

导入数据到数据库:

```sql
--  建立课程表
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `c_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '课程编号',
  `c_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '课程名称',
  `t_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师编号',
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
-- 课程表数据
INSERT INTO `course` VALUES ('01', '语文', '02');
INSERT INTO `course` VALUES ('02', '数学', '01');
INSERT INTO `course` VALUES ('03', '英语', '03');
-- 分数表
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `s_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '学生编号',
  `c_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '课程编号',
  `s_score` int(3) NULL DEFAULT NULL COMMENT '分数',
  PRIMARY KEY (`s_id`, `c_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
-- 分数数据
INSERT INTO `score` VALUES ('01', '01', 80);
INSERT INTO `score` VALUES ('01', '02', 90);
INSERT INTO `score` VALUES ('01', '03', 99);
INSERT INTO `score` VALUES ('02', '01', 70);
INSERT INTO `score` VALUES ('02', '02', 60);
INSERT INTO `score` VALUES ('02', '03', 80);
INSERT INTO `score` VALUES ('03', '01', 80);
INSERT INTO `score` VALUES ('03', '02', 80);
INSERT INTO `score` VALUES ('03', '03', 80);
INSERT INTO `score` VALUES ('04', '01', 50);
INSERT INTO `score` VALUES ('04', '02', 30);
INSERT INTO `score` VALUES ('04', '03', 20);
INSERT INTO `score` VALUES ('05', '01', 76);
INSERT INTO `score` VALUES ('05', '02', 87);
INSERT INTO `score` VALUES ('05', '03', 95);
INSERT INTO `score` VALUES ('06', '01', 31);
INSERT INTO `score` VALUES ('06', '02', 88);
INSERT INTO `score` VALUES ('06', '03', 34);
INSERT INTO `score` VALUES ('07', '01', 66);
INSERT INTO `score` VALUES ('07', '02', 89);
INSERT INTO `score` VALUES ('07', '03', 98);
INSERT INTO `score` VALUES ('08', '01', 59);
INSERT INTO `score` VALUES ('08', '02', 88);
INSERT INTO `score` VALUES ('09', '02', 67);
INSERT INTO `score` VALUES ('09', '03', 88);
INSERT INTO `score` VALUES ('10', '01', 65);
INSERT INTO `score` VALUES ('10', '02', 78);
-- 建立学生表
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `s_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '学生编号',
  `s_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '学生姓名',
  `s_birth` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '出生年月',
  `s_sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '学生性别',
  PRIMARY KEY (`s_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
-- 学生数据
INSERT INTO `student` VALUES ('01', '斯内克', '1990-01-01', '男');
INSERT INTO `student` VALUES ('02', '张益达', '1990-12-21', '男');
INSERT INTO `student` VALUES ('03', '张大炮', '1990-05-20', '男');
INSERT INTO `student` VALUES ('04', '李云龙', '1990-08-06', '男');
INSERT INTO `student` VALUES ('05', '楚云飞', '1991-12-01', '女');
INSERT INTO `student` VALUES ('06', '赵日天', '1992-03-01', '女');
INSERT INTO `student` VALUES ('07', '小甜甜', '1989-07-01', '女');
INSERT INTO `student` VALUES ('08', '王菊花', '1990-01-20', '女');
INSERT INTO `student` VALUES ('09', '李慕白', '1994-01-20', '男');
INSERT INTO `student` VALUES ('10', '东京热', '1980-01-20', '女');
-- 建立老师表
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `t_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '教师编号',
  `t_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '教师姓名',
  PRIMARY KEY (`t_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
-- 老师表数据
INSERT INTO `teacher` VALUES ('01', '墨白');
INSERT INTO `teacher` VALUES ('02', '默狐');
INSERT INTO `teacher` VALUES ('03', '柠檬');
SET FOREIGN_KEY_CHECKS = 1;
```


1、查询"语文"课程比"数学"课程成绩高的学生的信息及课程分数 

```sql
SELECT
    st.*,
    sc.s_score AS '语文',
    sc2.s_score '数学' 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = '01'
    LEFT JOIN score sc2 ON sc2.s_id = st.s_id 
    AND sc2.c_id = '02' 
WHERE
    sc.s_score > sc2.s_score
```


2、查询"语文"课程比"数学"课程成绩低的学生的信息及课程分数

```sql
SELECT
    st.*,
    sc.s_score '语文',
    sc2.s_score '数学' 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = '01'
    LEFT JOIN score sc2 ON sc2.s_id = st.s_id 
    AND sc2.c_id = '02' 
WHERE
    sc.s_score < sc2.s_score
```


3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    ROUND( AVG( sc.s_score ), 2 ) "平均成绩" 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
GROUP BY
    st.s_id 
HAVING
    AVG( sc.s_score )>= 60
```


4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩(包括有成绩的和无成绩的)

```sql
SELECT
    st.s_id,
    st.s_name,(
    CASE

            WHEN ROUND( AVG( sc.s_score ), 2 ) IS NULL THEN
            0 ELSE ROUND( AVG( sc.s_score ), 2 ) 
        END 
        ) "平均成绩" 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id 
    GROUP BY
        st.s_id 
    HAVING
    AVG( sc.s_score )< 60 
    OR AVG( sc.s_score ) IS NULL
```


5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    count( sc.c_id ) "选课总数",
    sum( CASE WHEN sc.s_score IS NULL THEN 0 ELSE sc.s_score END ) "总成绩" 
FROM
    student st
    LEFT JOIN score sc ON st.s_id = sc.s_id 
GROUP BY
    st.s_id
```


6、查询"墨"姓老师的数量 

```sql
SELECT
    t.t_name,
    count( t.t_id ) 
FROM
    teacher t 
GROUP BY
    t.t_id 
HAVING
    t.t_name LIKE "墨%";
```


7、查询学过"墨白"老师授课的同学的信息 

```sql
SELECT
    st.* 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id
    LEFT JOIN course c ON c.c_id = sc.c_id
    LEFT JOIN teacher t ON t.t_id = c.t_id 
WHERE
    t.t_name = "墨白"
```



8、查询没学过"柠檬"老师授课的同学的信息


```sql
-- 柠檬老师教的课
SELECT
    c.* 
FROM
    course c
    LEFT JOIN teacher t ON t.t_id = c.t_id 
WHERE
    t.t_name = "柠檬" 
-- 有柠檬老师课成绩的st.s_id
SELECT
    sc.s_id 
FROM
    score sc 
WHERE
    sc.c_id IN ( SELECT c.c_id FROM course c LEFT JOIN teacher t ON t.t_id = c.t_id WHERE t.t_name = "柠檬" ) 
-- 不在上面查到的st.s_id的学生信息,即没学过柠檬老师授课的同学信息
SELECT
    st.* 
FROM
    student st 
WHERE
    st.s_id NOT IN (
    SELECT
        sc.s_id 
    FROM
        score sc 
    WHERE
    sc.c_id IN ( SELECT c.c_id FROM course c LEFT JOIN teacher t ON t.t_id = c.t_id WHERE t.t_name = "柠檬" ) 
    )
```


9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息

```sql
SELECT
    st.* 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id
    INNER JOIN course c ON c.c_id = sc.c_id 
    AND c.c_id = "01" 
WHERE
    st.s_id IN (
    SELECT
        st2.s_id 
    FROM
        student st2
        INNER JOIN score sc2 ON sc2.s_id = st2.s_id
        INNER JOIN course c2 ON c2.c_id = sc2.c_id 
    AND c2.c_id = "02" 
    )
-- 或者第二种
SELECT
    a.* 
FROM
    student a,
    score b,
    score c 
WHERE
    a.s_id = b.s_id 
    AND a.s_id = c.s_id 
    AND b.c_id = '01' 
    AND c.c_id = '02';
```


10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息

```sql
SELECT
    st.* 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id
    INNER JOIN course c ON c.c_id = sc.c_id 
    AND c.c_id = "01" 
WHERE
    st.s_id NOT IN (
    SELECT
        st2.s_id 
    FROM
        student st2
        INNER JOIN score sc2 ON sc2.s_id = st2.s_id
        INNER JOIN course c2 ON c2.c_id = sc2.c_id 
    AND c2.c_id = "02" 
    )
```


11、查询没有学全所有课程的同学的信息

```sql
SELECT
    * 
FROM
    student 
WHERE
    s_id NOT IN (
    SELECT
        st.s_id 
    FROM
        student st
        INNER JOIN score sc ON sc.s_id = st.s_id 
        AND sc.c_id = "01" 
    WHERE
    st.s_id IN ( SELECT st1.s_id FROM student st1 INNER JOIN score sc2 ON sc2.s_id = st1.s_id AND sc2.c_id = "02" ) 
    AND st.s_id IN ( SELECT st2.s_id FROM student st2 INNER JOIN score sc2 ON sc2.s_id = st2.s_id AND sc2.c_id = "03" ))
```


12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息

```sql
SELECT DISTINCT
    st.* 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
WHERE
    sc.c_id IN (
    SELECT
        sc2.c_id 
    FROM
        student st2
        LEFT JOIN score sc2 ON sc2.s_id = st2.s_id 
    WHERE
    st2.s_id = '01' 
    )
```


13、查询和"01"号的同学学习的课程完全相同的其他同学的信息

```sql
SELECT
    st.* 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
GROUP BY
    st.s_id 
HAVING
    group_concat( sc.c_id ) = (
    SELECT
        group_concat( sc2.c_id ) 
    FROM
        student st2
        LEFT JOIN score sc2 ON sc2.s_id = st2.s_id 
    WHERE
    st2.s_id = '01' 
    )
```


14、查询没学过"默狐"老师讲授的任一门课程的学生姓名

```sql
SELECT
    st.s_name 
FROM
    student st 
WHERE
    st.s_id NOT IN (
    SELECT
        sc.s_id 
    FROM
        score sc
        INNER JOIN course c ON c.c_id = sc.c_id
        INNER JOIN teacher t ON t.t_id = c.t_id 
    AND t.t_name = "默狐" 
    )
```


15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    avg( sc.s_score ) 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
WHERE
    sc.s_id IN (
    SELECT
        sc.s_id 
    FROM
        score sc 
    WHERE
        sc.s_score < 60 
        OR sc.s_score IS NULL 
    GROUP BY
        sc.s_id 
    HAVING
        COUNT( 1 )>= 2 
    ) 
GROUP BY
    st.s_id
```


16、检索"01"课程分数小于60，按分数降序排列的学生信息

```sql
SELECT
    st.*,
    sc.s_score 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = "01" 
    AND sc.s_score < 60 
ORDER BY
    sc.s_score DESC

-- 第二种SQL
SELECT
    st.*,
    sc.s_score 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
WHERE
    sc.c_id = "01" 
    AND sc.s_score < 60 
ORDER BY
    sc.s_score DESC
```


17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    avg( sc4.s_score ) "平均分",
    sc.s_score "语文",
    sc2.s_score "数学",
    sc3.s_score "英语" 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = "01"
    LEFT JOIN score sc2 ON sc2.s_id = st.s_id 
    AND sc2.c_id = "02"
    LEFT JOIN score sc3 ON sc3.s_id = st.s_id 
    AND sc3.c_id = "03"
    LEFT JOIN score sc4 ON sc4.s_id = st.s_id 
GROUP BY
    st.s_id 
ORDER BY
    avg( sc4.s_score ) DESC

-- 第二种
SELECT
    st.s_id,
    st.s_name,
    ( CASE WHEN avg( sc4.s_score ) IS NULL THEN 0 ELSE avg( sc4.s_score ) END ) "平均分",
    ( CASE WHEN sc.s_score IS NULL THEN 0 ELSE sc.s_score END ) "语文",
    ( CASE WHEN sc2.s_score IS NULL THEN 0 ELSE sc2.s_score END ) "数学",
    ( CASE WHEN sc3.s_score IS NULL THEN 0 ELSE sc3.s_score END ) "英语" 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = "01"
    LEFT JOIN score sc2 ON sc2.s_id = st.s_id 
    AND sc2.c_id = "02"
    LEFT JOIN score sc3 ON sc3.s_id = st.s_id 
    AND sc3.c_id = "03"
    LEFT JOIN score sc4 ON sc4.s_id = st.s_id 
GROUP BY
    st.s_id 
ORDER BY
    avg( sc4.s_score ) DESC
```


18.查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率

(及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90)


```sql
SELECT
    c.c_id,
    c.c_name,
    max( sc.s_score ) "最高分",
    MIN( sc2.s_score ) "最低分",
    avg( sc3.s_score ) "平均分",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 60 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "及格率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 70 
            AND s_score < 80 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "中等率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 80 
            AND s_score < 90 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "优良率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 90 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
        )) "优秀率" 
FROM
    course c
    LEFT JOIN score sc ON sc.c_id = c.c_id
    LEFT JOIN score sc2 ON sc2.c_id = c.c_id
    LEFT JOIN score sc3 ON sc3.c_id = c.c_id 
GROUP BY
    c.c_id
```


19、按各科成绩进行排序，并显示排名(实现不完全)

```sql
SELECT
    c.c_id,
    c.c_name,
    max( sc.s_score ) "最高分",
    MIN( sc2.s_score ) "最低分",
    avg( sc3.s_score ) "平均分",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 60 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "及格率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 70 
            AND s_score < 80 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "中等率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 80 
            AND s_score < 90 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
            )) "优良率",((
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            s_score >= 90 
            AND c_id = c.c_id 
            )/(
        SELECT
            count( s_id ) 
        FROM
            score 
        WHERE
            c_id = c.c_id 
        )) "优秀率" 
FROM
    course c
    LEFT JOIN score sc ON sc.c_id = c.c_id
    LEFT JOIN score sc2 ON sc2.c_id = c.c_id
    LEFT JOIN score sc3 ON sc3.c_id = c.c_id 
GROUP BY
    c.c_id
```


20、查询学生的总成绩并进行排名

```sql
SELECT
    st.s_id,
    st.s_name,(
    CASE

            WHEN sum( sc.s_score ) IS NULL THEN
            0 ELSE sum( sc.s_score ) 
        END 
        ) 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id 
    GROUP BY
        st.s_id 
ORDER BY
    sum( sc.s_score ) DESC
```


21、查询不同老师所教不同课程平均分从高到低显示

```sql
SELECT
    t.t_id,
    t.t_name,
    c.c_name,
    avg( sc.s_score ) 
FROM
    teacher t
    LEFT JOIN course c ON c.t_id = t.t_id
    LEFT JOIN score sc ON sc.c_id = c.c_id 
GROUP BY
    t.t_id 
ORDER BY
    avg( sc.s_score ) DESC
```


22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩

```sql
SELECT
    a.* 
FROM
    (
    SELECT
        st.*,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "01" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 1,
        2 
    ) a UNION ALL
SELECT
    b.* 
FROM
    (
    SELECT
        st.*,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "02" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 1,
        2 
    ) b UNION ALL
SELECT
    c.* 
FROM
    (
    SELECT
        st.*,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "03" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 1,
    2 
    ) c
```


23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比

```sql
SELECT
    c.c_id,
    c.c_name,((
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            AND sc.s_score <= 100 AND sc.s_score > 80 
            )/(
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            )) "100-85",((
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            AND sc.s_score <= 85 AND sc.s_score > 70 
            )/(
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            )) "85-70",((
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            AND sc.s_score <= 70 AND sc.s_score > 60 
            )/(
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            )) "70-60",((
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
            AND sc.s_score <= 60 AND sc.s_score >= 0 
            )/(
        SELECT
            count( 1 ) 
        FROM
            score sc 
        WHERE
            sc.c_id = c.c_id 
        )) "60-0" 
FROM
    course c 
ORDER BY
    c.c_id
```


24、查询学生平均成绩及其名次

```sql
SET @i = 0;
SELECT
    a.*,
    @i := @i + 1 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        round(( CASE WHEN avg( sc.s_score ) IS NULL THEN 0 ELSE avg( sc.s_score ) END ), 2 ) "平均分" 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id 
    GROUP BY
        st.s_id 
    ORDER BY
    sc.s_score DESC 
    ) a
```


25、查询各科成绩前三名的记录

```sql
SELECT
    a.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = '01' 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
        3 
    ) a UNION ALL
SELECT
    b.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = '02' 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
        3 
    ) b UNION ALL
SELECT
    c.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_id,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = '03' 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
    3 
    ) c
```


26、查询每门课程被选修的学生数

```sql
SELECT
    c.c_id,
    c.c_name,
    count( 1 ) 
FROM
    course c
    LEFT JOIN score sc ON sc.c_id = c.c_id
    INNER JOIN student st ON st.s_id = c.c_id 
GROUP BY
    st.s_id
```


27、查询出只有两门课程的全部学生的学号和姓名

```sql
SELECT
    st.s_id,
    st.s_name 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id
    INNER JOIN course c ON c.c_id = sc.c_id 
GROUP BY
    st.s_id 
HAVING
    count( 1 )=2
```


28、查询男生、女生人数

```sql
SELECT
    st.s_sex,
    count( 1 ) 
FROM
    student st 
GROUP BY
    st.s_sex
```


29、查询名字中含有"白"字的学生信息

```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    st.s_name LIKE "%白%";
```


30、查询同名同性学生名单，并统计同名人数

```sql
SELECT
    st.*,
    count( 1 ) 
FROM
    student st 
GROUP BY
    st.s_name,
    st.s_sex 
HAVING
    count( 1 )> 1
```


31、查询1990年出生的学生名单

```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    st.s_birth LIKE "1990%";
```


32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

```sql
SELECT
    c.c_id,
    c.c_name,
    avg( sc.s_score ) 
FROM
    course c
    INNER JOIN score sc ON sc.c_id = c.c_id 
GROUP BY
    c.c_id 
ORDER BY
    avg( sc.s_score ) DESC,
    c.c_id ASC
```


33、查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    avg( sc.s_score ) 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
GROUP BY
    st.s_id 
HAVING
    avg( sc.s_score )>= 85
```


34、查询课程名称为"数学"，且分数低于60的学生姓名和分数

```sql
SELECT
    st.s_id,
    st.s_name,
    sc.s_score 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id 
    AND sc.s_score < 60
    INNER JOIN course c ON c.c_id = sc.c_id 
    AND c.c_name = "数学"
```


35、查询所有学生的课程及分数情况

```sql
SELECT
    st.s_id,
    st.s_name,
    c.c_name,
    sc.s_score 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id
    LEFT JOIN course c ON c.c_id = sc.c_id 
ORDER BY
    st.s_id,
    c.c_name
```


36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数

```sql
SELECT
    st2.s_id,
    st2.s_name,
    c2.c_name,
    sc2.s_score 
FROM
    student st2
    LEFT JOIN score sc2 ON sc2.s_id = st2.s_id
    LEFT JOIN course c2 ON c2.c_id = sc2.c_id 
WHERE
    st2.s_id IN (
    SELECT
        st.s_id 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id 
    GROUP BY
        st.s_id 
    HAVING
        min( sc.s_score )>= 70 
    ) 
ORDER BY
    s_id
```


37、查询不及格的课程

```sql
SELECT
    st.s_id,
    c.c_name,
    st.s_name,
    sc.s_score 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id 
    AND sc.s_score < 60
    INNER JOIN course c ON c.c_id = sc.c_id
```


38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名

```sql
SELECT
    st.s_id,
    st.s_name,
    sc.s_score 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id 
    AND sc.c_id = "01" 
    AND sc.s_score >= 80
```


39、求每门课程的学生人数

```sql
SELECT
    c.c_id,
    c.c_name,
    count( 1 ) 
FROM
    course c
    INNER JOIN score sc ON sc.c_id = c.c_id 
GROUP BY
    c.c_id
```


40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩

```sql
SELECT
    st.*,
    c.c_name,
    sc.s_score,
    t.t_name 
FROM
    student st
    INNER JOIN score sc ON sc.s_id = st.s_id
    INNER JOIN course c ON c.c_id = sc.c_id
    INNER JOIN teacher t ON t.t_id = c.t_id 
    AND t.t_name = "墨白" 
ORDER BY
    sc.s_score DESC 
    LIMIT 0,1
```


41、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩

```sql
SELECT
    st.s_id,
    st.s_name,
    sc.c_id,
    sc.s_score 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id
    LEFT JOIN course c ON c.c_id = sc.c_id 
WHERE
    (
    SELECT
        count( 1 ) 
    FROM
        student st2
        LEFT JOIN score sc2 ON sc2.s_id = st2.s_id
        LEFT JOIN course c2 ON c2.c_id = sc2.c_id 
    WHERE
        sc.s_score = sc2.s_score 
    AND c.c_id != c2.c_id 
    )>1
```


42、查询每门功成绩最好的前两名

```sql
SELECT
    a.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "01" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
        2 
    ) a UNION ALL
SELECT
    b.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "02" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
        2 
    ) b UNION ALL
SELECT
    c.* 
FROM
    (
    SELECT
        st.s_id,
        st.s_name,
        c.c_name,
        sc.s_score 
    FROM
        student st
        LEFT JOIN score sc ON sc.s_id = st.s_id
        INNER JOIN course c ON c.c_id = sc.c_id 
        AND c.c_id = "03" 
    ORDER BY
        sc.s_score DESC 
        LIMIT 0,
    2 
    ) c
    -- 借鉴(更准确,漂亮):
SELECT
    a.s_id,
    a.c_id,
    a.s_score 
FROM
    score a 
WHERE
    ( SELECT COUNT( 1 ) FROM score b WHERE b.c_id = a.c_id AND b.s_score >= a.s_score )<= 2 
ORDER BY
    a.c_id
```


43、统计每门课程的学生选修人数（超过5人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列

```sql
SELECT
    sc.c_id,
    count( 1 ) 
FROM
    score sc
    LEFT JOIN course c ON c.c_id = sc.c_id 
GROUP BY
    c.c_id 
HAVING
    count( 1 )> 5 
ORDER BY
    count( 1 ) DESC,
    sc.c_id ASC
```


44、检索至少选修两门课程的学生学号

```sql
SELECT
    st.s_id 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
GROUP BY
    st.s_id 
HAVING
    count( 1 )>=2
```


45、查询选修了全部课程的学生信息

```sql
SELECT
    st.* 
FROM
    student st
    LEFT JOIN score sc ON sc.s_id = st.s_id 
GROUP BY
    st.s_id 
HAVING
    count( 1 )=(
    SELECT
        count( 1 ) 
    FROM
    course 
    )
```


46、查询各学生的年龄

```sql
SELECT
    st.*,
    timestampdiff(
        YEAR,
        st.s_birth,
    now()) 
FROM
    student st
```


47、查询本周过生日的学生

```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    WEEK (
    now())= WEEK (
    date_format( st.s_birth, '%Y%m%d' ))
```


48、查询下周过生日的学生

```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    WEEK (
    now())+ 1 = WEEK (
    date_format( st.s_birth, '%Y%m%d' ))
```


49、查询本月过生日的学生

```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    MONTH (
    now())= MONTH (
    date_format( st.s_birth, '%Y%m%d' ))
```


50、查询下月过生日的学生


```sql
SELECT
    st.* 
FROM
    student st 
WHERE
    MONTH (
        timestampadd(
            MONTH,
            1,
        now()))= MONTH (
    date_format( st.s_birth, '%Y%m%d' ))
    -- 或
SELECT
    st.* 
FROM
    student st 
WHERE
    ( MONTH ( now()) + 1 ) MOD 12 = MONTH (
    date_format( st.s_birth, '%Y%m%d' ))
```
