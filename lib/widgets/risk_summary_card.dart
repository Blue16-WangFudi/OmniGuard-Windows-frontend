import 'package:flutter/material.dart';
import '../models/risk_summary.dart';

class RiskSummaryCard extends StatelessWidget {
  final RiskSummary riskSummary;

  const RiskSummaryCard({Key? key, required this.riskSummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '风险总览',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('总风险内容识别数量: ${riskSummary.total}'),
            Text('低风险内容数量: ${riskSummary.lowRisk}'),
            Text('中风险内容数量: ${riskSummary.mediumRisk}'),
            Text('高风险内容数量: ${riskSummary.highRisk}'),
            Divider(thickness: 2),
            Text(
              '风险分类统计',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...riskSummary.cases.map((caseItem) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('${caseItem.type}: ${caseItem.count}'),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
