import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/api_service.dart'; // 确保正确引入 ApiService 类

class RiskOverallReport extends StatefulWidget {
  @override
  _RiskOverallReportState createState() => _RiskOverallReportState();
}

class _RiskOverallReportState extends State<RiskOverallReport> {
  final ApiService apiService = ApiService();
  List<PieChartData> _chartData = [];

  // Define a list of colors
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.yellow,
    Colors.brown,
    Colors.teal,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      //TODO: 替换为实际日期
      final data = await apiService.fetchRiskReportData('2024-07-29'); // 使用实际日期替换
      setState(() {
        _chartData = (data['cases'] as List<dynamic>).map((item) {
          return PieChartData(
            type: item['type'],
            count: item['count'],
          );
        }).toList();
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('风险类型分布')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('风险类型分布'),
            SizedBox(height: 16),
            Expanded(
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<PieChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (PieChartData data, _) => data.type,
                    yValueMapper: (PieChartData data, _) => data.count,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      labelAlignment: ChartDataLabelAlignment.middle,
                      showCumulativeValues: false,
                      labelIntersectAction: LabelIntersectAction.none,
                    ),
                    dataLabelMapper: (data, _) {
                      final total = _chartData.fold(0, (sum, item) => sum! + item.count);
                      final percentage = (data.count / total * 100).toStringAsFixed(1);
                      return '${data.type}\n$percentage%'; // Format the label text
                    },
                    pointColorMapper: (PieChartData data, index) =>
                        _colors[index % _colors.length],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartData {
  final String type;
  final int count;

  PieChartData({required this.type, required this.count});
}
