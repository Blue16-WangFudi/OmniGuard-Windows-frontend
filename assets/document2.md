## AI生成内容识别
### 文本/短信内容
#### 请求路径
```http
POST /api/v1/detector/ai/text
```

#### 接口说明
此API用于判断给定的文本是否可能由AI生成。它通过分析文本的结构、语言模式和复杂性来评估文本的来源。并返回判断依据和风险点。

#### 请求参数
Content-Type: application/json

content(string, 必填): 待检测的文本字符串。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "这是一个由人工智能模型生成的测试文本，用于演示如何检测AI生成的内容。",
"date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 响应格式
Content-Type: application/json

is_ai_generated (boolean): 如果true则表示文本可能由AI生成；如果false则表示文本可能不是由AI生成。

confidence (float): AI生成的置信度，范围0.0到1.0，值越高表示更可能是AI生成的文本。

reasons (list of strings): 一系列可能的解释，说明为什么API认为文本可能是AI生成的。

#### 返回结果
```json
{
"is_ai_generated": true,
"confidence": 0.92,
"reasons": [
"文本中存在重复的模式和结构",
"词汇使用与常见人类语言习惯不符",
"句子长度分布与AI生成文本相似"
]
}
```

#### 备注
可以使用该接口的功能：AI生成检测——文本

### 图片内容

#### 请求路径
```http
POST /api/v1/detector/ai/image
```

#### 接口说明
用于检测上传的图片是否可能由AI生成的API。并返回判断依据和风险点。

#### 请求参数
Content-Type: application/json

content (String，必填): 图片文件，Base64编码，支持JPEG、PNG、GIF等格式。也可以提交图片URL，但是URL必须公网可以访问。同时也可以提交对象键（腾讯云COS对象存储，开头以“/”表示）

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "(图像Base64编码)",
"date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 响应格式
Content-Type: application/json

is_ai_generated (boolean): 如果true，则表示图片可能由AI生成；如果false，则表示图片可能不是由AI生成。

confidence (float): AI生成的置信度，范围0.0到1.0，值越高表示更可能是AI生成的图片。

reasons (list of strings): 解释为何API认为图片可能是AI生成的一系列可能原因。

#### 返回结果
```json
{
"is_ai_generated": true,
"confidence": 0.85,
"reasons": [
"图片中的纹理一致性高，符合AI生成的特征",
"检测到的噪点模式与AI生成图像的噪点模式类似",
"颜色分布不符合自然图像的统计特性"
]
}
```

#### 备注
可以使用该接口的功能：AI生成检测——图片

### 伪造音频

#### 请求路径
```http
POST /api/v1/detector/ai/audio
```

#### 接口说明
用于检测上传的音频是否可能由AI生成的API。并返回判断依据和风险点。

#### 请求参数
content：File，必填，音频文件的对象键（以“/”开头），格式可以是WAV、MP3等。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
“content”： “/audio_detection/testAudio.mp3”,
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```
#### 返回结果
Content-Type: application/json

is_ai_generated (boolean): 如果true，则表示音频可能由AI生成；如果false，则表示音频可能不是由AI生成。

confidence (float): AI生成的置信度，范围0.0到1.0，值越高表示更可能是AI生成的音频。

reasons (list of strings): 解释为何API认为音频可能是AI生成的一系列可能原因。

#### 返回示例
```json
Content-Type: application/json
is_ai_generated (boolean): 如果true，则表示音频可能由AI生成；如果false，则表示音频可能不是由AI生成。
confidence (float): AI生成的置信度，范围0.0到1.0，值越高表示更可能是AI生成的音频。
reasons (list of strings): 解释为何API认为音频可能是AI生成的一系列可能原因。
```

#### 备注
  

### 视频内容_基于文件


#### 请求路径
```http
POST /api/v1/detector/ai/video
```

#### 接口说明
本接口用于检测给定的图片集（视频的关键帧的base64数据集合）对应的视频是否为AI生成的视频。通过分析图片数据，接口能够判断视频的真实性，并提供相应的置信度。

#### 请求参数
Content-Type: application/json

content (string, 必填): 视频的对象键，通过对象键获取对象信息

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
”content“: "/video_detection/testVideo.mp4"
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 返回参数
is_ai_generated：Boolean，视频是否为AI生成

confidence：Float，检测的置信度，范围0到1之间

reasons：Array of String，提供判断的理由或依据

#### 返回结果
```json
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

#### 备注
由于服务器带宽限制，上传视频会导致带宽消耗太大，从成本考虑，因此上传视频关键帧即可。关键帧可以通过多种方式截取，例如每隔一分钟截取一帧、每一个镜头截取一帧。
可以使用该接口的功能：AI生成检测——视频

