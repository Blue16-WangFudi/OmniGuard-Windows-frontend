import 'package:flutter/material.dart';
import '../models/risk_item.dart';

class RiskCard extends StatelessWidget {
  final RiskItem riskItem;

  const RiskCard({Key? key, required this.riskItem}) : super(key: key);

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
              riskItem.id,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('类型: ${riskItem.type}'),
            SizedBox(height: 8),
            Text('摘要: ${riskItem.summary}'),
            SizedBox(height: 8),
            Text('识别次数: ${riskItem.count}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text('详情')),
                TextButton(onPressed: () {}, child: Text('报告此事件')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
