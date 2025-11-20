import 'dart:convert';

class Farm {
  final String id;
  final String userId;
  final String name;
  final String? location;
  final double? sizeAcres;
  final String? soilType;
  final DateTime createdAt;

  Farm({
    required this.id,
    required this.userId,
    required this.name,
    this.location,
    this.sizeAcres,
    this.soilType,
    required this.createdAt,
  });

  factory Farm.fromMap(Map<String, dynamic> map) {
    return Farm(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      location: map['location'],
      sizeAcres: map['size_acres'] != null
          ? double.tryParse(map['size_acres'].toString())
          : null,
      soilType: map['soil_type'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'location': location,
      'size_acres': sizeAcres,
      'soil_type': soilType,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Farm.fromJson(String source) => Farm.fromMap(json.decode(source));
}