### 视频内容_基于视频帧

#### 请求路径
```http
POST /api/v1/detector/ai/videoFrame
```

#### 接口说明
本接口用于检测给定的视频数据（通过给定对象键）的方式来上传视频数据并进行判断。

#### 请求参数
Content-Type: application/json

frames (array, 必填): 一个包含多个图片base64编码字符串的数组，每个字符串代表视频中的一个关键帧。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"frames": [
"data:image/jpeg;base64,/9j/4AAQSkZJR...",
"data:image/jpeg;base64,/9j/4AAQSkZJR...",
"data:image/jpeg;base64,/9j/4AAQSkZJR..."
]
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 返回参数
is_ai_generated：Boolean，视频是否为AI生成

confidence：Float，检测的置信度，范围0到1之间

reasons：Array of String，提供判断的理由或依据

#### 返回结果
```json
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

#### 备注
这种方式采用系统内置算法提取关键帧，有利于更精确识别视频内容。

## 风险内容识别

### 文本内容

#### 请求路径
```http
POST /api/v1/detector/risk/text
```

#### 接口说明
本接口用于分析给定的文本内容，并判断其风险内容等级，同时提供风险等级的百分比以及对应的风险点建议。风险等级分为四级：风险较小、轻度风险、中度风险、极度危险。

#### 请求参数
Content-Type: application/json

content：String，待检测的文本内容

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "一些示例文本，可能包含敏感词汇或需要评估的内容。",
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 响应格式
Content-Type: application/json

risk：Boolean，是否具有风险。

riskLevel：String，文本内容的风险等级（“风险较小”、“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

adviceList：Array，包含风险点建议的列表，每个建议包括：

-category：String，提示类别（“高风险提示”、“中风险提示”）。

-keyword：String，识别到的对应关键词。

-reason：String，给出建议的理由

#### 返回结果
```json
{
"risk": true,
"riskLevel": "轻度风险",
"riskPercentage": 25.5,
  "briefSuggestion": "涉及不当内容，建议举报",
  "comprehensiveAnalysis": "尾部的详细建议,100字以内",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "文本中出现了可能引起不适的词汇。"
},
{
"category": "高风险提示",
"keyword": "需要评估的内容",
"reason": "文本内容可能涉及不当言论，需要进一步审查。"
}
]
}
```

#### 备注
文本数据，比如手机短信、OCR识别得到的文本数据。
可以使用该接口的功能：短信内容检测（配合OCR）、其他形式的文本内容检测（比如网页等，也可以结合OCR）

### 图片内容-多轮对话


#### 请求路径
```http
POST /api/v1/detector/risk/screenshot
```

#### 接口说明
本接口用于分析上传的单张聊天记录截图，并判断其风险内容等级，同时提供风险等级的百分比以及对应的风险点建议。风险等级分为四级：风险较小、轻度风险、中度风险、极度危险。

#### 请求参数
screenshot：String，必填，聊天记录截图的base64编码字符串

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "(图像Base64编码)",
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 响应格式
risk：Boolean，是否具有风险。

riskLevel：String，聊天记录截图的风险等级（“风险较小”、“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

adviceList：Array，包含风险点建议的列表，每个建议包括：

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

category：String，提示类别（“高风险提示”、“中风险提示”）
。
keyword：String，识别到的对应关键词（如果有）。

reason：String，给出建议的理由。


#### 返回结果
```json
{
"risk": true,
"riskLevel": "中度风险",
"riskPercentage": 55.3,
  "briefSuggestion": "xxxx",
  "comprehensiveAnalysis": "xxxxxxxxxx",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "聊天记录中包含可能引起不适的敏感词汇。"
},
{
"category": "高风险提示",
"keyword": "不当言论",
"reason": "检测到聊天记录中有可能构成诽谤或侮辱的内容。"
},
{
"category": "中风险提示",
"keyword": "个人信息泄露",
"reason": "聊天记录可能包含个人识别信息，建议加强隐私保护。"
}
]
}
```

#### 备注
可以使用该接口的功能：聊天记录检测（截图直接上传聊天记录图片）、短信多轮对话检测（短信界面直接截图上传）

### 图片内容-通用图片

#### 请求路径
```http
POST /api/v1/detector/risk/image
```

#### 接口说明
本接口用于检测上传的图片内容是否涉及风险，包括敏感内容、不当言论等。如果检测到风险，接口将返回风险类型、两则警示语；如果没有检测到风险，则不返回警示语。

#### 请求参数
content：String，必填，聊天记录截图的base64编码字符串

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "(图像Base64编码)",
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 响应格式
risk：Boolean，是否具有风险。

riskLevel：String，图片的风险等级（“风险较小”、“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

adviceList：Array，包含风险点建议的列表，每个建议包括：

category：String，提示类别（“高风险提示”、“中风险提示”）。

keyword：String，识别到的关键元素（如果有）

reason：String，给出建议的理由。

#### 返回结果
```json
{
"risk": true,
"riskLevel": "中度风险",
"riskPercentage": 55.3,
  "briefSuggestion": "xxxx",
  "comprehensiveAnalysis": "xxxxxxxxxx",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "聊天记录中包含可能引起不适的敏感词汇。"
},
{
"category": "高风险提示",
"keyword": "不当言论",
"reason": "检测到聊天记录中有可能构成诽谤或侮辱的内容。"
},
{
"category": "中风险提示",
"keyword": "个人信息泄露",
"reason": "聊天记录可能包含个人识别信息，建议加强隐私保护。"
}
]
}
```

#### 备注
可以使用该接口的功能：通用图像检测，比如检测一个图中是否有敏感内容（这个比较难做，因为敏感内容估计会触发审核）

### 视频内容——基于关键帧

#### 请求路径
```http
POST /api/v1/detector/risk/video/frame
```

#### 接口说明
本接口用于分析上传的关键帧，判断视频内容的风险等级，并提供对应的风险点建议。风险等级分为四级：风险较小、轻度风险、中度风险、极度危险。

#### 请求参数
Content-Type: application/json

frames：Array of String，必填，关键帧的base64数据集合。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"frames": [
"base64EncodedStringFrame1",
"base64EncodedStringFrame2",
"base64EncodedStringFrame3"
// 更多帧...
]
}
```

