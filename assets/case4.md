##  其他
### 返回今日风险数据和整体风险数据


#### 示例请求Python代码

```python
import requests

# 定义API的URL
url = "http://platform.blue16.cn:8090/api/v1/report/risk/date/{date}"

# 替换URL中的日期占位符为实际日期
date_to_query = "2023-01-01"  # 示例日期，你可以修改为任何你想查询的日期
url = url.format(date=date_to_query)

# 定义请求头部
headers = {
    "Content-Type": "application/json"
}

# 发送POST请求
response = requests.post(url, headers=headers)


# 打印响应结果
print(response.status_code)
print(response.json())
```


#### 返回结果
```python
200
{'id': '66a7b4f5d6ecb522c96102ed',
'date': '2023-01-01', 'total': 120, 
'lowRisk': 75, 'mediumRisk': 30, 'highRisk': 15,
'cases': [{'type': '假冒客服诈骗', 'count': 45}, 
{'type': '虚假中奖信息诈骗', 'count': 30},
{'type': '冒充公检法机关诈骗', 'count': 25}]}
```

### 获取可疑信息统计记录


#### 示例请求Python代码

```python
import requests

# 定义API的URL
url = "http://platform.blue16.cn:8090/api/v1/risk/content"

# 定义请求头部
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
    "date": "2023-01-01",
    "type": "msg"
}

# 发送POST请求
response = requests.post(url, json=payload, headers=headers)


# 打印响应结果
print(response.status_code)
print(response.json())
```


#### 返回结果
```python
200
[{'id': 'sms123', 'count': 5, 
'type': '诈骗', 'summary': '中奖通知，要求先支付税费。'},
{'id': 'sms456', 'count': 3,
'type': '骚扰', 'summary': '多次发送垃圾广告信息。'}]
```


### 获取全部省份/各省份详细风险数量统计


#### 示例请求Python代码

```python
import requests

# 定义API的URL
url = "http://platform.blue16.cn:8090/api/v1/report/risk/region/{area}"

# 替换URL中的日期占位符为实际日期
area_to_query = "total"  # 示例区域
url = url.format(area=area_to_query)

# 定义请求头部
headers = {
    "Content-Type": "application/json"
}

# 发送POST请求
response = requests.post(url, headers=headers)


# 打印响应结果
print(response.status_code)
print(response.json())
```


#### 返回结果
```python
200
[{'id': '66a7af32d6ecb522c96102ba',
'province': 'total', 'area': '四川', 'safe': 150, 'risk': 30}]
```


### 获取日期区间内每日情况分布


#### 示例请求Python代码

```python
import requests


# 定义API的URL
url = "http://platform.blue16.cn:8090/api/fraud-statistics/range"

# 定义请求头部
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
  "start_date": "2023-01-01",
  "end_date": "2023-01-07"
}



# 发送POST请求
response = requests.post(url, json=payload, headers=headers)


# 打印响应结果
print(response.status_code)
print(response.json())
```


#### 返回结果
```python

```
