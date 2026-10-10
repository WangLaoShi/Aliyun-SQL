## 查询题目与解答

> 数据库：MySQL  
> 涉及表：`Student`（学生）、`Course`（课程）、`Teacher`（教师）、`Score`（成绩）

---

### 1. 查询课程编号为"01"的课程比"02"的课程成绩高的所有学生的学号

**思路：** 对 `Score` 表做自连接，同一学生分别取出课程 01 和课程 02 的成绩，比较前者是否大于后者。

```sql
-- 自连接：a 表取 01 课成绩，b 表取 02 课成绩，通过 s_id 关联同一学生
SELECT
    a.s_id                          -- 学号
FROM Score a
INNER JOIN Score b
    ON a.s_id = b.s_id              -- 同一学生
WHERE a.c_id = '01'                 -- a 为语文（01）成绩
  AND b.c_id = '02'                 -- b 为数学（02）成绩
  AND a.s_score > b.s_score;        -- 01 课成绩 > 02 课成绩
```

---

### 2. 查询平均成绩大于60分的学生的学号和平均成绩

**思路：** 按学号分组，计算 AVG，用 HAVING 过滤平均值大于 60 的记录。

```sql
SELECT
    s_id,                           -- 学号
    AVG(s_score) AS avg_score       -- 平均成绩
FROM Score
GROUP BY s_id                       -- 按学生分组
HAVING AVG(s_score) > 60;            -- 筛选平均成绩 > 60 的学生
```

---

### 3. 查询所有学生的学号、姓名、选课数、总成绩

**思路：** 以 `Student` 为主表 LEFT JOIN `Score`，保证没有选课记录的学生（如 08 号王菊）也能出现；用 COUNT 统计选课数，SUM 统计总成绩。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    COUNT(sc.c_id) AS course_count, -- 选课数（无选课时为 0）
    IFNULL(SUM(sc.s_score), 0) AS total_score  -- 总成绩（无选课时为 0）
FROM Student s
LEFT JOIN Score sc
    ON s.s_id = sc.s_id             -- 左连接保留全部学生
GROUP BY s.s_id, s.s_name;
```

---

### 4. 查询姓"猴"的老师的个数

**思路：** 在 `Teacher` 表中用 `LIKE '猴%'` 匹配姓"猴"的老师，再 COUNT 统计。（当前测试数据中无姓"猴"的老师，结果为 0）

```sql
SELECT
    COUNT(*) AS teacher_count       -- 姓"猴"的老师人数
FROM Teacher
WHERE t_name LIKE '猴%';            -- 姓名以"猴"开头
```

---

### 6. 查询学过"张三"老师所教的所有课的同学的学号、姓名

**思路：** 先找出张三老师所教课程总数，再找出选修了**全部**这些课程的学生（关系除法思想：HAVING COUNT = 课程总数）。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
WHERE s.s_id IN (
    SELECT sc.s_id
    FROM Score sc
    WHERE sc.c_id IN (
        -- 子查询：张三老师（t_id='01'）所教的所有课程编号
        SELECT c_id
        FROM Course
        WHERE t_id = (
            SELECT t_id FROM Teacher WHERE t_name = '张三'
        )
    )
    GROUP BY sc.s_id
    HAVING COUNT(DISTINCT sc.c_id) = (
        -- 张三老师所教课程的总数，用于判断是否"学全"
        SELECT COUNT(*)
        FROM Course
        WHERE t_id = (
            SELECT t_id FROM Teacher WHERE t_name = '张三'
        )
    )
);
```

---

### 7. 查询学过编号为"01"的课程并且也学过编号为"02"的课程的学生的学号、姓名

**思路：** 同一学生分别 INNER JOIN 两次 `Score`，一次过滤 c_id='01'，一次过滤 c_id='02'。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
INNER JOIN Score sc1
    ON s.s_id = sc1.s_id AND sc1.c_id = '01'  -- 学过 01 课
INNER JOIN Score sc2
    ON s.s_id = sc2.s_id AND sc2.c_id = '02'; -- 同时学过 02 课
