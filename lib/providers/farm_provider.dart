import 'package:flutter/material.dart';

import '../models/farm.dart';
import '../models/plot.dart';
import '../services/supabase_service.dart';

class FarmProvider extends ChangeNotifier {
  final _db = SupabaseService().client;

  List<Farm> farms = [];
  List<Plot> plots = [];

  bool isLoading = false;

  Future<void> loadFarms(String userId) async {
    isLoading = true;
    notifyListeners();

    final res = await _db
        .from("farms")
        .select()
        .eq("user_id", userId)
        .order("created_at", ascending: false);

    farms = res.map<Farm>((e) => Farm.fromMap(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addFarm(Map<String, dynamic> data) async {
    final res = await _db.from("farms").insert(data).select().single();

    farms.insert(0, Farm.fromMap(res));
    notifyListeners();
  }

  Future<void> loadPlots(String farmId) async {
    final res = await _db
        .from("plots")
        .select()
        .eq("farm_id", farmId)
        .order("created_at", ascending: false);

    plots = res.map<Plot>((e) => Plot.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addPlot(Map<String, dynamic> data) async {
    final res = await _db.from("plots").insert(data).select().single();
    plots.insert(0, Plot.fromMap(res));
    notifyListeners();
  }
}
