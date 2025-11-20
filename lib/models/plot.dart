import 'dart:convert';

class Plot {
  final String id;
  final String farmId;
  final String name;
  final double? size;
  final String? cropType;
  final DateTime createdAt;

  Plot({
    required this.id,
    required this.farmId,
    required this.name,
    this.size,
    this.cropType,
    required this.createdAt,
  });

  factory Plot.fromMap(Map<String, dynamic> map) {
    return Plot(
      id: map['id'],
      farmId: map['farm_id'],
      name: map['name'],
      size:
          map['size'] != null ? double.tryParse(map['size'].toString()) : null,
      cropType: map['crop_type'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'farm_id': farmId,
      'name': name,
      'size': size,
      'crop_type': cropType,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Plot.fromJson(String source) => Plot.fromMap(json.decode(source));
}
