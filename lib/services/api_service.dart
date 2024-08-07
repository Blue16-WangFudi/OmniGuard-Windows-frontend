import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://platform.blue16.cn:8090/api/v1';
  final Map<String, String> endpoints = {
    'riskContent': '/risk/content',
    'riskReport': '/report/risk/date',
    'riskRegion': '/report/risk/region', // 新增的端点
  };

  Future<List<dynamic>> fetchRiskData(String date, String type) async {
    try {
      print(json.encode({
        'date': date,
        'type': type,
      }));
      final response = await http.post(
        Uri.parse('$baseUrl${endpoints['riskContent']}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'date': date,
          'type': type,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load risk data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load risk data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchRiskReportData(String date) async {
    try {
      print('$baseUrl${endpoints['riskReport']}/$date' );
      final response = await http.post(
        Uri.parse('$baseUrl${endpoints['riskReport']}/$date'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load risk report data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load risk report data: $e');
    }
  }

  Future<Map<String, int>> fetchRiskDataByRegion(String area) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${endpoints['riskRegion']}/$area'),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return Map<String, int>.fromIterable(
          body,
          key: (item) => item['area'],
          value: (item) => item['count'],
        );
      } else {
        throw Exception('Failed to load risk data by region');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load risk data by region: $e');
    }
  }

  // Mock data fetch method for the new endpoint
  Future<Map<String, dynamic>> mockFetchRiskReportData(String date) async {
    try {
      // Simulating network delay
      await Future.delayed(Duration(seconds: 2));

      // Returning mock data
      return {
        'total': 120,
        'low_risk': 75,
        'medium_risk': 30,
        'high_risk': 15,
        'cases': [
          {'type': '假冒客服诈骗', 'count': 45},
          {'type': '虚假中奖信息诈骗', 'count': 30},
          {'type': '冒充公检法机关诈骗', 'count': 25},
        ],
      };
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load mock risk report data: $e');
    }
  }

  // Mock data fetch method for the old endpoint
  Future<List<dynamic>> mockFetchRiskData(String date, String type) async {
    try {
      // Simulating network delay
      await Future.delayed(Duration(seconds: 2));

      // Returning mock data
      return [
        {
          'id': 'sms123',
          'count': 5,
          'type': '诈骗',
          'summary': '中奖通知，要求先支付税费。',
        },
        {
          'id': 'sms456',
          'count': 3,
          'type': '骚扰',
          'summary': '多次发送垃圾广告信息。',
        },
        {
          'id': 'sms789',
          'count': 8,
          'type': '诈骗',
          'summary': '假冒客服诈骗，要求提供个人信息。',
        },
        {
          'id': 'sms101',
          'count': 2,
          'type': '骚扰',
          'summary': '推销贷款服务，频繁发送信息。',
        },
      ];
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load mock risk data: $e');
    }
  }
  // Mock method to fetch risk data by region
  Future<Map<String, int>> mockFetchRiskDataByRegion(String area) async {
    try {
      // Simulating network delay
      await Future.delayed(Duration(seconds: 2));

      // Mock data
      if (area == 'total') {
        return {
          '重庆': 150,
          '上海': 120,
          '广东': 200,
          '浙江': 110,
          '江苏': 90,
          '福建': 80,
        };
      } else if (area == '北京') {
        return {
          '北京市': 250,
          '海淀区': 80,
          '朝阳区': 90,
          '丰台区': 40,
          '东城区': 30,
          '西城区': 10,
        };
      } else {
        // Return an empty map for other areas
        return {};
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load mock risk data by region: $e');
    }
  }
}