```

---

### 8. 查询学过编号为"01"的课程, 但没学过编号为"02"的课程的学生的学号、姓名

**思路：** 学过 01 课的学生集合，减去学过 02 课的学生集合（NOT IN 或 NOT EXISTS）。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
WHERE s.s_id IN (
    SELECT s_id FROM Score WHERE c_id = '01'   -- 学过 01 课
)
AND s.s_id NOT IN (
    SELECT s_id FROM Score WHERE c_id = '02'   -- 未学过 02 课
);
```

---

### 9. 查询课程编号为"02"的总成绩

**思路：** 对 c_id='02' 的所有成绩直接 SUM 求和。

```sql
SELECT
    SUM(s_score) AS total_score     -- 02 号课程（数学）总成绩
FROM Score
WHERE c_id = '02';
```

---

### 10. 查询所有课程成绩小于60分(全部课程不及格)的学生的学号、姓名

**思路：** "全部课程不及格"意味着该学生**每一门**已选课程成绩都 < 60，等价于 MAX(成绩) < 60。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
GROUP BY s.s_id, s.s_name
HAVING MAX(sc.s_score) < 60;        -- 最高成绩仍低于 60，说明全部不及格
```

---

### 11. 查询没有学全所有课的学生的学号、姓名

**思路：** 统计每个学生选修的不同课程数，与 `Course` 表总课程数比较，少于总数即为"没学全"。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
LEFT JOIN Score sc
    ON s.s_id = sc.s_id
GROUP BY s.s_id, s.s_name
HAVING COUNT(DISTINCT sc.c_id) < (
    SELECT COUNT(*) FROM Course      -- 全部课程总数（当前为 3）
);
```

---

### 12. 查询至少有一门课与学号为"01"的学生所学课程相同的学生的学号和姓名

**思路：** 先取出 01 号学生选修的所有 c_id，再找出选修了其中至少一门课的其他学生。

```sql
SELECT DISTINCT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
WHERE sc.c_id IN (
    SELECT c_id
    FROM Score
    WHERE s_id = '01'               -- 01 号同学选修的所有课程
);
```

---

### 13. 查询和"01"号同学所学课程完全相同的其他同学的学号

**思路：** 将每个学生的选课列表排序后拼接成字符串，与 01 号同学的选课字符串比较，完全相同即为"所学课程完全一致"。

```sql
SELECT
    t.s_id                          -- 学号
FROM (
    -- 子查询：每个学生的选课列表（按 c_id 排序后拼接）
    SELECT
        s_id,
        GROUP_CONCAT(c_id ORDER BY c_id) AS courses
    FROM Score
    GROUP BY s_id
) t
WHERE t.courses = (
    -- 01 号同学的选课列表
    SELECT GROUP_CONCAT(c_id ORDER BY c_id)
    FROM Score
    WHERE s_id = '01'
    GROUP BY s_id
)
AND t.s_id != '01';                 -- 排除 01 号本人
```

---

### 14. 查询没学过"张三"老师讲授的任一门课程的学生姓名

**思路：** 找出张三老师所教全部课程的选修学生，再从 `Student` 中排除这些学生。

```sql
SELECT
    s_name                          -- 姓名
FROM Student
WHERE s_id NOT IN (
    SELECT sc.s_id
    FROM Score sc
    WHERE sc.c_id IN (
        SELECT c_id
        FROM Course
        WHERE t_id = (
            SELECT t_id FROM Teacher WHERE t_name = '张三'
        )
    )
);
```

---

### 15. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

**思路：** 先找出不及格（< 60）课程数 >= 2 的学号，再关联学生表计算平均成绩。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    ROUND(AVG(sc.s_score), 2) AS avg_score  -- 平均成绩
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
WHERE s.s_id IN (
    SELECT s_id
    FROM Score
    WHERE s_score < 60              -- 不及格
    GROUP BY s_id
    HAVING COUNT(*) >= 2            -- 两门及其以上不及格
)
GROUP BY s.s_id, s.s_name;
```

---

### 16. 检索"01"课程分数小于60，按分数降序排列的学生信息

**思路：** 关联 `Student` 与 `Score`，过滤 c_id='01' 且 s_score < 60，按成绩降序排列。

```sql
SELECT
    s.*                             -- 学生全部字段信息
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
WHERE sc.c_id = '01'                -- 语文（01）课程
  AND sc.s_score < 60               -- 分数低于 60