#### 返回参数
risk：Boolean，是否具有风险。

riskLevel：String，视频内容的风险等级（“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

adviceList：Array，包含风险点建议的列表，每个建议包括：

category：String，提示类别（“高风险提示”、“中风险提示”）。

keyword：String，识别到的对应关键词。

reason：String，给出建议的理由。

#### 返回结果
```json
如果不具有风险：
{
  "risk": false,
}
如果具有风险：
{
"risk": true,
"riskLevel": "中度风险",
"riskPercentage": 55.3,
  "briefSuggestion": "xxxx",
  "comprehensiveAnalysis": "xxxxxxxxxx",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "关键帧中包含可能引起不适的敏感词汇。"
},
{
"category": "高风险提示",
"keyword": "不当言论",
"reason": "检测到关键帧中有可能构成诽谤或侮辱的内容。"
},
{
"category": "中风险提示",
"keyword": "个人信息泄露",
"reason": "关键帧可能包含个人识别信息，建议加强隐私保护。"
}
]
}
```

#### 备注
由于服务器带宽限制，上传视频会导致带宽消耗太大，从成本考虑，因此上传视频关键帧即可。关键帧可以通过多种方式截取，例如每隔一分钟截取一帧、每一个镜头截取一帧
可以使用该接口的功能：视频风险检测

### 视频内容——基于源文件

#### 请求路径
```http
POST /api/v1/detector/risk/video/data
```

#### 接口说明
本接口用于分析上传的关键帧，判断视频内容的风险等级，并提供对应的风险点建议。风险等级分为四级：风险较小、轻度风险、中度风险、极度危险。

#### 请求参数
Content-Type: application/json

