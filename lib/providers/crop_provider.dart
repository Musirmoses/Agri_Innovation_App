import 'package:flutter/material.dart';

import '../models/crop.dart';
import '../services/supabase_service.dart';

class CropProvider extends ChangeNotifier {
  final _db = SupabaseService().client;

  List<Crop> crops = [];
  bool isLoading = false;

  Future<void> loadCrops(String plotId) async {
    isLoading = true;
    notifyListeners();

    final res = await _db
        .from("crops")
        .select()
        .eq("plot_id", plotId)
        .order("created_at", ascending: false);

    crops = res.map<Crop>((e) => Crop.fromMap(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCrop(Map<String, dynamic> data) async {
    final res = await _db.from("crops").insert(data).select().single();

    crops.insert(0, Crop.fromMap(res));
    notifyListeners();
  }

  Future<void> updateCrop(String id, Map<String, dynamic> data) async {
    final res =
        await _db.from('crops').update(data).eq('id', id).select().single();

    final index = crops.indexWhere((c) => c.id == id);
    if (index != -1) {
      crops[index] = Crop.fromMap(res);
      notifyListeners();
    }
  }

  Future<void> deleteCrop(String id) async {
    await _db.from("crops").delete().eq("id", id);
    crops.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
