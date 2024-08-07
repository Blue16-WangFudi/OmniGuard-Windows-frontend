class RiskItem {
  final String id;
  final int count;
  final String type;
  final String summary;

  RiskItem({
    required this.id,
    required this.count,
    required this.type,
    required this.summary,
  });

  factory RiskItem.fromJson(Map<String, dynamic> json) {
    return RiskItem(
      id: json['id'],
      count: json['count'],
      type: json['type'],
      summary: json['summary'],
    );
  }
}
