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
