## 风险内容识别

### 文本内容


#### 示例请求Python代码
```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/risk/text"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
  "content": "一些示例文本，可能包含敏感词汇或需要评估的内容。",
  "date": "2024-7-31",
  "province": "四川省",
  "area": "眉山市"
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
{'risk': True, 'riskLevel': '中度风险',
'riskPercentage': 0.532,
'briefSuggestion': '建议审查政治敏感内容',
'comprehensiveAnalysis': '文本包含政治敏感话题及可能引起争议的表述，
建议进行内容修改，以降低潜在的风险。', 
'adviceList': [{'category': '高风险提示', 
'keyword': '政治敏感话题', 'reason': '涉及政治敏感内容可能违反相关法规'}, 
{'category': '中风险提示', 'keyword': '侮辱性语言',
'reason': '含有侮辱性语言可能会引发法律纠纷'}]}
```



### 图片内容-通用图片


#### 示例请求Python代码

```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/risk/image"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
  "content": "/TestData/Picture/risk.png",
  "date": "2024-7-31",
  "province":"四川省",
  "area": "眉山市"
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
{'risk': True, 'riskLevel': '极度危险',
'riskPercentage': 0.955, 
'briefSugestion': '请立即删除并举报该信息！',
'comprehensiveAnalysis': '这是一个典型的诈骗短信，
声称您在庆祝XX电商成立10周年的活动中获奖，
并要求您提供个人信息和银行账户。这是骗子试图诱骗您转账的行为。', 
'adviceList': [{'category': '高风险提示', 'keyword': '中奖通知', 
'reason': '此类消息通常与诈骗活动相关联。'}, {'category': '高风险提示',
'keyword': '客服电话',
'reason': '提供的客服电话可能用于骗取您的信任并诱导您进一步操作。'},
{'category': '高风险提示', 'keyword': '身份验证码',
'reason': '要求提供身份验证码是常见的诈骗手法，骗子可以利用这些信息进行非法活动。'
}]}

```

### 视频内容——基于关键帧


#### 示例请求Python代码

```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/risk/video/frame"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
    "frames": [
        "https://so1.360tres.com/dr/270_500_/t01da3c6ca7c4c4d229.jpg?size=542x479",
        "https://so1.360tres.com/dr/270_500_/t01da3c6ca7c4c4d229.jpg?size=542x479"
    ]
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
{'risk': True, 'riskLevel': '极度危险',
'riskPercentage': 0.955, 'briefSuggestion': '避免靠近瀑布水域', 
'comprehensiveAnalysis': '综合分析识别出的风险点，
船只在水流湍急且岩石突出的瀑布附近航行，存在极高的安全风险。
建议船只远离瀑布，确保视线清晰，避免水雾及强水流的冲击。', 
'adviceList': [{'category': '高风险提示', 'keyword': '船只',
'reason': '在瀑布附近的水域航行，面临被水流冲走或撞上岩石的危险。'}, 
{'category': '中风险提示', 'keyword': '水花',
'reason': '水花和雾气可能遮挡视线，影响驾驶员的判断和操作。'}, 
{'category': '高风险提示', 'keyword': '尼亚加拉大瀑布',
'reason': '瀑布周围岩石突出，水流湍急，环境非常危险。'}, 
{'category': '安全风险提示', 'keyword': '船只靠近瀑布', 
'reason': '船只靠近瀑布可能会被水雾喷溅，甚至可能被卷入漩涡中造成安全事故。'}]}

```



### 视频内容——基于源文件


#### 示例请求Python代码

```python

```


#### 返回结果
```python

```


### 音频内容


#### 示例请求Python代码

```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/risk/audio"
headers = {
    "Content-Type": "application/json"
}


# 定义请求体
payload = {
  "content": "/TestData/Audio/TestAudio.mp3",
  "date": "2024-7-31",
  "province": "四川省",
  "area":"眉山市"
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
{'risk': True, 'riskLevel': '极度危险',
'riskPercentage': 0.955, 
'briefSuggestion': '立即停止，切勿提供信息',
'comprehensiveAnalysis': '该文本涉及明显的诈骗行为，
切勿向任何可疑来源提供个人银行信息。
建议立即停止所有操作，并及时与中国银行官方联系确认账户安全。', 
'adviceList': [{'category': '高风险提示',
'keyword': '提供银行卡号、密码',
'reason': '真实客服不会要求客户提供密码等敏感信息。'}, 
{'category': '高风险提示', 'keyword': '手机验证码',
'reason': '验证码是账户安全的最后防线，不应轻易泄露。'},
{'category': '高风险提示', 'keyword': '账户冻结威胁', 
'reason': '通常诈骗者会使用紧急或威胁手段，迫使受害者尽快行动。'}]}
```



### 实时号码检测/增量检测


#### 示例请求Python代码

```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/fraud-detection"
headers = {
    "Content-Type": "application/json"
}


# 定义请求体
payload = {
  "sessionID": "1234567890",
  "phoneNumber": "13800138000",
  "textContent": "您好，我是税务局，您有一笔未缴税款，请尽快处理。"
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

