// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io'; // Import dart:io for File class
import 'package:provider/provider.dart';
import '../provider/file_provider.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../services/multimodal_risk_detection.dart';
import '../models/risk_analysis_result.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

bool _isVisible = true; // 新增变量，用于控制 FileIcon 的可见性

class RiskContentIdentification extends StatefulWidget {
  @override
  _RiskContentIdentificationState createState() => _RiskContentIdentificationState();
}

class _RiskContentIdentificationState extends State<RiskContentIdentification> {

  late FileProvider _fileSelector;
  // final List<Map<String, dynamic>> messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool _isVisibleInstance = _isVisible; // 使用外部定义的 _isVisible
  final GlobalKey _globalKey = GlobalKey(); // 用于获取组件的高度
  final FocusNode focusNode = FocusNode();
  RiskAnalysisResult? _analysisResult;
  List<dynamic> list = [];
  bool _isAnalyzing = false; // 新增的状态变量

  Future<void> _sendMessage() async {
    String message = _textEditingController.text;
    
    // List<FileIcon> _files = ;
      List<String> content = [];
      content.add(message);
      for (var item in _fileSelector.fileIcons){
        content.add(item.key);
      }
    _textEditingController.clear();
      _fileSelector.clearFileIcon();

    if (message.trim().isNotEmpty) {
      setState(() {

        List<dynamic> sendList = [];
        sendList.add(message);
        sendList.add(content.length);
        list.add({
          'text': sendList,
          'isUser': true,
        });
        
      
      });

      // 开始分析文本
      _isAnalyzing = true;
      setState(() {


        list.add({
          'text': 'AI分析中...',
          'isUser': false,
        });
      });

      await _analyzeText(content);
      // 添加 AI 的回复
      if (_analysisResult != null) {
        setState(() {
          // 删除 "AI 分析中..." 的临时消息
          
          list.removeAt(list.length - 1);

          // 添加真正的 AI 回复
          list.add({
            'text': _analysisResult!,
            'isUser': false,
          });
        });
      }
      // 分析完成
      _isAnalyzing = false;
    }
  }

  Future<void> _analyzeText(List<String> content) async {

    final date = '2024-07-31';
    final province = '四川省';
    final area = '眉山市';

    try {
      final result = await analyzeTextRisk(content, date, province, area,'risk');
      setState(() {
        _analysisResult = result;
        print(result.riskLevel);

      });
    } catch (e) {
      print('Error analyzing text: $e');
    }
  }


  void _interruptAnalysis() {
    print('中断');
    // 假设这里有一个方法可以中断分析过程
    setState(() {
      _isAnalyzing = false; // 强制停止分析
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fileSelector = Provider.of<FileProvider>(context, listen: false);
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 100,
          right: 100,
          bottom: 200, // 为输入框留出更多空间
          child: ListView.builder(
            reverse: false, // 从顶部开始滚动
            itemCount: list.length,
            itemBuilder: (context, index) {
              final message = list[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (message['text']=='AI分析中...')
                        AIWaiting(),
                    
                    if ((!message['isUser'])&&(message['text']!='AI分析中...'))
                        AIMessage(message: message['text']),
                    if (message['isUser'])
                        UserMessage(message: message['text'])
                  ],
                ),
              );
            },
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.78,
          left: 180, // 添加左边距
          right: 100, // 添加右边距
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100, minHeight: 50),
            child: Container(
              key: _globalKey, // 添加 GlobalKey
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                borderRadius: BorderRadius.circular(30), // 设置圆角
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'MiSans',
                      ),
                      controller: _textEditingController,
                      maxLines: null, // 允许多行输入
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // 添加一个新的 StatefulWidget 来监测 _isAnalyzing 的状态
                  AnalysisInterruptButton(isAnalyzing: _isAnalyzing, onInterrupt: _interruptAnalysis, sendMessage: _sendMessage),
                ],
              ),
            ),
          ),
        ),



        Positioned(
          top: MediaQuery.of(context).size.height * 0.78,
          left: 100, // 添加左边距
          child:
            ImageUploadButton(),
        ),

        Positioned(
          left: 100, // 添加左边距
          top: MediaQuery.of(context).size.height * 0.78 + 70,
          child: Consumer<FileProvider>(
            builder: (context, model, child) {
              if (model.uploading) {
                return Text(
                  '文件正在上传中...请稍候',
                  style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(1,102,255, 1),
                          fontFamily: 'MiSans',
                        ),
                  );
              } else {
                return Text('');
              }
            },
          ),
        ),
        

        Positioned(
          top: MediaQuery.of(context).size.height * 0.78 - 130,
          left: 92, // 添加左边距
          right: 100, // 添加右边距
          child: Consumer<FileProvider>(
            builder: (context, fileProvider, child) {
              if (fileProvider.isNotAllEmpty()) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 从左开始排列
                    children: fileProvider.fileIcons
                        .map((fileIcon) => Container( // 使用 Container 替换 Expanded
                          // width: 80, // 设置固定宽度
                          height: 110, // 设置固定高度
                          margin: EdgeInsets.symmetric(horizontal: 8), // 设置左右边距
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: FileIconWidget(fileIcon: fileIcon, fileName: fileIcon.fileName,),
                        ))
                        .toList(),
                  ),
                );
              } else {
                return Container(); // Return an empty container if there are no file icons
              }
            },
          ),
        ),
      ],
    );
  }
}

