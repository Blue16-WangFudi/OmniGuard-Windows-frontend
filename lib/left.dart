import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'provider/page_provider.dart';

class LeftButtons extends StatefulWidget {
  @override
  _LeftButtonsState createState() => _LeftButtonsState();
}

class _LeftButtonsState extends State<LeftButtons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Color.fromRGBO(235, 237, 239, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(0);
              },
              text: '控制台',
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              svgPath: 'assets/icons/house.svg',
              svgScale: 1,
              svgLeftPadding: 10.0,
              textRightPadding: 13.0,
              fontSize: 22.0,
              hasShadow: false,
            ),
            SizedBox(height: 20),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(1);
              },
              text: '模型体验',
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              svgPath: 'assets/icons/more.svg',
              svgScale: 1,
              svgLeftPadding: 10.0,
              textRightPadding: 13.0,
              fontSize: 22.0,
              hasShadow: false,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(1);
              },
              text: '风险内容识别',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(2);
              },
              text: 'AIGC检测',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 20),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(3);
              },
              text: '开发文档',
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              svgPath: 'assets/icons/doc_plaintext_and_pencil.svg',
              svgScale: 1,
              svgLeftPadding: 10.0,
              textRightPadding: 13.0,
              fontSize: 22.0,
              hasShadow: false,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(3);
              },
              text: '多模态检测接口',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(4);
              },
              text: 'AI生成内容识别',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(5);
              },
              text: '风险内容识别',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(6);
              },
              text: '其他',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
    
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(7);
              },
              text: '使用案例',
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              svgPath: 'assets/icons/lightbulb.svg',
              svgScale: 1,
              svgLeftPadding: 10.0,
              textRightPadding: 13.0,
              fontSize: 22.0,
              hasShadow: false,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(7);
              },
              text: '基础AI能力',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(8);
              },
              text: 'AI生成内容识别',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(9);
              },
              text: '风险内容识别',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
            SizedBox(height: 5),
            customElevatedButton(
              onPressed: () {
                final pageProvider = Provider.of<PageProvider>(context, listen: false);
                pageProvider.setPageNow(10);
              },
              text: '其他',
              backgroundColor: Colors.transparent,
              textColor: Color.fromARGB(255, 90, 89, 89),
              textRightPadding: 0.0,
              fontSize: 18.0,
              hasShadow: false,
              bold: false,
              leftInset: 48,
            ),
          ],
        ),
      ),
    );
  }
}

Widget customElevatedButton({
  required VoidCallback onPressed,
  required String text,
  double leftInset = 0,
  Color? backgroundColor,
  Color? textColor,
  String? svgPath,
  double svgScale = 1.0,
  double svgLeftPadding = 10.0,
  double textRightPadding = 10.0,
  double fontSize = 16.0,
  bool hasShadow = true,
  bool bold = true,
}) {
  return Padding(
    padding: EdgeInsets.only(left: leftInset), // 设置左边距
    child: TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          if (svgPath != null)
            Padding(
              padding: EdgeInsets.only(left: svgLeftPadding),
              child: SvgPicture.asset(
                svgPath,
                width: svgScale * 25, 
                fit: BoxFit.contain,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: textRightPadding),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize, 
                color: textColor ?? Colors.black, 
                fontFamily: 'MiSans',
                fontWeight: bold ? FontWeight.w600 : FontWeight.w500, 
              ),
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: textColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 设置圆角
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 设置内边距
        minimumSize: Size(double.infinity, 50), // 设置按钮的最小尺寸
        shadowColor: hasShadow ? Colors.black.withOpacity(0.1) : Colors.transparent,
        elevation: hasShadow ? 4 : 0,
        splashFactory: NoSplash.splashFactory, // 禁用水波纹效果
      ),
    ),
  );
}