ORDER BY sc.s_score DESC;            -- 按分数降序
```

---

### 17. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

**思路：** 使用窗口函数 `AVG() OVER (PARTITION BY s_id)` 为每行附加该学生的平均成绩，再按平均成绩降序排列。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    sc.c_id,                        -- 课程编号
    sc.s_score,                     -- 该课程成绩
    ROUND(
        AVG(sc.s_score) OVER (PARTITION BY s.s_id),
        2
    ) AS avg_score                  -- 该学生的平均成绩（窗口函数）
FROM Student s
LEFT JOIN Score sc
    ON s.s_id = sc.s_id             -- 左连接保留无选课的学生
ORDER BY avg_score DESC, s.s_id, sc.c_id;
```

---

### 18. 查询各科成绩最高分、最低分和平均分

**思路：** 按 c_id 分组，分别用 MAX、MIN、AVG 聚合。

```sql
SELECT
    c_id,                           -- 课程编号
    MAX(s_score) AS max_score,      -- 最高分
    MIN(s_score) AS min_score,      -- 最低分
    ROUND(AVG(s_score), 2) AS avg_score  -- 平均分
FROM Score
GROUP BY c_id;
```

---

### 19. 按各科成绩进行排序，并显示排名

**思路：** 使用 `RANK()` 窗口函数，按课程分区、按成绩降序排名（并列时跳号）。

```sql
SELECT
    s_id,                           -- 学号
    c_id,                           -- 课程编号
    s_score,                        -- 成绩
    RANK() OVER (
        PARTITION BY c_id            -- 每门课程内独立排名
        ORDER BY s_score DESC
    ) AS ranking                    -- 排名（并列跳号）
FROM Score;
```

---

### 20. 查询学生的总成绩并进行排名

**思路：** 先按学号分组求 SUM 总成绩，再用 `RANK()` 对总成绩降序排名。

```sql
SELECT
    s_id,                           -- 学号
    SUM(s_score) AS total_score,    -- 总成绩
    RANK() OVER (
        ORDER BY SUM(s_score) DESC  -- 按总成绩降序排名
    ) AS ranking
FROM Score
GROUP BY s_id;
```

---

### 21. 查询不同老师所教不同课程平均分从高到低显示

**思路：** 三表关联 `Course` + `Teacher` + `Score`，按教师和课程分组求 AVG，再降序排列。

```sql
SELECT
    t.t_name,                       -- 教师姓名
    c.c_name,                       -- 课程名称
    ROUND(AVG(sc.s_score), 2) AS avg_score  -- 该课程平均分
FROM Course c
INNER JOIN Teacher t
    ON c.t_id = t.t_id              -- 关联授课教师
INNER JOIN Score sc
    ON c.c_id = sc.c_id              -- 关联成绩
GROUP BY t.t_id, t.t_name, c.c_id, c.c_name
ORDER BY avg_score DESC;            -- 平均分从高到低
```

---

### 22. 查询所有课程的成绩第2名到第3名的学生信息及该课程成绩

**思路：** 用 `RANK()` 对每门课排名，外层过滤 rk BETWEEN 2 AND 3。

```sql
SELECT
    s_id,                           -- 学号
    s_name,                         -- 姓名
    c_id,                           -- 课程编号
    s_score,                        -- 成绩
    rk                              -- 排名
FROM (
    SELECT
        s.s_id,
        s.s_name,
        sc.c_id,
        sc.s_score,
        RANK() OVER (
            PARTITION BY sc.c_id
            ORDER BY sc.s_score DESC
        ) AS rk
    FROM Score sc
    INNER JOIN Student s ON sc.s_id = s.s_id
) t
WHERE rk BETWEEN 2 AND 3;            -- 第 2 名到第 3 名
```

---

### 23. 使用分段[100-85],[85-70],[70-60],[<60]来统计各科成绩，分别统计各分数段人数：课程ID和课程名称

**思路：** 用 `CASE WHEN` 条件计数，将成绩划分到四个区间（85 分归入最高段）。

```sql
SELECT
    c.c_id,                         -- 课程编号
    c.c_name,                       -- 课程名称
    SUM(CASE WHEN sc.s_score >= 85 THEN 1 ELSE 0 END) AS '100-85',  -- 85~100 分人数
    SUM(CASE WHEN sc.s_score >= 70 AND sc.s_score < 85 THEN 1 ELSE 0 END) AS '85-70',
    SUM(CASE WHEN sc.s_score >= 60 AND sc.s_score < 70 THEN 1 ELSE 0 END) AS '70-60',
    SUM(CASE WHEN sc.s_score < 60 THEN 1 ELSE 0 END) AS '60以下'
FROM Course c
LEFT JOIN Score sc
    ON c.c_id = sc.c_id             -- 左连接保证无成绩的课程也显示
GROUP BY c.c_id, c.c_name;
```