class AIWaiting extends StatefulWidget {
  // AIMessage({required this.message});

  @override
  _AIWaitingState createState() => _AIWaitingState();
}

class _AIWaitingState extends State<AIWaiting> {
  @override
  Widget build(BuildContext context) {
      return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 150), // 设置最大宽度
            child: Padding(
              padding: EdgeInsets.only(left: 0), // 设置左边距
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 默认是 CrossAxisAlignment.start
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                   Text(
                      'AI分析中...',
                      style: 
                      TextStyle(
                        fontSize: 12, 
                        color: Color.fromARGB(255, 0, 0, 0), 
                        fontFamily: 'MiSans',
                        fontWeight: FontWeight.w600,
                      ),
                      
                      overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                      softWrap: true, // 自动换行
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      );

  }
}

Color getScoreColor(double score){
  if (score > 0.9){
      return Color.fromRGBO(121, 0, 0, 1);
  }
  if (score > 0.8){
      return Color.fromRGBO(161, 2, 2, 1);
  }
  if (score > 0.7){
      return Color.fromRGBO(181, 53, 2, 1);
  }
  if (score > 0.6){
      return Color.fromRGBO(255, 72, 0, 1);
  }
  if (score > 0.5){
      return Color.fromRGBO(249, 75, 0, 1);
  }
  if (score > 0.4){
      return Color.fromRGBO(255, 119, 0, 1);
  }
      return Color.fromRGBO(31, 183, 59, 1);
  
}




class UserMessage extends StatefulWidget {
  final dynamic message;

  UserMessage({required this.message});

  @override
  _UserMessageState createState() => _UserMessageState();
}

class _UserMessageState extends State<UserMessage> {
  @override
  Widget build(BuildContext context) {
      // print(widget.message is List);
      return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 150), // 设置最大宽度
            child: Padding(
              padding: EdgeInsets.only(right: 0), // 设置右边距
              child: 
                Column (
                  mainAxisAlignment: MainAxisAlignment.end, // 设置主轴对齐方式为靠右
                  crossAxisAlignment: CrossAxisAlignment.end, //                  
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(1,102,255, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.message[0] ,
                        style:
                          TextStyle(
                            fontSize: 15, 
                            color: 
                              Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'MiSans',
                            fontWeight: FontWeight.w400,
                          ), 
                        overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                        softWrap: true, // 自动换行
                      ),
                    ),
                    
                    SizedBox(height: 5.0), 
                    widget.message[1] > 1 ?
                      Text((widget.message[1]-1).toString()+" 个文件",
                      style: TextStyle(
                          fontSize: 12, 
                          color: 
                            Color.fromARGB(255, 0, 0, 0)
                            ,
                          fontFamily: 'MiSans',
                          fontWeight: FontWeight.w400,
                          ),
                      )
                      :Container()
                  ],
                )
          ) ,
        ),
      )
    );

  }
}


