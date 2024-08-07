import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/risk_analysis_result.dart';

Future<dynamic> analyzeTextRisk(String content, String date, String province, String area) async {
  final url = 'http://platform.blue16.cn:8090/api/v1/detector/risk/text';
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'content': content,
    'date': date,
    'province': province,
    'area': area,
  });
  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // final decodedData = utf8.decode(response.bodyBytes);
      // final data = jsonDecode(response.body);
          // 使用 utf8 解码
    final decodedBody = utf8.decode(response.bodyBytes);

    // 解析 JSON 数据
    final data = jsonDecode(decodedBody);

      return RiskAnalysisResult.fromJson(data);
    } else {
      throw Exception('Failed to fetch data, status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}