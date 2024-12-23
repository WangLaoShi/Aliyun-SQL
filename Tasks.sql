--------------------------------Task01------------------------------------
-- 创建数据库

CREATE DATABASE shop;


-- 选择使用数据库

use shop;

-- 创建数据库示例，使用编码
CREATE DATABASE dbname DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE TABLE `author` (
    `authorid` char(20) NOT NULL,
    `name` char(20) NOT NULL,
    `age` char(20) NOT NULL,
    `country` char(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- 创建商品表
CREATE TABLE product(
     product_id CHAR(4) NOT NULL,
     product_name VARCHAR(100) NOT NULL,
     product_type VARCHAR(32) NOT NULL,
     sale_price INTEGER,
     purchase_price INTEGER,
     regist_date DATE,
     PRIMARY KEY(product_id)
);

-- 删除表
DROP TABLE product;

-- 修改表结构
ALTER TABLE product ADD COLUMN product_name_pinyin VARCHAR(100);

ALTER TABLE product DROP COLUMN product_name_pinyin;

-- 清空表

TRUNCATE TABLE product;

-- 修改所有的注册时间
UPDATE product
SET regist_date = '2009-10-10';

-- 仅修改部分商品的单价
UPDATE product
SET sale_price = sale_price * 10
WHERE product_type = '厨房用具';

-- 将商品编号为 0008 的数据（圆珠笔）的登记日期更新为 NULL
UPDATE product
SET regist_date = NULL
WHERE product_id = '0008';

-- 合并后的写法
UPDATE product
SET sale_price = sale_price * 10,
    purchase_price = purchase_price / 2
WHERE product_type = '厨房用具';

-- 创建测试表

CREATE TABLE productins(
    product_id     CHAR(4)      NOT NULL,
    product_name   VARCHAR(100) NOT NULL,
    product_type   VARCHAR(32)  NOT NULL,
    sale_price     INTEGER      DEFAULT 0,
    purchase_price INTEGER ,
    regist_date    DATE ,
    PRIMARY KEY (product_id)
);

-- 包含列清单
INSERT INTO productins (
    product_id,
    product_name,
    product_type,
    sale_price,
    purchase_price,
    regist_date)
VALUES (
    '0005',
    '高压锅',
    '厨房用具',
    6800,
    5000,
    '2009-01-15'
);

-- 省略列清单
INSERT INTO productins
VALUES (
    '0005',
    '高压锅',
    '厨房用具',
    6800,
    5000,
    '2009-01-15'
);
-- 通常的 INSERT
INSERT INTO productins
VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');

INSERT INTO productins
VALUES ('0003', '运动 T 恤', '衣服', 4000, 2800, NULL);

INSERT INTO productins
VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');

-- 多行 INSERT （ DB2、SQL、SQL Server、 PostgreSQL 和 MySQL 多行插入）
INSERT INTO productins
VALUES
('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
('0003', '运动 T 恤', '衣服', 4000, 2800, NULL),
('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');


-- 将商品表中的数据复制到商品复制表中
INSERT INTO productcopy (
    product_id,
    product_name,
    product_type,
    sale_price,
    purchase_price,
    regist_date
)
SELECT
    product_id,
    product_name,
    product_type,
    sale_price,
    purchase_price,
    regist_date
FROM Product;

- DML ：插入数据
START TRANSACTION;
INSERT INTO product VALUES('0001', 'T 恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO product VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO product VALUES('0003', '运动 T 恤', '衣服', 4000, 2800, NULL);
INSERT INTO product VALUES('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO product VALUES('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO product VALUES('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO product VALUES('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO product VALUES('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
COMMIT;

-- 主键，自增长属性

CREATE TABLE ai_test(
    ai_id int not null AUTO_INCREMENT,
    ai_unique varchar(20) not null,
    PRIMARY KEY(ai_id),
    CONSTRAINT ai_unique_ui UNIQUE (ai_unique)
)

INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'125');
INSERT INTO ai_test VALUES (0,'126');
INSERT INTO ai_test VALUES (0,'127');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'124');
INSERT INTO ai_test VALUES (0,'128');

-- 创建学生表，主键，自增长
CREATE TABLE students_new(
    student_id int not null AUTO_INCREMENT,
    student_name varchar(20) not null,
    student_age int not null,
    student_weight float not null DEFAULT 99.9,
    PRIMARY KEY(student_id)
);
INSERT INTO students_new(student_name,student_age) VALUES('王菲',19);

INSERT INTO students_new(student_id,student_name,student_age,student_weight) VALUES(5,'张玉婷',22,109.99);

INSERT INTO students_new(student_name,student_age) VALUES('丛老师',26);

INSERT INTO students_new VALUES(0,'杨小辉',3,42);

-- 练习 1-创建表
CREATE TABLE Addressbook(
   regist_no        INTEGER          NOT NULL,
   name             VARCHAR(128)     NOT NULL,
   address          VARCHAR(256)     NOT NULL,
   tel_no           CHAR(10)     ,
   mail_address     CHAR(20)     ,
   PRIMARY KEY (regist_no)
);
-- 练习 1-增加列
-- [MySQL]
ALTER TABLE Addressbook ADD COLUMN postal_code CHAR(8) NOT NULL ;

--------------------------------Task02------------------------------------
-- 用来选取 product_type 列为衣服的记录的 SELECT 语句
SELECT product_name, product_type
FROM product
WHERE product_type = '衣服';

-- 也可以选取出不是查询条件的列（条件列与输出列不同）
SELECT product_name
FROM product
WHERE product_type = '衣服';

-- SQL 语句可以使用 AS 关键字为列设定别名（用中文时需要双引号（""））。
SELECT product_id     AS id,
       product_name   AS name,
       purchase_price AS "进货单价"
FROM product;

-- 使用 DISTINCT 剔除 product_type 列中重复的数据
SELECT DISTINCT product_type
FROM product;

-- 选取出 sale_price 列为 500 的记录
SELECT product_name, product_type
FROM product
WHERE sale_price = 500;

-- SQL 语句中也可以使用运算表达式
SELECT
    product_name,
    sale_price,
    sale_price * 2 AS "sale_price x2"
FROM product;

-- WHERE 子句的条件表达式中也可以使用计算表达式
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price-purchase_price >= 500;

-- 选取 NULL 的记录
SELECT product_name,purchase_price
FROM product
WHERE purchase_price IS NULL;

-- 选取不为 NULL 的记录
SELECT product_name,purchase_price
FROM product
WHERE purchase_price IS NOT NULL;

-- 选取出销售单价大于等于 1000 元的记录
SELECT product_name, product_type, sale_price
FROM product
WHERE sale_price >= 1000;

-- 向上面代码清单的查询条件中添加 NOT 运算符
SELECT product_name, product_type, sale_price
FROM product
WHERE NOT sale_price >= 1000;

-- 将查询条件原封不动地写入条件表达式，会得到错误结果
SELECT product_name, product_type, regist_date
FROM product
WHERE product_type = '办公用品'
AND regist_date = '2009-09-11'
OR regist_date = '2009-09-20';

-- 通过使用括号让 OR 运算符先于 AND 运算符执行
SELECT product_name, product_type, regist_date
FROM product
WHERE product_type = '办公用品'
AND ( regist_date = '2009-09-11'
OR regist_date = '2009-09-20');

-- 练习二

SELECT product_name, regist_date
FROM product
WHERE regist_date > '2009-04-28';

SELECT *
FROM product
WHERE purchase_price = NULL;

SELECT *
FROM product
WHERE purchase_price <> NULL;

SELECT *
FROM product
WHERE product_name > NULL;


-- SELECT 语句 1
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price >= purchase_price + 500;

-- SELECT 语句 2
SELECT product_name, sale_price, purchase_price
FROM product
WHERE sale_price - 500 >= purchase_price;

-- 从 product 表中选取出满足“销售单价打九折之后利润高于 100 元的办公用品和厨房用具”条件的记录
SELECT product_name, product_type,
       sale_price * 0.9 - purchase_price AS profit
FROM product
WHERE sale_price * 0.9 - purchase_price > 100
   AND (product_type = '办公用品'
        OR product_type = '厨房用具');


-- 计算全部数据的行数（包含 NULL）
SELECT COUNT(*)
FROM product;

-- 计算 NULL 以外数据的行数
SELECT COUNT(purchase_price)
FROM product;

-- 计算销售单价和进货单价的合计值
SELECT SUM(sale_price), SUM(purchase_price)
FROM product;

-- 计算销售单价和进货单价的平均值
SELECT AVG(sale_price), AVG(purchase_price)
FROM product;

-- MAX 和 MIN 也可用于非数值型数据
SELECT MAX(regist_date), MIN(regist_date)
FROM product;

-- 计算去除重复数据后的数据行数
SELECT COUNT(DISTINCT product_type)
FROM product;

-- 是否使用 DISTINCT 时的动作差异（SUM 函数）
SELECT SUM(sale_price), SUM(DISTINCT sale_price)
FROM product;

-- 按照商品种类统计数据行数
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type;

-- 不含 GROUP BY
SELECT product_type, COUNT(*)
FROM product;

-- 包含 NULL 值

SELECT purchase_price, COUNT(*)
FROM product
GROUP BY purchase_price;

-- GROUP BY 对筛选出的数据进行处理
SELECT purchase_price, COUNT(*)
FROM product
WHERE product_type = '衣服'
GROUP BY purchase_price;

-- 错误形式（因为 product_name 不包含在 GROUP BY 聚合键中）
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type
HAVING product_name = '圆珠笔';

-- 降序排列
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY sale_price DESC;

-- 多个排序键
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY sale_price, product_id;

-- 当用于排序的列名中含有 NULL 时，NULL 会在开头或末尾进行汇总。
SELECT product_id, product_name, sale_price, purchase_price
FROM product
ORDER BY purchase_price;

-- 练习 3 请编写一条 SELECT 语句，求出销售单价（sale_price 列）合计值大于进货单价（purchase_price 列）
-- 合计值 1.5 倍的商品种类。执行结果如下所示。

SELECT product_type, SUM(sale_price),SUM(purchase_price)
FROM product
GROUP BY product_type
HAVING SUM(sale_price) > SUM(purchase_price) * 1.5;


---------------------------Task03-----------------------------------

CREATE VIEW productsum (product_type, cnt_product)
AS
SELECT product_type, COUNT(*)
FROM product
GROUP BY product_type
ORDER BY product_type;

-- 创建商店表

CREATE TABLE shop_product(
  shop_id    CHAR(4)       NOT NULL,
  shop_name  VARCHAR(200)  NOT NULL,
  product_id CHAR(4)       NOT NULL,
  quantity   INTEGER       NOT NULL,
  PRIMARY KEY (shop_id, product_id)
);

INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A','东京','0001',30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A','东京','0002',50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A','东京','0003',15);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B','名古屋','0002',30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B','名古屋','0003',120);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B','名古屋','0004',20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B','名古屋','0006',10);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B','名古屋','0007',40);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C','大阪','0003',20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C','大阪','0004',50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C','大阪','0006',90);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C','大阪','0007',70);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000D','福冈','0001',100);

-- 创建视图，来自于 product 表和 shop 表

CREATE VIEW view_shop_product(product_type, sale_price, shop_name)
AS
SELECT product_type, sale_price, shop_name
FROM product,shop_product
WHERE product.product_id = shop_product.product_id;

-- 视图上查询
SELECT sale_price, shop_name
FROM view_shop_product
WHERE product_type = '衣服';

-- 更新视图

UPDATE productsum
SET sale_price = '5000'
WHERE product_type = '办公用品';

-- 删除视图

DROP VIEW productSum;

-- 嵌套子查询

SELECT product_type, cnt_product
FROM (SELECT *
    FROM (
            SELECT product_type, COUNT(*) AS cnt_product
            FROM product
            GROUP BY product_type
          ) AS productsum
    WHERE cnt_product = 4
    ) AS productsum2;

-- 标量子查询
SELECT product_id, product_name, sale_price
FROM product
WHERE sale_price > (
  SELECT AVG(sale_price) FROM product
);

-- 标量子查询

SELECT product_id,
     product_name,
     sale_price,
     (SELECT AVG(sale_price) FROM product) AS avg_price
FROM product;

-- 关联子查询,`选取出各商品种类中高于该商品种类的平均销售单价的商品`
SELECT product_type, product_name, sale_price
FROM product AS p1
WHERE sale_price > (SELECT AVG(sale_price)
                  FROM product AS p2
                  WHERE p1.product_type = p2.product_type
                  GROUP BY product_type);

-- `查询出销售单价高于平均销售单价的商品`

SELECT product_id, product_name, sale_price
FROM product
WHERE sale_price > (SELECT AVG(sale_price) FROM product);

-- 练习 3 -- 创建视图

CREATE VIEW ViewPractice5_1 AS
SELECT product_name, sale_price, regist_date
FROM product
WHERE sale_price >= 1000
AND regist_date = '2009-09-20';

-- 创建表

-- DDL ：创建表
USE shop;
DROP TABLE IF EXISTS samplemath;
CREATE TABLE samplemath(
  m float(10,3),
  n INT,
  p INT
);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO samplemath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO samplemath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT; -- 提交事务

SELECT
m,
ABS(m) AS abs_col ,
n,
p,
MOD(n, p) AS mod_col,
ROUND(m,1) AS round_colS
FROM samplemath;


-- 创建数学函数表
-- DDL ：创建表
USE  shop;

DROP TABLE IF EXISTS samplestr;
CREATE TABLE samplestr(
  str1 VARCHAR (40),
  str2 VARCHAR (40),
  str3 VARCHAR (40)
);

-- DML：插入数据
START TRANSACTION;
INSERT INTO samplestr (str1, str2, str3) VALUES ('opx',	'rt', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('太阳',	'月亮', '火星');
INSERT INTO samplestr (str1, str2, str3) VALUES ('aaa',	NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES (NULL, 'xyz', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc 哈哈',  'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('abcdefabc', 'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('micmic', 'i', 'I');
COMMIT;

-- 函数

SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2);

SELECT SUBSTRING_INDEX('www.mysql.com', '.', -2);

SELECT SUBSTRING_INDEX('www.mysql.com', '.', 1);

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('www.mysql.com', '.', 2), '.', -1);

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;

SELECT CURRENT_TIMESTAMP AS now,
EXTRACT(YEAR   FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH  FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY    FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR   FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS MINute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;

SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;
SELECT CAST('2009-12-14' AS DATE) AS date_col;
SELECT
COALESCE(NULL, 11) AS col_1,
COALESCE(NULL, 'hello world', NULL) AS col_2,
COALESCE(NULL, NULL, '2020-11-01') AS col_3;

-- 创建谓词查询表

-- DDL ：创建表
  CREATE TABLE samplelike(
      strcol VARCHAR(6) NOT NULL,
      PRIMARY KEY (strcol)
  );

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO samplelike (strcol) VALUES ('abcddd');
INSERT INTO samplelike (strcol) VALUES ('dddabc');
INSERT INTO samplelike (strcol) VALUES ('abdddc');
INSERT INTO samplelike (strcol) VALUES ('abcdd');
INSERT INTO samplelike (strcol) VALUES ('ddabc');
INSERT INTO samplelike (strcol) VALUES ('abddc');
COMMIT; -- 提交事务

SELECT * FROM samplelike;

-- 前方一致：选取出“dddabc”

SELECT *
FROM samplelike
WHERE strcol LIKE 'ddd%';

-- 中间一致：选取出“abcddd”,“dddabc”,“abdddc”

SELECT *
FROM samplelike
WHERE strcol LIKE '%ddd%';

-- 后方一致：选取出“abcddd“

SELECT *
FROM samplelike
WHERE strcol LIKE '%ddd';

-- 选取销售单价为 100～ 1000 元的商品
SELECT product_name, sale_price
FROM product
WHERE sale_price BETWEEN 100 AND 1000;

-- 如果不想让结果中包含临界值，那就必须使用 `<` 和 `>`。
SELECT product_name, sale_price
FROM product
WHERE sale_price > 100
    AND sale_price < 1000;

-- 为了选取出某些值为 NULL 的列的数据，不能使用 `=`，而只能使用特定的谓词 **IS NULL**。
SELECT product_name, purchase_price
FROM product
WHERE purchase_price IS NULL;

-- 想要选取 NULL 以外的数据时，需要使用 `IS NOT NULL`。
SELECT product_name, purchase_price
FROM product
WHERE purchase_price IS NOT NULL;

-- 多个查询条件取并集时可以选择使用 `or` 语句。
-- 通过 OR 指定多个进货单价进行查询
SELECT product_name, purchase_price
FROM product
WHERE purchase_price = 320
    OR purchase_price = 500
    OR purchase_price = 5000;

SELECT product_name, purchase_price
FROM product
WHERE purchase_price IN (320, 500, 5000);

-- “进货单价不是 320 元、 500 元、 5000 元”的商品时，可以使用否定形式 NOT IN 来实现。
SELECT product_name, purchase_price
FROM product
WHERE purchase_price NOT IN (320, 500, 5000);


-- DDL ：创建表
DROP TABLE IF EXISTS shop_product;

CREATE TABLE shop_product(
  shop_id CHAR(4)     NOT NULL,
  shop_name VARCHAR(200) NOT NULL,
  product_id CHAR(4)      NOT NULL,
  quantity INTEGER      NOT NULL,
  PRIMARY KEY (shop_id, product_id) -- 指定主键
);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000A', '东京', '0001', 30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000A', '东京', '0002', 50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000A', '东京', '0003', 15);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000B', '名古屋', '0002', 30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000B', '名古屋', '0003', 120);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000B', '名古屋', '0004', 20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000B', '名古屋', '0006', 10);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000B', '名古屋', '0007', 40);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000C', '大阪', '0003', 20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000C', '大阪', '0004', 50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000C', '大阪', '0006', 90);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000C', '大阪', '0007', 70);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity)
VALUES ('000D', '福冈', '0001', 100);
COMMIT; -- 提交事务


SELECT * FROM shop_product;

-- step1：取出大阪门店的在售商品 `product_id`
SELECT product_id
FROM shop_product
WHERE shop_id = '000C';

-- step2：取出大阪门店在售商品的销售单价 `sale_price`
SELECT product_name, sale_price
FROM product
WHERE product_id IN (SELECT product_id
                   FROM shop_product
                   WHERE shop_id = '000C');

-- 子查询展开后的结果
SELECT product_name, sale_price
FROM product
WHERE product_id IN ('0003', '0004', '0006', '0007');

-- NOT IN 使用子查询作为参数，取出未在大阪门店销售的商品的销售单价
SELECT product_name, sale_price
FROM product
WHERE product_id NOT IN (SELECT product_id
                       FROM shop_product
                       WHERE shop_id = '000A');

-- 使用 EXIST 选取出大阪门店在售商品的销售单价。
SELECT product_name, sale_price
FROM product AS p
WHERE EXISTS (SELECT *
           FROM shop_product AS sp
           WHERE sp.shop_id = '000C'
                 AND sp.product_id = p.product_id
           );

-- 更高效率的写法
SELECT product_name, sale_price
FROM product AS p
WHERE EXISTS (SELECT 1 -- 这里可以书写适当的常数
           FROM shop_product AS sp
           WHERE sp.shop_id = '000C'
               AND sp.product_id = p.product_id);

-- 就像 EXIST 可以用来替换 IN 一样，NOT IN 也可以用 NOT EXIST 来替换。
SELECT product_name, sale_price
FROM product AS p
WHERE NOT EXISTS (SELECT *
               FROM shop_product AS sp
               WHERE sp.shop_id = '000A'
                   AND sp.product_id = p.product_id);



-- 应用场景 1：根据不同分支得到不同列值
SELECT  product_name,
     CASE
         WHEN product_type = '衣服'     THEN CONCAT('A ：',product_type)
         WHEN product_type = '办公用品'  THEN CONCAT('B ：',product_type)
         WHEN product_type = '厨房用具'  THEN CONCAT('C ：',product_type)
         ELSE NULL
     END

     AS abc_product_type
FROM  product;

-- 应用场景 2：实现列方向上的聚合

SELECT product_type,
     SUM(sale_price) AS sum_price
FROM product
GROUP BY product_type;

-- 对按照商品种类计算出的销售单价合计值进行行列转换
SELECT
      SUM(CASE WHEN product_type = '衣服' THEN sale_price ELSE 0 END)    AS sum_price_clothes,
      SUM(CASE WHEN product_type = '厨房用具' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
      SUM(CASE WHEN product_type = '办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
FROM product;


--------------------------Task04---------------------------
-- 创建商品表2
CREATE TABLE product2(
     product_id CHAR(4) NOT NULL,
     product_name VARCHAR(100) NOT NULL,
     product_type VARCHAR(32) NOT NULL,
     sale_price INTEGER,
     purchase_price INTEGER,
     regist_date DATE,
     PRIMARY KEY(product_id)
);
-- 插入数据
INSERT INTO product2 VALUES('0001', 'T 恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO product2 VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO product2 VALUES('0003', '运动 T 恤', '衣服', 4000, 2800, NULL);
INSERT INTO product2 VALUES('0009', '手套', '衣服', 500, 800, NULL);
INSERT INTO product2 VALUES('0010', '水壶', '厨房用具', 1700, 2000, '2009-09-20');


-- 假设连锁店想要增加毛利率超过 50% 或者售价低于 800 的货物的存货量，请使用 UNION 对分别满足上述两个条件的商品的查询结果求并集。

SELECT  product_id,product_name,product_type,sale_price,purchase_price
FROM product
WHERE sale_price<800;

UNION

SELECT  product_id,product_name,product_type,sale_price,purchase_price
FROM product
WHERE sale_price>1.5*purchase_price;

-- 参考答案:
SELECT  product_id,product_name,product_type,sale_price,purchase_price
FROM product
WHERE sale_price < 800
    OR sale_price > 1.5 * purchase_price;

-- 找出毛利率不足 30% 或毛利率未知的商品。
-- 使用 OR 谓词
SELECT *
FROM product
WHERE sale_price / purchase_price < 1.3
    OR sale_price / purchase_price IS NULL;

-- 使用 UNION
SELECT *
FROM product
WHERE sale_price / purchase_price < 1.3

UNION

SELECT *
FROM product
WHERE sale_price / purchase_price IS NULL;

-- 商店决定对 product 表中利润低于 50% 和售价低于 1000 的商品提价，请使用 UNION ALL 语句将分别满足上述两个条件的结果取并集。

SELECT *
FROM product
WHERE sale_price < 1000

UNION ALL

SELECT *
FROM product
WHERE sale_price > 1.5 * purchase_price;

-- 说明时间日期类型和字符串，数值以及缺失值均能兼容
SELECT SYSDATE(), SYSDATE(), SYSDATE()
UNION
SELECT 'chars', 123,  null;

-- 找出只存在于 product 表但不存在于 product2 表的商品。
SELECT *
FROM product
WHERE product_id NOT IN (SELECT product_id
                            FROM product2);

-- 使用 NOT 谓词进行集合的减法运算，求出 product 表中，售价高于 2000, 但利润不低于 30% 的商品，结果应该如下表所示。
SELECT *
FROM product
WHERE sale_price > 2000
   AND product_id NOT IN (
        SELECT product_id
        FROM product
        WHERE sale_price < 1.3*purchase_price);

-- 使用 AND 谓词查找 product 表中利润率高于 50%, 并且售价低于 1500 的商品，查询结果如下所示。

SELECT *
FROM product
WHERE sale_price > 1.5 * purchase_price
   AND sale_price < 1500;

-- 使用 product 表和 product2 表的对称差来查询哪些商品只在其中一张表，
-- 使用 NOT IN 实现两个表的差集。
-- 使用 NOT IN 实现两个表的差集
SELECT *
FROM product
WHERE product_id NOT IN (
    SELECT product_id FROM product2)

UNION

SELECT *
FROM product2
WHERE product_id NOT IN (
    SELECT product_id FROM product)


-- 内连接
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM shop_product AS SP
INNER JOIN product AS P
ON SP.product_id = P.product_id;

-- 内连接

SELECT *
FROM (-- 第一步查询的结果
        SELECT SP.shop_id
               ,SP.shop_name
               ,SP.product_id
               ,P.product_name
               ,P.product_type
               ,P.sale_price
               ,SP.quantity
         FROM shop_product AS SP
         INNER JOIN product AS P
            ON SP.product_id = P.product_id) AS STEP1
WHERE shop_name = '东京'
    AND product_type = '衣服' ;

-- 内连接
SELECT  SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM shop_product AS SP
INNER JOIN product AS P
    ON SP.product_id = P.product_id
WHERE SP.shop_name = '东京'
   AND P.product_type = '衣服' ;

-- 内连接
SELECT SP.shop_id
           ,SP.shop_name
           ,SP.product_id
           ,P.product_name
           ,P.product_type
           ,P.sale_price
           ,SP.quantity
    FROM shop_product AS SP
    INNER JOIN product AS P
        ON (SP.product_id = P.product_id
       AND SP.shop_name = '东京'
       AND P.product_type = '衣服') ;

-- 内连接
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
FROM (-- 子查询 1: 从 shop_product 表筛选出东京商店的信息
        SELECT *
        FROM shop_product
        WHERE shop_name = '东京' ) AS SP
INNER JOIN -- 子查询 2: 从 product 表筛选出衣服类商品的信息
    (SELECT *
     FROM product
     WHERE product_type = '衣服') AS P

ON SP.product_id = P.product_id;

-- 每个商店中，售价最高的商品的售价分别是多少?
SELECT SP.shop_id
      ,SP.shop_name
      ,MAX(P.sale_price) AS max_price
FROM shop_product AS SP

    INNER JOIN product AS P

    ON SP.product_id = P.product_id

GROUP BY SP.shop_id,SP.shop_name

-- 找出每个商品种类当中售价高于该类商品的平均售价的商品。当时我们是使用关联子查询来实现的。
SELECT
    product_type,
    product_name,
    sale_price
FROM product AS P1

WHERE sale_price > (SELECT AVG(sale_price)
                    FROM product AS P2
                    WHERE P1.product_type = P2.product_type
                    GROUP BY product_type);

-- 使用 GROUP BY 按商品类别分类计算每类商品的平均价格。
SELECT
        product_type,
        AVG(sale_price) AS avg_price
FROM product
GROUP BY product_type;

-- 将上述查询与表 product 按照 product_type (商品种类)进行内连结。
SELECT  P1.product_id,
        P1.product_name,
        P1.product_type,
        P1.sale_price,
        P2.avg_price
FROM product AS P1

    INNER JOIN
       (SELECT product_type,AVG(sale_price) AS avg_price
        FROM product
        GROUP BY product_type) AS P2

    ON P1.product_type = P2.product_type;

-- 增加 WHERE 子句，找出那些售价高于该类商品平均价格的商品。完整的代码如下:
SELECT  P1.product_id,
        P1.product_name,
        P1.product_type,
        P1.sale_price,
        P2.avg_price
FROM product AS P1

    INNER JOIN (SELECT product_type,AVG(sale_price) AS avg_price
                FROM product
                GROUP BY product_type) AS P2

    ON P1.product_type = P2.product_type

WHERE P1.sale_price > P2.avg_price;

-- 使用连结求交集
SELECT P1.*

FROM product AS P1

    INNER JOIN product2 AS P2

    ON (P1.product_id  = P2.product_id
       AND P1.product_name = P2.product_name
       AND P1.product_type = P2.product_type
       AND P1.sale_price   = P2.sale_price
       AND P1.regist_date  = P2.regist_date)

-- 统计每种商品分别在哪些商店有售，需要包括那些在每个商店都没货的商品。
SELECT
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
FROM product AS P

    LEFT OUTER JOIN shop_product AS SP

    ON SP.product_id = P.product_id;

-- 左外连接，使用外连结从 **shop_product** 表和 **product** 表中找出那些在某个商店库存少于 50 的商品及对应的商店。希望得到如下结果。
-- 错误的做法
SELECT
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        SP.quantity
FROM product AS P

    LEFT OUTER JOIN shop_product AS SP

    ON SP.product_id = P.product_id

    WHERE quantity< 50;

-- 正确的做法
SELECT
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        SP.quantity
FROM product AS P

    LEFT OUTER JOIN -- 先筛选 quantity<50 的商品
       (SELECT *
        FROM shop_product
        WHERE quantity < 50 ) AS SP

    ON SP.product_id = P.product_id;

-- 创建关联表
CREATE TABLE Inventoryproduct(
    inventory_id       CHAR(4) NOT NULL,
    product_id         CHAR(4) NOT NULL,
    inventory_quantity INTEGER NOT NULL,
    PRIMARY KEY (inventory_id, product_id)
    );

--- DML：插入数据
START TRANSACTION;
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0001', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0002', 120);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0003', 200);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0004', 3);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0005', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0006', 99);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0007', 999);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0008', 200);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0001', 10);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0002', 25);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0003', 34);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0004', 19);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0005', 99);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0006', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0007', 0);
INSERT INTO Inventoryproduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0008', 18);
COMMIT;

