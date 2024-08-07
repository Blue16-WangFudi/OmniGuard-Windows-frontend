class AIGCIndetificationResult {
  bool success;
  bool is_ai_generated;
  double confidence;
  List<String> reasons;

  AIGCIndetificationResult({
    required this.success,
    required this.is_ai_generated,
    required this.confidence,
    required this.reasons,
  });

  factory AIGCIndetificationResult.fromJson(Map<String, dynamic> json) {
    
    return AIGCIndetificationResult(
      success: json['success'],
      is_ai_generated: json['is_ai_generated'],
      confidence: json['confidence'],
      reasons: List<String>.from(json['reasons'].map((x) => x)),
    );
  }

}
