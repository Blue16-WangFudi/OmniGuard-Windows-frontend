
# 使用案例（Python）
### 首先导入requests与uuid
```python
pip install requests，uuid
```
### 多模态AI检测与风险识别

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
{'success': True, 'is_ai_generated': True, 'confidence': 0.95,
'reasons': ["文本中明确提到'由人工智能模型生成的测试文本'", 
'使用了典型的用于演示目的的表述方式', '文本结构符合AI生成文本的常见模式']}
```





### ChatCompletion-Text(ChatGLM4)


#### 示例请求Python代码
```python
import uuid
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/chat/generate_request/ChatGLM"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
    "sessionID": str(uuid.uuid4()),
    "systemPrompt": "你是一名AI助手",
    "prompt": "你好"
}

# 发送POST请求
response = requests.post(url, json=payload, headers=headers)

# 打印响应结果
print(response.status_code)
print(response.json())
```


#### 返回结果
```python
{'code': 200, 'msg': '调用成功', 'success': True,
'data': {'usage': {'prompt_tokens': 12,
'completion_tokens': 27, 'total_tokens': 39}, 'created': 1722515747,
'model': 'GLM-4', 'id': '20240801203546277b6a1c2188420f',
'error': None, 'choices': [{'finish_reason': 'stop', 
'index': 0, 'message': {'role': 'assistant', 
'content': '是的，我是一名人工智能助手。如果你有任何问题或需要帮助，请随时告诉我！我会尽力为你提供支持和解答。', 
'name': None, 'tool_call_id': None, 'tool_calls': None},
'delta': None}], 'task_id': None, 'request_id': None,
'task_status': None}, 'flowable': None}
```

  
### ChatCompletion-Vision(ChatGLM4V)


#### 示例请求Python代码

```python
import uuid
import requests

# 定义请求的URL和头部
url = "http://platform.blue16.cn:8090/api/v1/chat/generate_request/ChatGLM"
headers = {
    "Content-Type": "application/json"
}

# 定义请求体
payload = {
    "sessionID": str(uuid.uuid4()),
    "systemPrompt": "你是李白，请以李白的风格看世界和回答问题",
    "prompt": "你能详细讲讲这个场景吗？",
    "picture": "https://so1.360tres.com/dr/270_500_/t01da3c6ca7c4c4d229.jpg?size=542x479"
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
{'code': 200, 'msg': '调用成功',
'success': True, 
'data': {'usage': {'prompt_tokens': 1692,
'completion_tokens': 84, 'total_tokens': 1776},
'created': 1722586819, 'model': 'glm-4v',
'id': '20240802162015550693077f584bf6',
'error': None, 'choices': [{'finish_reason': 'stop',
'index': 0, 'message': {'role': 'assistant', 'content': '当然可以！图片展示了一处壮观的瀑布景象，水雾弥漫在空中，阳光照射下来，
形成了美丽的光线效果。瀑布从高处流下，汇入湍急的水流中。
在瀑布前方，有一艘船正在河上航行，显得非常渺小。
周围的环境看起来很自然，有绿色的植被覆盖在岩石上。
整个场景给人一种震撼而又宁静的感觉。', 'name': None,
'tool_call_id': None, 'tool_calls': None}, 
'delta': None}], 'task_id': None, 'request_id': None,
'task_status': None}, 'flowable': None}


```

  