---

### 24. 查询学生平均成绩及其名次

**思路：** 分组求 AVG 后，用 `RANK()` 窗口函数对平均成绩排名。

```sql
SELECT
    s_id,                           -- 学号
    ROUND(AVG(s_score), 2) AS avg_score,  -- 平均成绩
    RANK() OVER (
        ORDER BY AVG(s_score) DESC  -- 按平均成绩降序排名
    ) AS ranking
FROM Score
GROUP BY s_id;
```

---

### 25. 查询各科成绩前三名的记录（不考虑成绩并列情况）

**思路：** 使用 `ROW_NUMBER()`（不考虑并列，相同分数也会给出不同序号），取 rn <= 3。

```sql
SELECT
    s_id,                           -- 学号
    c_id,                           -- 课程编号
    s_score,                        -- 成绩
    rn                              -- 名次
FROM (
    SELECT
        s_id,
        c_id,
        s_score,
        ROW_NUMBER() OVER (
            PARTITION BY c_id
            ORDER BY s_score DESC   -- 每门课内按成绩降序编号
        ) AS rn
    FROM Score
) t
WHERE rn <= 3;                      -- 取前三名
```

---

### 26. 查询每门课程被选修的学生数

**思路：** 按 c_id 分组，COUNT 统计选修人数。

```sql
SELECT
    c_id,                           -- 课程编号
    COUNT(s_id) AS student_count    -- 选修学生数
FROM Score
GROUP BY c_id;
```

---

### 27. 查询出只有两门课程的全部学生的学号和姓名

**思路：** 按学生分组，HAVING COUNT(DISTINCT c_id) = 2。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
GROUP BY s.s_id, s.s_name
HAVING COUNT(DISTINCT sc.c_id) = 2; -- 恰好选修 2 门课
```

---

### 28. 查询男生、女生人数

**思路：** 按 s_sex 分组 COUNT。

```sql
SELECT
    s_sex,                          -- 性别
    COUNT(*) AS count               -- 人数
FROM Student
GROUP BY s_sex;
```

---

### 29. 查询名字中含有"风"字的学生信息

**思路：** 用 `LIKE '%风%'` 模糊匹配姓名。

```sql
SELECT
    *                               -- 学生全部信息
FROM Student
WHERE s_name LIKE '%风%';           -- 姓名中包含"风"字
```

---

### 31. 查询1990年出生的学生名单

**思路：** s_birth 为字符串类型，用 `LIKE '1990%'` 匹配出生年份。

```sql
SELECT
    *                               -- 学生全部信息
FROM Student
WHERE s_birth LIKE '1990%';         -- 出生日期以 1990 开头
```

---

### 32. 查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩

**思路：** 关联学生表与成绩表，分组求 AVG，HAVING 过滤 >= 85。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    ROUND(AVG(sc.s_score), 2) AS avg_score  -- 平均成绩
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
GROUP BY s.s_id, s.s_name
HAVING AVG(sc.s_score) >= 85;       -- 平均成绩 >= 85
```

---

### 33. 查询每门课程的平均成绩，结果按平均成绩升序排序，平均成绩相同时，按课程号降序排列

**思路：** GROUP BY c_id 求 AVG，ORDER BY 先 avg_score ASC，再 c_id DESC。

```sql
SELECT
    c_id,                           -- 课程编号
    ROUND(AVG(s_score), 2) AS avg_score  -- 平均成绩
FROM Score
GROUP BY c_id
ORDER BY avg_score ASC, c_id DESC;  -- 平均分升序，相同则课程号降序
```

---

### 34. 查询课程名称为"数学"，且分数低于60的学生姓名和分数

**思路：** 三表关联，通过 c_name='数学' 定位课程，过滤 s_score < 60。