content：Array of String，必填，视频的数据。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"frames": [
"base64EncodedStringFrame1",
"base64EncodedStringFrame2",
"base64EncodedStringFrame3"
// 更多帧...
]
}
```

#### 返回参数
risk：Boolean，是否具有风险。

riskLevel：String，视频内容的风险等级（“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

adviceList：Array，包含风险点建议的列表，每个建议包括：

category：String，提示类别（“高风险提示”、“中风险提示”）。

keyword：String，识别到的对应关键词。

reason：String，给出建议的理由。

#### 返回结果
```json
如果不具有风险：
{
  "risk": false,
}
如果具有风险：
{
"risk": true,
"riskLevel": "中度风险",
"riskPercentage": 55.3,
  "briefSuggestion": "xxxx",
  "comprehensiveAnalysis": "xxxxxxxxxx",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "关键帧中包含可能引起不适的敏感词汇。"
},
{
"category": "高风险提示",
"keyword": "不当言论",
"reason": "检测到关键帧中有可能构成诽谤或侮辱的内容。"
},
{
"category": "中风险提示",
"keyword": "个人信息泄露",
"reason": "关键帧可能包含个人识别信息，建议加强隐私保护。"
}
]
}
```

#### 备注
由于服务器带宽限制，上传视频会导致带宽消耗太大，从成本考虑，因此上传视频关键帧即可。关键帧可以通过多种方式截取，例如每隔一分钟截取一帧、每一个镜头截取一帧
可以使用该接口的功能：视频风险检测

### 音频内容

#### 请求路径
```http
POST /api/v1/detector/risk/audio
```

#### 接口说明
本接口用于检测上传的音频文件内容是否涉及风险，包括敏感内容、不当言论等。如果检测到风险，接口将返回风险类型、两则警示语；如果没有检测到风险，则不返回警示语。

#### 请求参数
content：File，必填，音频文件，格式可以是WAV、MP3等。

date(string,必填)：判定日期，格式为YYYY-MM-DD。

province(string，必填)：数据来源——省份

area(string，必填)：数据来源——市级

#### 样例请求
```json
{
"content": "filekey",
  "date": "2024-7-31",
"province"："四川省",
"area": "眉山市"
}
```

#### 返回参数
risk：Boolean，是否具有风险。

riskLevel：String，视频内容的风险等级（“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

briefSuggestion: String, 头部的简略建议，20字以内

comprehensiveAnalysis: String, 尾部的详细建议,100字以内

adviceList：Array，包含风险点建议的列表，每个建议包括：

category：String，提示类别（“高风险提示”、“中风险提示”）。

keyword：String，识别到的对应关键词。

reason：String，给出建议的理由。

#### 返回结果
```json
如果不具有风险：
{
  "risk": false,
}
如果具有风险：
{
"risk": true,
"riskLevel": "中度风险",
"riskPercentage": 55.3,
  "briefSuggestion": "xxxx",
  "comprehensiveAnalysis": "xxxxxxxxxx",
"adviceList": [
{
"category": "中风险提示",
"keyword": "敏感词汇",
"reason": "关键帧中包含可能引起不适的敏感词汇。"
},
{
"category": "高风险提示",
"keyword": "不当言论",
"reason": "检测到关键帧中有可能构成诽谤或侮辱的内容。"
},
{
"category": "中风险提示",
"keyword": "个人信息泄露",
"reason": "关键帧可能包含个人识别信息，建议加强隐私保护。"
}
]
}
```

#### 备注
可以使用该接口的功能：音频风险检测

### 实时号码检测/增量检测

#### 请求路径
```http
POST /api/fraud-detection
```

#### 接口说明
本接口用于检测给定的sessionID和电话号码对应的通话内容是否涉及诈骗。如果检测到诈骗，接口将返回诈骗类型、两则警示语；如果没有检测到诈骗，则不返回警示语。后端在判断时会自动查找数据库，将数据库中已经存在的sessionID所对应的提交历史记录合并进行判断。

#### 请求参数
sessionID：String，必填，标识通话的sessionID。

phoneNumber：String，必填，电话号码。

textContent：String，可选，通话的识别内容。（增量的方式，每次识别完成就可以提交），如果不提交则只判断是否为诈骗电话。

#### 样例请求
```json
{
"sessionID": "1234567890",
"phoneNumber": "13800138000",
"textContent": "您好，我是税务局，您有一笔未缴税款，请尽快处理。"
}
```

#### 返回参数
risk：Boolean，是否检测到风险。

riskLevel：String，视频内容的风险等级（“风险较小”、“轻度风险”、“中度风险”、“极度危险”）。

riskPercentage：Float，风险等级的百分比，范围0到100。

adviceList：Array，包含风险点建议的列表，每个建议包括：

category：String，提示类别（“高风险提示”、“中风险提示”）。

keyword：String，识别到的对应关键词。

reason：String，给出建议的理由。

#### 返回结果
```json
如果一切正常（当前会话无风险），则返回：
{
  "risk": false
}
{
"risk": true,
"fraudType": "金融诈骗",
"shortWarning": "注意诈骗电话",
"longWarning": "您好，税务局不会通过电话向您催缴税款，请谨防诈骗。"
}
```

#### 备注
可以使用该接口的功能：诈骗来电预警、通话实时保护（结合实时ASR）、欺诈短信拦截
##  其他
### 返回今日风险数据和整体风险数据

#### 请求路径
```http
POST /api/v1/risk/report/date/{date}
```

#### 接口说明
本接口用于返回指定日期的风险内容识别数量以及各等级风险数量，并在最后返回所有已经记录至数据库的风险类型及其数量。

#### 请求参数
路径变量：
date: （必填，String），指定查询日期，格式为 YYYY-MM-DD。

#### 样例请求
```json
{
"date": "2024-7-29"
}
```

#### 返回参数
total: 总风险内容识别数量。

low_risk: 低风险内容数量。

medium_risk: 中风险内容数量。

high_risk: 高风险内容数量。

cases: 查询当天的事件分类和统计数量。

#### 返回结果
```json
{
"total": 120,
"low_risk": 75,
"medium_risk": 30,
"high_risk": 15,
  "cases": [
{
"type": "假冒客服诈骗",
"count": 45
},
{
"type": "虚假中奖信息诈骗",
"count": 30
},
{
"type": "冒充公检法机关诈骗",
"count": 25
}
]
}
```

#### 备注
可以使用该接口的功能：Web端主界面、整体信息饼状图绘制

### 获取可疑信息统计记录

#### 请求路径
```http
POST /api/suspicious-messages
```

#### 接口说明
本接口用于返回给定日期的可疑信息统计记录

#### 请求参数
date: 必填，指定日期，格式为 YYYY-MM-DD。

type: 必填，指定类别，可填：msg（可疑短信）、pic（可疑图片）、voice（可疑音频）、video（可疑视频）

#### 样例请求
```json
{
"date": "2024-7-29"
}
```

#### 返回参数
id: 短信编号。

count: 被识别到的次数。

type: 可疑信息类型（例如：诈骗、骚扰等）。

summary: 可疑内容摘要。

#### 返回结果
```json
[
{
"id": "sms123",
"count": 5,
"type": "诈骗",
"summary": "中奖通知，要求先支付税费。"
},
{
"id": "sms456",
"count": 3,
"type": "骚扰",
"summary": "多次发送垃圾广告信息。"
}
]
```

#### 备注
可以使用该接口的功能：Web端主界面——展示当天可疑短信列表

### 获取全部省份/各省份详细风险数量统计

#### 请求路径
```http
POST /api/v1/risk/report/region/{type}
```

#### 接口说明
此接口用于查询全部省份或者指定省份下各个行政区的诈骗总数量。用户通过发送省份名称，接口将返回该省份内所有行政区（如市、县）的名称及其对应的诈骗总数量。

#### 请求参数
路径变量：

area: 查询类型（如果给定total：全部查询，如果给定省份名称，则查询对应省份信息，注意不能传入中文）

#### 样例请求
```json
{
“area”= “total”
“area”=”Chongqing”
}
```

#### 响应格式
area: 区域名称。

count: 该区域的总数量。

#### 返回结果
```json
当查询类型为all：
[
{
"area": "北京",
"count": 150
},
{
"area": "上海",
"count": 120
},
{
"area": "广东",
"count": 200
}
// ...其他省份数据
]
当查询类型为"北京"
[
{
"area": "北京市",
"count": 250
},
{
"area": "海淀区",
"count": 80
},
{
"area": "朝阳区",
"count": 90
},
{
"area": "丰台区",
"count": 40
}
  // ...其他行政区数据
]
```

#### 备注
可以使用该接口的功能：Web端主界面——通过地图可视化当前情况（可以单击放大）

### 获取日期区间内每日情况分布

#### 请求路径
```http
POST /api/fraud-statistics/range
```

#### 接口说明
该接口用于获取指定日期范围内每天的诈骗案件情况，包括案件类型和对应数量。

#### 请求参数
start_date: 开始日期（字符串，格式为"YYYY-MM-DD"）

end_date: 结束日期（字符串，格式为"YYYY-MM-DD"）

#### 样例请求
```json
{
  “start_date”: “2023-01-01”,
  “end_date”: “2023-01-07”
}
```

#### 响应格式
date: 日期（字符串，格式为"YYYY-MM-DD"）

cases: 当天的诈骗案件列表（列表，每个元素包含以下信息）

type: 诈骗类型（字符串）

count: 案件数量（整数）

#### 返回结果
```json
[
{
"date": "2023-01-01",
"cases": [
{
"type": "假冒客服诈骗",
"count": 45
},
{
"type": "虚假中奖信息诈骗",
"count": 30
},
{
"type": "冒充公检法机关诈骗",
"count": 25
}
]
},
{
"date": "2023-01-02",
"cases": [
{
"type": "假冒客服诈骗",
"count": 40
},
{
"type": "虚假中奖信息诈骗",
"count": 20
},
{
"type": "冒充公检法机关诈骗",
"count": 15
}
]
},
// ... 更多日期的数据
]
```

#### 备注
可以使用该接口的功能：Web端主界面——图标展示变化趋势

