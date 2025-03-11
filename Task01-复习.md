![sbuHgE](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/sbuHgE.png)

![MFkoMF](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/MFkoMF.png)

![5iLSBO](https://upiclw.oss-cn-beijing.aliyuncs.com/uPic/5iLSBO.png)

```sql
CREATE TABLE `chapter6`(
    `order_id` int(11) NOT NULL COMMENT '订单ID',
    `date` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '下单日期',
    `value` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单金额',
    `memberid` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '会员ID',
    `age` int(11) NOT NULL COMMENT '会员年龄',
    `sex` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '性别',
    `profession` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '所在行业信息'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `chapter6` (`order_id`, `date`, `value`, `memberid`, `age`, `sex`, `profession`）VALUES
(2469, '2017/4/5', '9.32', '90D24', 35, '男', '森林业'),
(112471, '2017/4/5', '26.396', '9548A', 16, '女', '建筑工程业'),
(112471, '2017/4/5', '26.396', '9548A', 16, '女', '建筑工程业'),
(112472, '2017/4/6', '100.14', '4819C', 44, '女', '公共事业'),
(112473, '2017/4/6', '6.52', '6915B', 40, '男', '娱乐业'),
(112473, '2017/4/6', '6.52', '6915B', 40, '男', '娱乐业'),
(112475, '2017/4/7', '34.965', '14EB2', 45, '男', ''),
(112476, '2017/4/7', '30.785', '91DF6', 22, '男', '新闻广告业'),
(112477, '2017/4/7', '2.62', '50C86', 16, '女', '');
```