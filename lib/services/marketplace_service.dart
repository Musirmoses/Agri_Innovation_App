import '../models/supplier.dart';
import 'supabase_service.dart';

class MarketplaceService {
  final _db = SupabaseService().client;

  Future<List<Supplier>> fetchSuppliers() async {
    final response = await _db.from("seedling_suppliers").select();

    return response.map<Supplier>((e) => Supplier.fromMap(e)).toList();
  }

  Future<Supplier?> getSupplier(String id) async {
    final response = await _db
        .from("seedling_suppliers")
        .select()
        .eq("id", id)
        .maybeSingle();

    if (response == null) return null;
    return Supplier.fromMap(response);
  }

  Future<List<Supplier>> getSuppliersForCrop(String cropName) async {
    final response = await _db
        .from("seedling_suppliers")
        .select()
        .contains("crops", [cropName]);

    return response.map<Supplier>((e) => Supplier.fromMap(e)).toList();
  }
}