class AIMessage extends StatefulWidget {
  final RiskAnalysisResult? message;
  AIMessage({required this.message});

  @override
  _AIMessageState createState() => _AIMessageState();
}

class _AIMessageState extends State<AIMessage> {
  @override
  Widget build(BuildContext context) {
      return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // 这一行使子元素靠左对齐

              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 150), // 设置最大宽度
                  child: Padding(
                    padding: EdgeInsets.only(right: 150), // 设置左边距
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 默认是 CrossAxisAlignment.start
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                        Text(
                            '综合评价结果',
                            style: 
                            TextStyle(
                              fontSize: 15, 
                              color: Color.fromARGB(255, 46, 46, 46), 
                              fontFamily: 'MiSans',
                              fontWeight: FontWeight.w600,
                            ),
                            
                            overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                            softWrap: true, // 自动换行
                          ),

                          SizedBox(height: 5.0), 

                          Center(
                            child:Text(
                                widget.message?.riskPercentage.toString() ?? 'Unknown',
                                // 'a',
                                style: 
                                TextStyle(
                                  fontSize: 20, 
                                  color: getScoreColor(widget.message?.riskPercentage.toDouble() ?? 0.0), 
                                  fontFamily: 'MiSans',
                                  fontWeight: FontWeight.w600,
                                ),
                                
                                overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                                softWrap: true, // 自动换行
                              ),
                          ),
                          
                          SizedBox(height: 5.0), 

                          Center(
                            child:Text(
                              "风险等级: ${widget.message?.riskLevel ?? 'Unknown'}",
                              style: 
                              TextStyle(
                                fontSize: 15, 
                                color: Color.fromARGB(255, 46, 46, 46), 
                                fontFamily: 'MiSans',
                                fontWeight: FontWeight.w400,
                              ),                        
                              overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                              softWrap: true, // 自动换行
                            ),
                          ),
                          
                          SizedBox(height: 5.0), 

                          Center(
                            child: GradientRoundedProgressBar(
                              progress: widget.message?.riskPercentage.toDouble() ?? 0.0,
                              color1: getScoreColor((widget.message?.riskPercentage.toDouble() ?? 0.0) - 0.3),
                              color2: getScoreColor(widget.message?.riskPercentage.toDouble() ?? 0.0),
                              ),
                          ),

                          SizedBox(height: 5.0), 
                          Center(
                            child:Text(
                              widget.message?.briefSuggestion ?? 'Unknown',
                              style: 
                              TextStyle(
                                fontSize: 15, 
                                color: Color.fromARGB(255, 46, 46, 46), 
                                fontFamily: 'MiSans',
                                fontWeight: FontWeight.w400,
                              ),                        
                              overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                              softWrap: true, // 自动换行
                            ),
                          ),

                          // RiskList(adviceList: widget.message!.adviceList,category: '高',),
                          // RiskList(adviceList: widget.message!.adviceList,category: '中',)
                          ...RiskList(adviceList: widget.message!.adviceList,category: '高',).get(context),
                          ...RiskList(adviceList: widget.message!.adviceList,category: '中',).get(context),
                          SizedBox(height: 25.0),
                        Text(
                            widget.message!.comprehensiveAnalysis,
                            style: 
                            TextStyle(
                              fontSize: 15, 
                              color: Color.fromARGB(255, 56, 56, 56), 
                              fontFamily: 'MiSans',
                              fontWeight: FontWeight.w400,
                            ),
                            
                            overflow: TextOverflow.clip, // 如果文本过长，则裁剪
                            softWrap: true, // 自动换行
                          ),

                        ],
                      )
                    ),
                  ),
                ),
                SizedBox(height: 5.0), 

                TextButton.icon(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse('https://www.baidu.com'))) {
                        await launchUrl(
                          Uri.parse('https://www.baidu.com'),
                          mode: LaunchMode.externalApplication, // 尝试在外部应用中打开URL
                        );
                      } else {
                        throw 'Could not launch URL';
                      }
                    },

                  icon: SvgPicture.asset('assets/icons/doc_plaintext_fill.svg', width: 20),
                  label: Text('下载分析报告',
                    style: 
                      TextStyle(
                        fontSize: 12, 
                        color: Color.fromRGBO(1,102,255, 1), 
                        fontFamily: 'MiSans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                )


              ],

            )

        ),
      );

  }
}

