class CropStage {
  final String stage;
  final int dayFrom;
  final int dayTo;

  CropStage({
    required this.stage,
    required this.dayFrom,
    required this.dayTo,
  });

  factory CropStage.fromMap(Map<String, dynamic> map) {
    return CropStage(
      stage: map['stage'],
      dayFrom: map['day_from'],
      dayTo: map['day_to'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stage': stage,
      'day_from': dayFrom,
      'day_to': dayTo,
    };
  }
}
