class Plant {
  final String id;
  final String commonName;
  final String scientificName;
  final List<String> bestSeasons; // e.g. ['rainy','warm']
  final String soil; // e.g. 'loamy'
  final int daysToHarvest;
  final List<String> companions;
  final List<String>
      seedlingSources; // suggestions where to get seedlings / seeds
  final String notes;
  final String imageUrl; // placeholder

  Plant({
    required this.id,
    required this.commonName,
    this.scientificName = '',
    this.bestSeasons = const [],
    this.soil = '',
    this.daysToHarvest = 60,
    this.companions = const [],
    this.seedlingSources = const [],
    this.notes = '',
    this.imageUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commonName': commonName,
      'scientificName': scientificName,
      'bestSeasons': bestSeasons,
      'soil': soil,
      'daysToHarvest': daysToHarvest,
      'companions': companions,
      'seedlingSources': seedlingSources,
      'notes': notes,
      'imageUrl': imageUrl,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> m) {
    return Plant(
      id: m['id'],
      commonName: m['commonName'],
      scientificName: m['scientificName'] ?? '',
      bestSeasons: List<String>.from(m['bestSeasons'] ?? []),
      soil: m['soil'] ?? '',
      daysToHarvest: m['daysToHarvest'] ?? 60,
      companions: List<String>.from(m['companions'] ?? []),
      seedlingSources: List<String>.from(m['seedlingSources'] ?? []),
      notes: m['notes'] ?? '',
      imageUrl: m['imageUrl'] ?? '',
    );
  }
}