-- 我们根据上表及 shop_product 表和 product 表，使用内连接找出每个商店都有那些商品，每种商品的库存总量分别是多少。
SELECT
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price,
        IP.inventory_quantity
FROM shop_product AS SP

    INNER JOIN product AS P

    ON SP.product_id = P.product_id

    INNER JOIN Inventoryproduct AS IP

    ON SP.product_id = IP.product_id

WHERE IP.inventory_id = 'P001';

-- 多表进行外连结
SELECT
        P.product_id,
        P.product_name,
        P.sale_price,
        SP.shop_id,
        SP.shop_name,
        IP.inventory_quantity
FROM product AS P

    LEFT OUTER JOIN shop_product AS SP

    ON SP.product_id = P.product_id

    LEFT OUTER JOIN Inventoryproduct AS IP

    ON SP.product_id = IP.product_id;

-- 对每一种商品，找出售价不低于它的所有商品，然后对售价不低于它的商品使用 COUNT 函数计数。
SELECT
        product_id,
        product_name,
        sale_price,
        COUNT(p2_id) AS rank_id
FROM (-- 使用自左连结对每种商品找出价格不低于它的商品
        SELECT
                P1.product_id,
                P1.product_name,
                P1.sale_price,
                P2.product_id AS P2_id,
                P2.product_name AS P2_name,
                P2.sale_price AS P2_price
        FROM product AS P1

        LEFT OUTER JOIN product AS P2

        ON P1.sale_price <= P2.sale_price
        ) AS X

