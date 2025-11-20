class CropReference {
  final String id;
  final String name;
  final List<String> recommendedZones; // e.g. ["wet", "moderate"]
  final List<String> soilTypes;        // e.g. ["loam", "clay"]
  final List<String> plantingMonths;   // e.g. ["March", "April"]
  final int maturityDays;              // e.g. 90 days
  final String waterRequirement;       // "low", "medium", "high"
  final String description;            // agronomic info

  CropReference({
    required this.id,
    required this.name,
    required this.recommendedZones,
    required this.soilTypes,
    required this.plantingMonths,
    required this.maturityDays,
    required this.waterRequirement,
    required this.description,
  });

  factory CropReference.fromMap(Map<String, dynamic> map) {
    return CropReference(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      recommendedZones: map['recommended_zones'] != null
          ? List<String>.from(map['recommended_zones'])
          : [],
      soilTypes: map['soil_types'] != null
          ? List<String>.from(map['soil_types'])
          : [],
      plantingMonths: map['planting_months'] != null
          ? List<String>.from(map['planting_months'])
          : [],
      maturityDays: map['maturity_days'] ?? 0,
      waterRequirement: map['water_requirement'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'recommended_zones': recommendedZones,
      'soil_types': soilTypes,
      'planting_months': plantingMonths,
      'maturity_days': maturityDays,
      'water_requirement': waterRequirement,
      'description': description,
    };
  }
}