```sql
SELECT
    s.s_name,                       -- 学生姓名
    sc.s_score                      -- 数学成绩
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
INNER JOIN Course c
    ON sc.c_id = c.c_id
WHERE c.c_name = '数学'             -- 课程为数学
  AND sc.s_score < 60;               -- 分数低于 60
```

---

### 35. 查询所有学生的课程及分数情况

**思路：** 学生表与课程表做笛卡尔积（CROSS JOIN），再 LEFT JOIN 成绩表，无成绩显示 NULL。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    c.c_name,                       -- 课程名称
    sc.s_score                      -- 成绩（未选修则为 NULL）
FROM Student s
CROSS JOIN Course c                 -- 每位学生 × 每门课程
LEFT JOIN Score sc
    ON s.s_id = sc.s_id AND c.c_id = sc.c_id
ORDER BY s.s_id, c.c_id;
```

---

### 36. 查询任何一门课程成绩在70分以上的姓名、课程名称和分数

**思路：** 三表关联，过滤 s_score > 70（严格大于 70 分）。

```sql
SELECT
    s.s_name,                       -- 姓名
    c.c_name,                       -- 课程名称
    sc.s_score                      -- 分数
FROM Score sc
INNER JOIN Student s ON sc.s_id = s.s_id
INNER JOIN Course c ON sc.c_id = c.c_id
WHERE sc.s_score > 70;              -- 成绩在 70 分以上（不含 70）
```

---

### 37. 查询不及格的课程并按课程号从大到小排列

**思路：** 直接从 `Score` 过滤 s_score < 60，ORDER BY c_id DESC。

```sql
SELECT
    s_id,                           -- 学号
    c_id,                           -- 课程编号
    s_score                         -- 成绩
FROM Score
WHERE s_score < 60                  -- 不及格（低于 60 分）
ORDER BY c_id DESC;                 -- 课程号从大到小
```

---

### 38. 查询课程编号为03且课程成绩在80分以上的学生的学号和姓名

**思路：** 关联学生表与成绩表，过滤 c_id='03' 且 s_score >= 80。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name                        -- 姓名
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
WHERE sc.c_id = '03'                -- 英语（03）课程
  AND sc.s_score >= 80;              -- 成绩 80 分及以上
```

---

### 39. 求每门课程的学生人数

**思路：** 与第 26 题相同，按 c_id 分组 COUNT。

```sql
SELECT
    c_id,                           -- 课程编号
    COUNT(s_id) AS student_num      -- 选修人数
FROM Score
GROUP BY c_id;
```

---

### 40. 查询选修"张三"老师所授课程的学生中成绩最高的学生姓名及其成绩

**思路：** 找出张三所教课程的全部成绩，按 s_score 降序取 LIMIT 1。

```sql
SELECT
    s.s_name,                       -- 学生姓名
    sc.s_score                      -- 最高成绩
FROM Score sc
INNER JOIN Student s
    ON sc.s_id = s.s_id
WHERE sc.c_id IN (
    SELECT c_id
    FROM Course
    WHERE t_id = (
        SELECT t_id FROM Teacher WHERE t_name = '张三'
    )
)
ORDER BY sc.s_score DESC
LIMIT 1;                            -- 取成绩最高的一条
```

---

### 41. 查询某个学生不同课程但成绩相同的学生编号、课程编号、学生成绩

**思路：** `Score` 表自连接，同一学生（s_id 相同）、不同课程（c_id 不同）、成绩相同（s_score 相等）。

```sql
SELECT
    a.s_id,                         -- 学号
    a.c_id,                         -- 课程编号
    a.s_score                       -- 相同成绩
FROM Score a
INNER JOIN Score b
    ON a.s_id = b.s_id              -- 同一学生
   AND a.c_id < b.c_id              -- 不同课程（避免重复配对）
   AND a.s_score = b.s_score;       -- 成绩相同
```

---

### 42. 查询每门课程成绩最好的前两名

**思路：** 用 `DENSE_RANK()` 按课程分区排名（并列时不跳号），取 rk <= 2。

```sql
SELECT
    s_id,                           -- 学号
    s_name,                         -- 姓名
    c_id,                           -- 课程编号
    s_score,                        -- 成绩
    rk                              -- 排名
FROM (
    SELECT
        sc.s_id,
        s.s_name,
        sc.c_id,
        sc.s_score,
        DENSE_RANK() OVER (
            PARTITION BY sc.c_id
            ORDER BY sc.s_score DESC
        ) AS rk
    FROM Score sc
    INNER JOIN Student s ON sc.s_id = s.s_id
) t
WHERE rk <= 2;                      -- 每门课前两名
```