GROUP BY product_id, product_name, sale_price

ORDER BY rank_id;

-- 对每种商品使用自左连结，找出比该商品售价价格更低或相等的商品
SELECT
        P1.product_id,
        P1.product_name,
        P1.sale_price,
        P2.product_id AS P2_id,
        P2.product_name AS P2_name,
        P2.sale_price AS P2_price
FROM product AS P1

LEFT OUTER JOIN product AS P2

ON P1.sale_price >= P2.sale_price

ORDER BY P1.sale_price,P1.product_id;

--下一步，按照 P1.product_id 分组，对 P2_price 求和
SELECT
        product_id,
        product_name,
        sale_price,
        SUM(P2_price) AS cum_price
FROM (SELECT
            P1.product_id,
            P1.product_name,
            P1.sale_price,
            P2.product_id AS P2_id,
            P2.product_name AS P2_name,
            P2.sale_price AS P2_price
        FROM product AS P1
        LEFT OUTER JOIN product AS P2
        ON P1.sale_price >= P2.sale_price
        ORDER BY P1.sale_price,P1.product_id
        ) AS X

GROUP BY product_id, product_name, sale_price

ORDER BY sale_price,product_id;

-- 改写
SELECT
            product_id,
            product_name,
            sale_price,
            SUM(P2_price) AS cum_price
