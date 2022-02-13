本笔记为阿里云天池龙珠计划SQL训练营的学习内容，链接为：https://tianchi.aliyun.com/specials/promotion/aicampsql
# Task06：综合练习题-10道经典题目

下载相关创建表格和插入数据脚本

这里为了方便大家，数据脚本已经给大家准备好啦。
点击下方链接直接下载
创建数据表脚本：http://tianchi-media.oss-cn-beijing.aliyuncs.com/dragonball/SQL/create_table.sql
插入数据脚本：http://tianchi-media.oss-cn-beijing.aliyuncs.com/dragonball/SQL/data.zip

大家下载好脚本后，先在MySQL环境中运行create_table.sql脚本，创建数据表，然后解压下载好的data.zip，解压后目录如下：


| 章节 | 脚本  |
|---|---|
| 8，10 | ccf_offline_stage1_train.sql |
| 6 | winequality-white.sql |
| 5,8,10 | ccf_online_stage1_train.sql |
| 4 | macro industry.sql |
| 3 | ccf_offline_stage1_test_revised.sql |
| 2 | winequality-red.sql |
| 1,9 | income statement.sql |
| 1,7 | market data.sql |


脚本文件名前面的序号表示用到该数据集的题目序号，例如`1,7 market data.sql`表示第1题和第7题用到了该数据集。  
同样的，这里给大家的也是sql脚本，里面是插入数据的语句，大家只需打开后在MySQL环境中运行即可将数据导入到数据表中。

## 练习题1

数据来源：https://tianchi.aliyun.com/dataset/dataDetail?dataId=1074

请使用A股上市公司季度营收预测数据集《Income Statement.xls》和《Company Operating.xlsx》和《Market Data.xlsx》，以Market Data为主表，将三张表中的TICKER_SYMBOL为600383和600048的信息合并在一起。只需要显示以下字段。
