// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import '../models/risk_summary.dart';

// class PieChart extends StatelessWidget {
//   final RiskSummary riskSummary;

//   const PieChart({Key? key, required this.riskSummary}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<CaseItem, String>> series = [
//       charts.Series(
//         id: 'RiskCases',
//         data: riskSummary.cases,
//         domainFn: (CaseItem caseItem, _) => caseItem.type,
//         measureFn: (CaseItem caseItem, _) => caseItem.count,
//         labelAccessorFn: (CaseItem caseItem, _) => '${caseItem.type}: ${caseItem.count}',
//       )
//     ];

//     return Container(
//       height: 400,
//       padding: EdgeInsets.all(16),
//       child: charts.PieChart(
//         series,
//         animate: true,
//         defaultRenderer: charts.ArcRendererConfig(
//           arcRendererDecorators: [charts.ArcLabelDecorator()],
//         ),
//       ),
//     );
//   }
// }
