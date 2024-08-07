class RiskAnalysisResult {
  bool risk;
  String riskLevel;
  double riskPercentage;
  String briefSuggestion;
  String comprehensiveAnalysis;
  List<Advice> adviceList;

  RiskAnalysisResult({
    required this.risk,
    required this.riskLevel,
    required this.riskPercentage,
    required this.briefSuggestion,
    required this.comprehensiveAnalysis,
    required this.adviceList,
  });

  factory RiskAnalysisResult.fromJson(Map<String, dynamic> json) {
    return RiskAnalysisResult(
      risk: json['risk'],
      riskLevel: json['riskLevel'],
      riskPercentage: json['riskPercentage'].toDouble(),
      briefSuggestion: json['briefSuggestion'],
      comprehensiveAnalysis: json['comprehensiveAnalysis'],
      adviceList: List<Advice>.from(json['adviceList'].map((x) => Advice.fromJson(x))),
    );
  }

  RiskAnalysisResult copyWith({
    bool? risk,
    String? riskLevel,
    double? riskPercentage,
    String? briefSuggestion,
    String? comprehensiveAnalysis,
    List<Advice>? adviceList,
  }) {
    return RiskAnalysisResult(
      risk: risk ?? this.risk,
      riskLevel: riskLevel ?? this.riskLevel,
      riskPercentage: riskPercentage ?? this.riskPercentage,
      briefSuggestion: briefSuggestion ?? this.briefSuggestion,
      comprehensiveAnalysis: comprehensiveAnalysis ?? this.comprehensiveAnalysis,
      adviceList: adviceList ?? this.adviceList.map((a) => a.copyWith()).toList(),
    );
  }
}

class Advice {
  String category;
  String keyword;
  String reason;

  Advice({
    required this.category,
    required this.keyword,
    required this.reason,
  });

  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(
      category: json['category'],
      keyword: json['keyword'],
      reason: json['reason'],
    );
  }

  Advice copyWith({
    String? category,
    String? keyword,
    String? reason,
  }) {
    return Advice(
      category: category ?? this.category,
      keyword: keyword ?? this.keyword,
      reason: reason ?? this.reason,
    );
  }
}