---

### 43. 统计每门课程的学生选修人数（超过5人的课程才统计）

**思路：** 分组 COUNT 后，HAVING COUNT > 5 过滤。

```sql
SELECT
    c_id,                           -- 课程编号
    COUNT(s_id) AS student_count    -- 选修人数
FROM Score
GROUP BY c_id
HAVING COUNT(s_id) > 5;             -- 仅统计超过 5 人的课程
```

---

### 44. 检索至少选修两门课程的学生学号

**思路：** 按 s_id 分组，HAVING COUNT(c_id) >= 2。

```sql
SELECT
    s_id                            -- 学号
FROM Score
GROUP BY s_id
HAVING COUNT(c_id) >= 2;            -- 至少选修 2 门课
```

---

### 45. 查询选修了全部课程的学生信息

**思路：** 学生选修的不同课程数 = Course 表总课程数，即为选修了全部课程。

```sql
SELECT
    s.*                             -- 学生全部信息
FROM Student s
WHERE s.s_id IN (
    SELECT sc.s_id
    FROM Score sc
    GROUP BY sc.s_id
    HAVING COUNT(DISTINCT sc.c_id) = (
        SELECT COUNT(*) FROM Course  -- 全部课程总数
    )
);
```

---

### 46. 查询没学过"张三"老师讲授的任一门课程的学生姓名

**思路：** 与第 14 题相同，排除选修了张三所教课程的学生。

```sql
SELECT
    s_name                          -- 姓名
FROM Student
WHERE s_id NOT IN (
    SELECT sc.s_id
    FROM Score sc
    WHERE sc.c_id IN (
        SELECT c_id
        FROM Course
        WHERE t_id = (
            SELECT t_id FROM Teacher WHERE t_name = '张三'
        )
    )
);
```

---

### 47. 查询两门以上不及格课程的同学的学号, 姓名及其平均成绩

**思路：** 与第 15 题的区别在于"两门以上"指严格大于 2 门（>= 3 门不及格）。

```sql
SELECT
    s.s_id,                         -- 学号
    s.s_name,                       -- 姓名
    ROUND(AVG(sc.s_score), 2) AS avg_score  -- 平均成绩
FROM Student s
INNER JOIN Score sc
    ON s.s_id = sc.s_id
WHERE s.s_id IN (
    SELECT s_id
    FROM Score
    WHERE s_score < 60              -- 不及格
    GROUP BY s_id
    HAVING COUNT(*) > 2             -- 两门以上（> 2，即至少 3 门不及格）
)
GROUP BY s.s_id, s.s_name;
```

---

### 48. 查询各学生的年龄

**思路：** s_birth 为字符串，先用 `STR_TO_DATE` 转为日期，再用 `TIMESTAMPDIFF(YEAR, ..., CURDATE())` 计算年龄。

```sql
SELECT
    s_id,                           -- 学号
    s_name,                         -- 姓名
    s_birth,                        -- 出生日期
    TIMESTAMPDIFF(
        YEAR,
        STR_TO_DATE(s_birth, '%Y-%m-%d'),  -- 字符串转日期
        CURDATE()                   -- 当前日期
    ) AS age                        -- 年龄（周岁）
FROM Student;
```

---

### 49. 查询本月过生日的学生

**思路：** 提取出生日期的月份，与当前月份 `MONTH(CURDATE())` 比较。

```sql
SELECT
    *                               -- 学生全部信息
FROM Student
WHERE MONTH(
    STR_TO_DATE(s_birth, '%Y-%m-%d')  -- 将出生日期转为 DATE 类型
) = MONTH(CURDATE());               -- 出生月份 = 当前月份
```

---

### 50. 查询下月过生日的学生

**思路：** 出生月份 = 当前月份 + 1；12 月时需特殊处理（下月为 1 月）。

```sql
SELECT
    *                               -- 学生全部信息
FROM Student
WHERE MONTH(
    STR_TO_DATE(s_birth, '%Y-%m-%d')
) = MONTH(DATE_ADD(CURDATE(), INTERVAL 1 MONTH));  -- 出生月份 = 下个月
```