FROM(
        SELECT
                P1.product_id,
                P1.product_name,
                P1.sale_price,
                P2.product_id AS P2_id,
                P2.product_name AS P2_name,
                P2.sale_price AS P2_price
        FROM product AS P1

        LEFT OUTER JOIN product AS P2
        ON ((P1.sale_price > P2.sale_price)
            OR (P1.sale_price = P2.sale_price
            AND P1.product_id<=P2.product_id))
            ORDER BY P1.sale_price,P1.product_id
    ) AS X

GROUP BY product_id, product_name, sale_price

ORDER BY sale_price,cum_price;


-- 1. 使用关键字 CROSS JOIN 显式地进行交叉连结
SELECT
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price

FROM shop_product AS SP

CROSS JOIN product AS P;

--2. 使用逗号分隔两个表，并省略 ON 子句
SELECT
        SP.shop_id,
        SP.shop_name,
        SP.product_id,
        P.product_name,
        P.sale_price
FROM shop_product AS SP ,product AS P;

-- 找出 product 和 product2 中售价高于 500 的商品的基本信息。
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM product
WHERE sale_price > 500

UNION

SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM product2
WHERE sale_price > 500;

-- 借助对称差的实现方式，求 product 和 product2 的交集
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM product
WHERE (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
      IN (SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date FROM product2)

UNION ALL

SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
FROM product2
WHERE (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
      IN (SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date FROM product);

-- 每类商品中售价最高的商品都在哪些商店有售 ？
SELECT sp.shop_id, sp.shop_name, p_all.product_type, p_all.product_id, sp.quantity
FROM shop_product AS sp
JOIN (
    -- 合并 product 和 product2 表，并找到每类商品中售价最高的商品
    SELECT product_type, product_id, sale_price
    FROM product
    WHERE (product_type, sale_price) IN (
        SELECT product_type, MAX(sale_price)
        FROM (
            SELECT product_type, sale_price FROM product
            UNION ALL
            SELECT product_type, sale_price FROM product2
        ) AS all_products
        GROUP BY product_type
    )
) AS p_all ON sp.product_id = p_all.product_id;

-- 分别使用内连结和关联子查询每一类商品中售价最高的商品。
-- 使用内连接
SELECT p.product_type, p.product_id, p.product_name, p.sale_price
FROM (
    SELECT product_type, MAX(sale_price) AS max_price
    FROM (
        SELECT product_type, product_id, product_name, sale_price FROM product
        UNION ALL
        SELECT product_type, product_id, product_name, sale_price FROM product2
    ) AS all_products
    GROUP BY product_type
) AS max_prices
JOIN (
    SELECT product_type, product_id, product_name, sale_price
    FROM product
    UNION ALL
    SELECT product_type, product_id, product_name, sale_price
    FROM product2
) AS p ON p.product_type = max_prices.product_type AND p.sale_price = max_prices.max_price;

-- 使用关联子查询
SELECT product_type, product_id, product_name, sale_price
FROM (
    SELECT product_type, product_id, product_name, sale_price FROM product
    UNION ALL
    SELECT product_type, product_id, product_name, sale_price FROM product2
) AS all_products
WHERE sale_price = (
    SELECT MAX(sale_price)
    FROM (
        SELECT sale_price
        FROM product
        WHERE product_type = all_products.product_type
        UNION ALL
        SELECT sale_price
        FROM product2
        WHERE product_type = all_products.product_type
    ) AS type_prices
);

-- 用关联子查询实现：在 `product` 表中，取出 product_id, produc_name, sale_price, 并按照商品的售价从低到高进行排序、对售价进行累计求和。

SELECT p.product_id, p.product_name, p.sale_price,
       (SELECT SUM(sale_price)
        FROM product AS p2
        WHERE p2.sale_price <= p.sale_price) AS cumulative_sum
FROM product AS p
ORDER BY p.sale_price ASC;

----------------------------Task05--------------------------
SELECT
        product_name,
        product_type,
        sale_price,
        RANK() OVER (
            PARTITION BY product_type
            ORDER BY sale_price) AS ranking
FROM product;

-- 定义窗口名称

SELECT * FROM(
    SELECT
      ROW_NUMBER() OVER w as row_num,
      order_id,
      user_no,
      amount,
      create_date
    FROM order_tab
    WINDOW w AS (PARTITION BY user_no ORDER BY amount desc)
) t ;

-- 排序函数
SELECT
        product_name,
        product_type,
        sale_price,
        RANK() OVER (ORDER BY sale_price) AS ranking,
        DENSE_RANK() OVER (ORDER BY sale_price) AS dense_ranking ,
        ROW_NUMBER() OVER (ORDER BY sale_price) AS row_num
FROM product;

-- 聚合函数的窗口化
SELECT
        product_id,
        product_name,
        sale_price,
        SUM(sale_price) OVER (ORDER BY product_id) AS current_sum,
        AVG(sale_price) OVER (ORDER BY product_id) AS current_avg
FROM product;

-- 滑动窗口
SELECT
        product_id,
        product_name,
        sale_price,
        AVG(sale_price) OVER (
                            ORDER BY product_id
                            ROWS 2 PRECEDING) AS moving_avg,
        AVG(sale_price) OVER (
                            ORDER BY product_id
                            ROWS BETWEEN 1 PRECEDING
                                 AND 1 FOLLOWING) AS moving_avg
FROM product;

-- 小计合计
SELECT
        product_type,
        regist_date,
        SUM(sale_price) AS sum_price
FROM product
GROUP BY product_type, regist_date
WITH ROLLUP;