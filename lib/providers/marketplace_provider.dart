import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/supplier.dart';

class MarketplaceProvider extends ChangeNotifier {
  final _client = SupabaseService().client;
  bool isLoading = false;
  List<Supplier> suppliers = [];

  Future<void> loadSuppliers() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _client
          .from('suppliers')
          .select('*, seedlings(*)')
          .order('name', ascending: true);

      suppliers = (data as List<dynamic>).map((s) {
        // seedlings will be a list of maps
        final seedlings = (s['seedlings'] as List<dynamic>?)
                ?.map((d) => {
                      'crop': d['crop_name'],
                      'price': d['price'],
                      'qty': d['quantity_available']
                    })
                .toList() ??
            [];

        return Supplier.fromMap({
          'id': s['id'],
          'name': s['name'],
          'location': s['location'],
          'phone': s['phone'],
          'rating': s['rating'],
          'crops': seedlings.map((e) => e['crop']).toList(),
          'prices': {for (var e in seedlings) e['crop']: e['price']}
        });
      }).toList();
    } catch (e) {
      // optionally log
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
