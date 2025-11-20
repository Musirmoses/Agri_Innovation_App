import 'dart:convert';

class Crop {
  final String id;
  final String plotId;
  final String name;
  final DateTime plantedOn;
  final DateTime? expectedHarvest;
  final String? wateringSchedule;
  final String? fertilizerType;
  final String? diseaseStatus;
  final String? growthStage;
  final DateTime createdAt;

  Crop({
    required this.id,
    required this.plotId,
    required this.name,
    required this.plantedOn,
    this.expectedHarvest,
    this.wateringSchedule,
    this.fertilizerType,
    this.diseaseStatus,
    this.growthStage,
    required this.createdAt,
  });

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      id: map['id'],
      plotId: map['plot_id'],
      name: map['name'],
      plantedOn: DateTime.parse(map['planted_on']),
      expectedHarvest: map['expected_harvest'] != null
          ? DateTime.tryParse(map['expected_harvest'])
          : null,
      wateringSchedule: map['watering_schedule'],
      fertilizerType: map['fertilizer_type'],
      diseaseStatus: map['disease_status'],
      growthStage: map['growth_stage'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plot_id': plotId,
      'name': name,
      'planted_on': plantedOn.toIso8601String(),
      'expected_harvest': expectedHarvest?.toIso8601String(),
      'watering_schedule': wateringSchedule,
      'fertilizer_type': fertilizerType,
      'disease_status': diseaseStatus,
      'growth_stage': growthStage,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Crop.fromJson(String source) => Crop.fromMap(json.decode(source));
}