class MessageBar extends StatelessWidget {
  final Advice advice;
  final String category;
  const MessageBar({
    super.key,
    required this.advice,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return             
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 10.0), // 最小高度
                child: 
                Container(
                  width: constraints.maxWidth, 
                  
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  padding: EdgeInsets.all(10.0),
                  child:  RichText(
                  
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                          text:  advice.keyword+ ' ',
                          style: TextStyle(
                            color: 
                              category == '高' ?
                              Color.fromARGB(255, 116, 0, 0)
                                : Color.fromARGB(255, 222, 0, 0),
                              fontFamily: 'MiSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,

                            ),
                        ),
                        
                        TextSpan(
                          text: advice.reason,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'MiSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  )
                )
              );
                    
                
            
          
      },
    );
  }
}



class RiskList {
  final List<Advice> adviceList;
  final String category;
  const RiskList({
      required this.adviceList,
      required this.category
  });

  // @override
  List<Widget> get(BuildContext context) {
    if (adviceList.isNotEmpty){
      List<Widget> suggestions = [];
      for (var advice in adviceList){
          if (advice.category.contains(category)){
            suggestions.add(
              MessageBar(
                advice: advice,
                category: category,
              )
            );
          }
       }
       if (suggestions.isEmpty){
        return[];
       }
  
      List<Widget> finalWidgetsList = [];
      
      finalWidgetsList.add(SizedBox(height: 25.0));
      finalWidgetsList.add(
        Text(
          category+"风险提示",
          style: 
          TextStyle(
            fontSize: 15, 
            color: 
              category == '高' ?
              Color.fromARGB(255, 116, 0, 0)
              : Color.fromARGB(255, 222, 0, 0)
              ,
            fontFamily: 'MiSans',
            fontWeight: FontWeight.w600,
          ), 
          overflow: TextOverflow.clip, // 如果文本过长，则裁剪
          softWrap: true, // 自动换行
        ),
      );

      for (var suggestion in suggestions){
                            
        finalWidgetsList.add(SizedBox(height: 10.0));
        finalWidgetsList.add(suggestion);
      }

      return finalWidgetsList;

    } 
    else{
      return [];
    }
  }
}



class GradientRoundedProgressBar extends StatelessWidget {
  final double progress;
  final Color color1;
  final Color color2;

  const GradientRoundedProgressBar({
    super.key,
    required this.progress,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 15.0,
          width: constraints.maxWidth, // 使用LayoutBuilder提供的最大宽度
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                // Progress Bar (Gradient)
                Positioned(
                  left: 2,
                  right: null,
                  top: 2,
                  bottom: 2,
                  width: progress * (constraints.maxWidth-4), // 使用LayoutBuilder提供的最大宽度
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color1, color2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 新增的 StatefulWidget 用来监测 _isAnalyzing 的状态
class AnalysisInterruptButton extends StatefulWidget {
  final bool isAnalyzing;
  final VoidCallback onInterrupt;
  final Future<void> Function() sendMessage;

  AnalysisInterruptButton({required this.isAnalyzing, required this.onInterrupt, required this.sendMessage});

  @override
  _AnalysisInterruptButtonState createState() => _AnalysisInterruptButtonState();
}

class _AnalysisInterruptButtonState extends State<AnalysisInterruptButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.isAnalyzing
          ? SvgPicture.asset(
              'assets/icons/record_circle.svg', // SVG 图标路径
              width: 26, // 图标的宽度
              height: 26, // 图标的高度
            )
          : SvgPicture.asset(
              'assets/icons/paperplane_right_fill.svg', // SVG 图标路径
              width: 26, // 图标的宽度
              height: 26, // 图标的高度
            ),
            onPressed: widget.isAnalyzing
                ? () {
                    widget.onInterrupt();
                    print('Interrupt button pressed');
                  }
                : () {
                    widget.sendMessage();
                    print('Send button pressed');
                  },
          );
  }
}


// 生成随机字符串的方法
String generateKey(String type,String suffix) {
  // final now = DateTime.now();
  // final timestamp = now.toIso8601String().replaceAll('-', '').replaceAll(':', '').substring(0, 15); // 日期时间戳
  final randomPart = generateRandomAlphanumericString(32); // 32位随机字符串
  // return '/$timestamp/$type/$randomPart.$suffix';
  return '/$type/$randomPart.$suffix';

}

// 生成指定长度的随机字母数字字符串
String generateRandomAlphanumericString(int length) {
  const allowedChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_';
  final random = Random.secure();
  return List.generate(length, (index) => allowedChars[random.nextInt(allowedChars.length)]).join();
}

class FileIcon {
  String type = '';
  String fileName = '';
  VoidCallback? onDelete;
  String path;
  String key = '';
  String base64Image = '';
  String suffix;

