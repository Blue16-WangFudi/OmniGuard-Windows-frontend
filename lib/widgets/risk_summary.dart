import 'package:flutter/material.dart';
import '../models/risk_summary.dart';

class RiskSummaryCard extends StatelessWidget {
  final RiskSummary riskSummary;

  RiskSummaryCard({required this.riskSummary});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('总风险内容识别数量: ${riskSummary.total}'),
            Text('低风险内容数量: ${riskSummary.lowRisk}'),
            Text('中风险内容数量: ${riskSummary.mediumRisk}'),
            Text('高风险内容数量: ${riskSummary.highRisk}'),
            Divider(),
            Text('事件分类和统计数量:'),
            ...riskSummary.cases.map((riskCase) => ListTile(
              title: Text(riskCase.type),
              trailing: Text('${riskCase.count} 次'),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
