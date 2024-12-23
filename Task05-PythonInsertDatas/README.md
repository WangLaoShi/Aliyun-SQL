# 介绍

## 背景

```sql
CREATE TABLE user_trade
(
user_name varchar(20),
piece int,
price double,
pay_amount double,
goods_category varchar(20),
pay_time date
);
```

这是一个数据表的结构，我现在需要使用 Python 程序编写一个插入模拟数据的代码，我可以给你一个数据库的链接字符串，需要链接上这个数据库，并且创建数据表，然后使用 Fake 程序，生成对应的模拟数据，记录数控制在 3000 条，pay_time 从 2018 年开始到 2020 年底。

## 如何使用

### 创建虚拟环境

确保你的电脑上已经具备了 **Python** 环境。

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

### 安装依赖

```bash
pip install -r requirements.txt
```

### 运行脚本

注意修改代码中的，connection_string 为正确的值。

```shell
python FakerData.py
```