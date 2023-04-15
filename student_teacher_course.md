## 建表语句

```sql
/******************************************/
/*   DatabaseName = studentcourse   */
/*   TableName = teacher   */
/******************************************/
CREATE TABLE `teacher` (
  `tno` int NOT NULL,
  `tname` varchar(20) NOT NULL,
  PRIMARY KEY (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;

/******************************************/
/*   DatabaseName = studentcourse   */
/*   TableName = course   */
/******************************************/
CREATE TABLE `course` (
  `cno` int NOT NULL,
  `cname` varchar(50) NOT NULL,
  `tno` int NOT NULL,
  PRIMARY KEY (`cno`),
  KEY `course_tno` (`tno`),
  CONSTRAINT `course_tno` FOREIGN KEY (`tno`) REFERENCES `teacher` (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;



/******************************************/
/*   DatabaseName = studentcourse   */
/*   TableName = students   */
/******************************************/
CREATE TABLE `students` (
  `sno` int NOT NULL,
  `sname` varchar(20) NOT NULL,
  `sage` date NOT NULL,
  `ssex` char(2) NOT NULL,
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='学生表'
;


/******************************************/
/*   DatabaseName = studentcourse   */
/*   TableName = sc   */
/******************************************/
CREATE TABLE `sc` (
  `sno` int NOT NULL,
  `cno` int NOT NULL,
  `score` float NOT NULL,
  KEY `sc_student_fk` (`sno`),
  KEY `sc_course_fk` (`cno`),
  CONSTRAINT `sc_course_fk` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`),
  CONSTRAINT `sc_student_fk` FOREIGN KEY (`sno`) REFERENCES `students` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;





```




## 插入数据

```sql

SET FOREIGN_KEY_CHECKS=0;
TRUNCATE course;
TRUNCATE  sc;
TRUNCATE students;
TRUNCATE teacher;
SET FOREIGN_KEY_CHECKS=0;

--插入数据
INSERT INTO teacher(tno,tname)VALUES(1,'张三');
INSERT INTO teacher(tno,tname)VALUES(2,'王五');
INSERT INTO teacher(tno,tname)VALUES(3,'李四');
INSERT INTO teacher(tno,tname)VALUES(4,'赵六');
INSERT INTO teacher(tno,tname)VALUES(5,'刘老师');
INSERT INTO teacher(tno,tname)VALUES(6,'向老师');
INSERT INTO teacher(tno,tname)VALUES(7,'李文静');
INSERT INTO teacher(tno,tname)VALUES(8,'叶平');



--插入数据
INSERT INTO students(sno,sname,sage,ssex) VALUES(1,'张某','1980-1-23','男');
INSERT INTO students(sno,sname,sage,ssex) VALUES(2,'李某','1982-12-12','男');
INSERT INTO students(sno,sname,sage,ssex) VALUES(3,'张飒','1981-9-9','男');
INSERT INTO students(sno,sname,sage,ssex) VALUES(4,'莉莉','1983-3-23','女');
INSERT INTO students(sno,sname,sage,ssex) VALUES(5,'王弼','1982-6-21','男');
INSERT INTO students(sno,sname,sage,ssex) VALUES(6,'王丽','1984-10-10','女');
INSERT INTO students(sno,sname,sage,ssex) VALUES(7,'刘香','1980-12-22','女');

--插入数据
insert into course(cno,cname,tno) values(1,'企业管理',3);
insert into course(cno,cname,tno) values(2,'马克思',1);
insert into course(cno,cname,tno) values(3,'UML',2);
insert into course(cno,cname,tno) values(4,'数据库',5);
insert into course(cno,cname,tno) values(5,'物理',8);


--插入数据
INSERT INTO sc(sno,cno,score)VALUES(1,1,80);
INSERT INTO sc(sno,cno,score)VALUES(1,2,86);
INSERT INTO sc(sno,cno,score)VALUES(1,3,83);
INSERT INTO sc(sno,cno,score)VALUES(1,4,89);

INSERT INTO sc(sno,cno,score)VALUES(2,1,50);
INSERT INTO sc(sno,cno,score)VALUES(2,2,36);
--INSERT INTO sc(sno,cno,score)VALUES(2,3,43);
INSERT INTO sc(sno,cno,score)VALUES(2,4,59);

INSERT INTO sc(sno,cno,score)VALUES(3,1,50);
INSERT INTO sc(sno,cno,score)VALUES(3,2,96);
--INSERT INTO sc(sno,cno,score)VALUES(3,3,73)
INSERT INTO sc(sno,cno,score)VALUES(3,4,69);

INSERT INTO sc(sno,cno,score)VALUES(4,1,90);
INSERT INTO sc(sno,cno,score)VALUES(4,2,36);
INSERT INTO sc(sno,cno,score)VALUES(4,3,88);
--INSERT INTO sc(sno,cno,score)VALUES(4,4,99);

INSERT INTO sc(sno,cno,score)VALUES(5,1,90);
INSERT INTO sc(sno,cno,score)VALUES(5,2,96);
INSERT INTO sc(sno,cno,score)VALUES(5,3,98);
INSERT INTO sc(sno,cno,score)VALUES(5,4,99);

INSERT INTO sc(sno,cno,score)VALUES(6,1,70);
INSERT INTO sc(sno,cno,score)VALUES(6,2,66);
INSERT INTO sc(sno,cno,score)VALUES(6,3,58);
INSERT INTO sc(sno,cno,score)VALUES(6,4,79);

INSERT INTO sc(sno,cno,score)VALUES(7,1,80);
INSERT INTO sc(sno,cno,score)VALUES(7,2,76);
INSERT INTO sc(sno,cno,score)VALUES(7,3,68);
INSERT INTO sc(sno,cno,score)VALUES(7,4,59);
INSERT INTO sc(sno,cno,score)VALUES(7,5,89);


```
