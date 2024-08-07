import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/risk_analysis_result.dart';
import '../models/aigc_indentification_result.dart';

Future<dynamic> analyzeTextRisk(List<String> content, String date, String province, String area,String type) async {
  final url = 'http://platform.blue16.cn:8090/api/v2/detector/'+type;
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'multimodal': content,
    'date': date,
    'province': province,
    'area': area,
  });
    print(body);

  try {
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // final decodedData = utf8.decode(response.bodyBytes);
      // final data = jsonDecode(response.body);
          // 使用 utf8 解码

    final decodedBody = utf8.decode(response.bodyBytes);

    // 解析 JSON 数据
    final data = jsonDecode(decodedBody);
      if (type == 'ai')
      {
        return AIGCIndetificationResult.fromJson(data);
      }
      return RiskAnalysisResult.fromJson(data);
    } else {
      throw Exception('Failed to fetch data, status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}