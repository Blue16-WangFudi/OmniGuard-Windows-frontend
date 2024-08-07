class RiskSummary {
  final int total;
  final int lowRisk;
  final int mediumRisk;
  final int highRisk;
  final List<CaseItem> cases;

  RiskSummary({
    required this.total,
    required this.lowRisk,
    required this.mediumRisk,
    required this.highRisk,
    required this.cases,
  });

  factory RiskSummary.fromJson(Map<String, dynamic> json) {
    var list = json['cases'] as List;
    List<CaseItem> caseList = list.map((i) => CaseItem.fromJson(i)).toList();

    return RiskSummary(
      total: json['total'],
      lowRisk: json['low_risk'],
      mediumRisk: json['medium_risk'],
      highRisk: json['high_risk'],
      cases: caseList,
    );
  }

}

class CaseItem {
  final String type;
  final int count;

  CaseItem({required this.type, required this.count});

  factory CaseItem.fromJson(Map<String, dynamic> json) {
    return CaseItem(
      type: json['type'],
      count: json['count'],
    );
  }
}
