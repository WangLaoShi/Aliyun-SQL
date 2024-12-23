import faker
import random
from sqlalchemy import create_engine, text
from datetime import datetime

# 数据库连接字符串
connection_string = "mysql+pymysql://username:password@host:port/database"

# 创建数据库引擎
engine = create_engine(connection_string)

# 创建表的 SQL 语句
create_table_query = text("""
CREATE TABLE IF NOT EXISTS user_trade
(
    user_name VARCHAR(20),
    piece INT,
    price DOUBLE,
    pay_amount DOUBLE,
    goods_category VARCHAR(20),
    pay_time DATE
);
""")

# 执行创建表的语句
with engine.connect() as conn:
    conn.execute(create_table_query)

# 使用 Faker 生成模拟数据
fake = faker.Faker()

# 模拟数据生成
categories = ["Electronics", "Books", "Clothing", "Sports", "Furniture"]
data = []

for _ in range(3000):
    user_name = fake.user_name()
    piece = random.randint(1, 10)
    price = round(random.uniform(5, 500), 2)
    pay_amount = round(piece * price, 2)
    goods_category = random.choice(categories)
    pay_time = fake.date_between_dates(
        date_start=datetime(2018, 1, 1), date_end=datetime(2020, 12, 31)
    )
    data.append({
        "user_name": user_name,
        "piece": piece,
        "price": price,
        "pay_amount": pay_amount,
        "goods_category": goods_category,
        "pay_time": pay_time
    })

# 插入数据的 SQL 语句
insert_query = text("""
INSERT INTO user_trade (user_name, piece, price, pay_amount, goods_category, pay_time)
VALUES (:user_name, :piece, :price, :pay_amount, :goods_category, :pay_time);
""")

# 批量插入数据
with engine.connect() as conn:
    with conn.begin():  # 使用事务
        for record in data:
            conn.execute(insert_query, record)

print("3000 条模拟数据插入成功。")