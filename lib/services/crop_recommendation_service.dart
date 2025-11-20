import '../models/crop_reference.dart'; // you will create this in batch 6 or 7
import 'supabase_service.dart';

class CropRecommendationService {
  final _db = SupabaseService().client;

  /// Kenya Region → Climate Zone → Crop Match
  Future<List<CropReference>> recommendCrops({
    required String region,
    required String soilType,
  }) async {
    // Map of Kenya regions to climate patterns
    final climateZones = {
      // HIGH RAINFALL ZONE
      'Western': 'wet',
      'Nyanza': 'wet',
      'Kisii': 'wet',
      'Nyeri': 'wet',

      // MODERATE RAINFALL
      'Nairobi': 'moderate',
      'Kiambu': 'moderate',
      'Kericho': 'moderate',
      'Nakuru': 'moderate',

      // SEMI-ARID
      'Machakos': 'semi_arid',
      'Makueni': 'semi_arid',
      'Kajiado': 'semi_arid',

      // ARID & VERY HOT
      'Turkana': 'arid',
      'Garissa': 'arid',
      'Wajir': 'arid',
      'Isiolo': 'arid',
    };

    final climate = climateZones[region] ?? 'moderate';

    final response = await _db
        .from('crop_reference')
        .select()
        .contains('recommended_zones', [climate]);

    return response
        .map<CropReference>((e) => CropReference.fromMap(e))
        .toList();
  }
}
