## AI生成内容识别
### 文本/短信内容
#### 请求路径

#### 示例请求Python代码
```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/ai/text"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
  "content": "这是一个由人工智能模型生成的测试文本，用于演示如何检测AI生成的内容。",
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
{'success': True, 'is_ai_generated': True,
'confidence': 0.876,
'reasons': ['文本中包含直接的提示词汇，如‘人工智能模型生成的测试文本’',
'文本结构符合常见的AI生成文本的模式',
'使用了一些较为通用的词汇和句式，没有明显个人风格']}

```


### 图片内容


#### 示例请求Python代码
```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/ai/image"
headers = {
    "Content-Type": "application/json"
}


# 定义请求体
payload = {
  "content": "/TestData/Picture/ai.png",
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
{'success': True, 'is_ai_generated': True, 
'confidence': 0.967,
'reasons': ['图像中元素过于完美且对称',
'图像中的光线和阴影处理非常精细', 
'图像具有高度一致性和清晰度']}
```



### 视频内容_基于文件



#### 示例请求Python代码
```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/ai/video"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
  "content": "/video_detection/testVideo.mp4",
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
{
  "is_ai_generated": true,
  "confidence": 0.85,
  "reasons": [
    "检测到异常的纹理模式",
    "帧间一致性过高",
    "存在不自然的颜色过渡"
  ]
}

```


### 视频内容_基于视频帧


#### 示例请求Python代码
```python
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/detector/ai/video/frame"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
    "frames": [
        "https://so1.360tres.com/dr/270_500_/t01da3c6ca7c4c4d229.jpg?size=542x479",
        "https://so1.360tres.com/dr/270_500_/t01da3c6ca7c4c4d229.jpg?size=542x479"
    ],
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
{'success': True, 
'confidence': 0.2515000104904175, 
'reasons': ['图片中具备真实场景的清晰细节和自然光线效果', 
'具备真实的光线和阴影效果，非AI生成图像所能模仿'],
'is_ai_generated': False}
```

