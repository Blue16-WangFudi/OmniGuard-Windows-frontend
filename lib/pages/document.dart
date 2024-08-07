import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class DocumentPage extends StatelessWidget {
  final String assetPath;

  DocumentPage({required this.assetPath});

  Future<String> loadMarkdown() async {
    return await rootBundle.loadString(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadMarkdown(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Markdown(
            data: snapshot.data!,
            styleSheet: MarkdownStyleSheet(  
    // 自定义文本样式  
              p: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w400,
                  ),  
              // 自定义标题样式  
              h1: TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w800,
                  ),  
              h2: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w700,
                  ),  
              h3: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w600,
                  ), 
              h4: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w500,
                  ), 
              h5: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w500,
                  ),   
              h6: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'MiSans',
                    fontWeight: FontWeight.w500,
                  ),  
              // 自定义链接样式  
              a: TextStyle(  
                color: Color.fromRGBO(1,102,255, 1),  
                decoration: TextDecoration.underline,  
              ),  
              code: TextStyle(  
                backgroundColor: const Color.fromARGB(255, 110, 110, 0).withOpacity(0),  
                // padding: EdgeInsets.all(4.0),  
                fontSize: 14.0,  
              ),  
              // 自定义表格样式  

              codeblockDecoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 218, 218),
                
              ),
              // 自定义列表样式  
              listBullet: TextStyle(  
                fontSize: 16.0,  
                
              ),  
 
              // 自定义图片样式  
 
            ),
          );
        }
      },
    );
  }
}

