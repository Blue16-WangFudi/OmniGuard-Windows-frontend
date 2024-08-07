import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/risk_analysis_result.dart';

Future<int> tencentCosService(String key, String base64) async {
  final url = 'http://localhost:5000/upload_base64';
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'Key': key,
    'Base64FileData': base64,
  });
  
  try {
    
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {

      return response.statusCode;
  //   final decodedBody = utf8.decode(response.bodyBytes);
  // print(5);
  //   // 解析 JSON 数据
  //   final data = jsonDecode(decodedBody);
  // print(6);

      // return RiskAnalysisResult.fromJson(data);
    } else {
        return response.statusCode;

      // throw Exception('Failed to upload the file, status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}