  FileIcon({
    required this.type,
    this.onDelete,
    required this.fileName,
    required this.path,
    required this.suffix,
  });

  void setKey(){
    key = generateKey(type,suffix);
  }
  

  void setImageBase64(String input){
    base64Image = input;
  }
  void setPath(String input){
    path = input;
  }

}

class FileIconWidget extends StatelessWidget {
  final FileIcon fileIcon;
  String fileName;
  FileIconWidget({
    required this.fileIcon,
    required this.fileName
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: fileIcon.onDelete, // 直接调用 onDelete 方法
      child: Container(
        width: 85, // 固定宽度为80
        height: 85,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 根据文件类型显示不同的内容
            fileIcon.type == 'img'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(fileIcon.base64Image), // 从 Base64 字符串中去除前缀
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  )
                : fileIcon.type == 'audio'
                    ? Icon(Icons.music_note, size: 40, color: Colors.grey[700])
                    : fileIcon.type == 'video'
                        ? Icon(Icons.video_library, size: 40, color: Colors.grey[700])
                        : fileIcon.type == 'text'
                            ? Icon(Icons.insert_drive_file, size: 40, color: Colors.grey[700])
                            : Container(),

            // 文件名
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                fileName,
                  style:TextStyle(
                    fontSize: 12, 
                    color: const Color.fromARGB(255, 56, 56, 56), 
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            // 删除按钮
            Center(
              // top: 4,
              // right: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  onPressed: fileIcon.onDelete, // 直接调用 onDelete 方法
                  icon: Icon(Icons.close, size: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ImageUploadButton extends StatefulWidget {
  @override
  _ImageUploadButtonState createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  final ImagePickerController _imagePickerController = ImagePickerController();
  late FileProvider _imageSelector;

  @override
  void initState() {
    super.initState();
    _imageSelector = Provider.of<FileProvider>(context, listen: false);
    _imagePickerController.fileProvider = _imageSelector; // Pass the _imageSelector to the ImagePickerController.
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60, // 按钮的宽度
          height: 60, // 按钮的高度
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
            borderRadius: BorderRadius.circular(30), // 设置圆角
          ),
          child: InkWell(
            onTap: () {
              showFilePicker(context);
            },
            child: Center(
              child: Image.asset(
                'assets/icons/arrow_right_folder_fill.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }    

  void showFilePicker(BuildContext context) {
      BuildContext anotherContext = context;
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return 
                Container(
                width: 300,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1), // 设置背景颜色
                  borderRadius: BorderRadius.circular(16), // 设置圆角半径
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('图像',
                          style:TextStyle(
                            fontSize: 18, 
                            color: Colors.black, 
                            fontFamily: 'MiSans',
                            fontWeight: FontWeight.w600,
                            ),),
                      onTap: () {
                        // Close the bottom sheet
                        // Use the context from the outer scope
                        _imagePickerController.pickFile('image/*', anotherContext);

                        Navigator.pop(context);

                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.music_note),
                          title: Text('音频',
                              style:TextStyle(
                                fontSize: 18, 
                                color: Colors.black, 
                                fontFamily: 'MiSans',
                                fontWeight: FontWeight.w600,
                                ),),
                          onTap: () {
                            Navigator.pop(context);
                            _imagePickerController.pickFile('audio/*', anotherContext);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.video_library),
                          title: Text('视频',
                              style:TextStyle(
                                fontSize: 18, 
                                color: Colors.black, 
                                fontFamily: 'MiSans',
                                fontWeight: FontWeight.w600,
                                ),),
                          onTap: () {
                            Navigator.pop(context);
                            _imagePickerController.pickFile('video/*', anotherContext);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.insert_drive_file),
                            title: Text('文本',
                              style:TextStyle(
                                fontSize: 18, 
                                color: Colors.black, 
                                fontFamily: 'MiSans',
                                fontWeight: FontWeight.w600,
                                ),
                            ),
                          onTap: () {
                            Navigator.pop(context);
                            _imagePickerController.pickFile('.txt', anotherContext);
                          },
                        ),
                      ],
                    
                  )
                
              
            );
          
          
        },
      );
    }

}

class ImagePickerController with ChangeNotifier {
  String base64Image = '';
  FileProvider? fileProvider; // Make fileProvider nullable.


  void addFileIcon(BuildContext context, String path, String type,String name,String imageBase64,String suffix) {
    FileIcon? fileIcon;

    String _shortenFileName(String fileName) {
      if (fileName.length > 6) {
        return fileName.substring(0, 6) + '...';
      }
      return fileName;
    }


    fileIcon = FileIcon(
      type: type,
      fileName: _shortenFileName(name),
      onDelete: () {
        fileProvider?.removeFileIcon(fileIcon!);
      },
      path: path,
      suffix: suffix
    );
    fileIcon.setImageBase64(imageBase64);
    fileIcon.setKey();

    fileProvider?.addFileIcon(fileIcon);

    final _riskContentIdentificationState = context.findAncestorStateOfType<_RiskContentIdentificationState>();
    if (_riskContentIdentificationState != null) {
      _riskContentIdentificationState.setState(() {
        _riskContentIdentificationState._isVisibleInstance = true;
      });
    }
  }

String getFileExtension(String name) {
  final lastDotIndex = name.lastIndexOf('.');
  
  if (lastDotIndex > 0) {
    // 返回最后一个点之后的所有字符
    return name.substring(lastDotIndex + 1);
  } else {
    // 如果没有找到扩展名，则返回空字符串
    return '';
  }
}


  void pickFile(String fileType, BuildContext context) async {
    final html.FileUploadInputElement fileInput = html.FileUploadInputElement()
      ..accept = fileType
      ..click();

    fileInput.onChange.listen((event) {
      final List<html.File> files = fileInput.files!;
      if (files.isNotEmpty) {
        final html.File file = files.first;
        readAsDataUrl(context,file).then((url) {
          String suffix = getFileExtension(file.name);

          switch (fileType) {
            case 'image/*':
            String path = file.relativePath!;
            print('path=$path');
              addFileIcon(context, file.relativePath!, 'img',file.name, url,suffix);
              break;
            case 'audio/*':
              addFileIcon(context, file.relativePath!, 'audio',file.name,url,suffix);
              break;
            case 'video/*':
              addFileIcon(context, file.relativePath!, 'video',file.name,url,suffix);
              break;
            case '.txt':
              addFileIcon(context, file.relativePath!, 'text',file.name,url,suffix);
              break;
            default:
              break;
          }

          // Update the visibility of the FileIcon
          final _riskContentIdentificationState = context.findAncestorStateOfType<_RiskContentIdentificationState>();
          if (_riskContentIdentificationState != null) {
            _riskContentIdentificationState.setState(() {
              _riskContentIdentificationState._isVisibleInstance = true;
            });
          }
        });
      }
    });
  }

  Future<String> readAsDataUrl(BuildContext context,html.File file) async {

    Provider.of<FileProvider>(context, listen: false).setFileUploadingState(true);

    final html.FileReader reader = html.FileReader();
    reader.readAsDataUrl(file);
    await reader.onLoad.first;
      final dataUrl = reader.result as String;

    // return reader.result as String;
      // 分割字符串，去除前缀，保留Base64编码的部分
    final base64Part = dataUrl.split(',').last;
    return base64Part;

  }
}

