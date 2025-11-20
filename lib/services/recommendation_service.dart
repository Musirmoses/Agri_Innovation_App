import 'package:community_garden_planner/models/plant.dart';

class RecommendationService {
  // lightweight embedded catalog (can be loaded from JSON file later)
  static final List<Plant> _catalog = [
    Plant(
      id: 'tomato',
      commonName: 'Tomato',
      scientificName: 'Solanum lycopersicum',
      bestSeasons: ['warm'],
      soil: 'loamy',
      daysToHarvest: 75,
      companions: ['Basil', 'Onion'],
      seedlingSources: [
        'Local nursery',
        'Agricultural extension',
        'Seed supplier XYZ'
      ],
      notes: 'Needs full sun and staking. Regular watering.',
      imageUrl: '',
    ),
    Plant(
      id: 'onion',
      commonName: 'Onion',
      scientificName: 'Allium cepa',
      bestSeasons: ['dry', 'cool'],
      soil: 'well-drained',
      daysToHarvest: 90,
      companions: ['Carrot', 'Spinach'],
      seedlingSources: ['Local nursery', 'Seed packets'],
      notes: 'Plant from sets or seedlings. Moderate watering.',
      imageUrl: '',
    ),
    Plant(
      id: 'coriander',
      commonName: 'Coriander',
      scientificName: 'Coriandrum sativum',
      bestSeasons: ['cool', 'rainy'],
      soil: 'well-drained',
      daysToHarvest: 45,
      companions: ['Tomato'],
      seedlingSources: ['Local markets', 'Nursery'],
      notes: 'Quick-growing herb. Likes light shade in hot climates.',
      imageUrl: '',
    ),
    Plant(
      id: 'hoho', // bell pepper / capsicum
      commonName: 'Hoho (Bell Pepper)',
      scientificName: 'Capsicum annuum',
      bestSeasons: ['warm'],
      soil: 'loamy',
      daysToHarvest: 70,
      companions: ['Basil', 'Onion'],
      seedlingSources: ['Nursery', 'Seed packets'],
      notes: 'Needs consistent warmth and watering.',
      imageUrl: '',
    ),
    Plant(
      id: 'sukuma',
      commonName: 'Sukuma Wiki',
      scientificName: 'Brassica oleracea',
      bestSeasons: ['rainy', 'cool'],
      soil: 'fertile',
      daysToHarvest: 60,
      companions: ['Onion', 'Spinach'],
      seedlingSources: ['Local nursery', 'Seed supplier'],
      notes: 'Leafy green for quick harvesting, tolerates partial shade.',
      imageUrl: '',
    ),
  ];

  List<Plant> getCatalog() => _catalog;

  // Recommend by simple rules: match season or fallback to catalog
  List<Plant> recommend({String season = 'rainy', String soil = 'loamy'}) {
    final bySeason =
        _catalog.where((p) => p.bestSeasons.contains(season)).toList();
    if (bySeason.isNotEmpty) return bySeason;
    // fallback by soil
    final bySoil = _catalog.where((p) => p.soil == soil).toList();
    return bySoil.isNotEmpty ? bySoil : _catalog;
  }

  Plant? findById(String id) =>
      _catalog.firstWhere((p) => p.id == id, orElse: () => _catalog.first);
}
