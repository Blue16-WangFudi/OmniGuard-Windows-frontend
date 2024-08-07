import 'package:flutter/material.dart';
import 'package:omni_guard_ai_web/pages/main_page.dart';
import 'package:omni_guard_ai_web/pages/risk_content_identification.dart';
import 'package:omni_guard_ai_web/pages/aigc_identification.dart';
import 'package:omni_guard_ai_web/pages/case_of_use.dart'; // 导入 CaseOfUse
import 'package:omni_guard_ai_web/pages/document.dart'; // 导入 DocumentPage
import './appbar.dart';
import 'provider/page_provider.dart';
import 'provider/file_provider.dart';
import 'provider/file_provider2.dart';
import 'package:provider/provider.dart';
import './left.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => FileProvider()),
        ChangeNotifierProvider(create: (_) => FileProvider2()),
      ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [
    MainPage(),

    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: RiskContentIdentification(),
    ),
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: AIGCIdentification(),
    ),
    
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child:  DocumentPage(assetPath: 'assets/document.md'), 
    ),
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child:  DocumentPage(assetPath: 'assets/document2.md'), 
    ),
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child:  DocumentPage(assetPath: 'assets/document3.md'), 
    ),
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child:  DocumentPage(assetPath: 'assets/document4.md'), 
    ),
    
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: CaseOfUse(assetPath: 'assets/cases.md'),

    ),    
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: CaseOfUse(assetPath: 'assets/case2.md'),

    ),    
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: CaseOfUse(assetPath: 'assets/case3.md'),

    ),    
    Container(
      color: Color.fromRGBO(247, 248, 252, 1),
      child: CaseOfUse(assetPath: 'assets/case4.md'),

    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int pageNow = Provider.of<PageProvider>(context).pageNow;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromRGBO(39, 40, 44, 1),
        title: AppBarWidget(),
      ),
      body: Row(
        children: <Widget>[
          LeftButtons(),
          Expanded(
            flex: 5,
            child: IndexedStack(
              index: pageNow,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
