import 'package:flutter/material.dart';

import '../models/supplier.dart';
import '../services/marketplace_service.dart';

class MarketplaceProvider extends ChangeNotifier {
  final MarketplaceService _service = MarketplaceService();

  List<Supplier> suppliers = [];
  bool isLoading = false;

  Future<void> loadSuppliers() async {
    isLoading = true;
    notifyListeners();

    suppliers = await _service.fetchSuppliers();

    isLoading = false;
    notifyListeners();
  }

  Future<List<Supplier>> findSuppliersForCrop(String crop) async {
    return await _service.getSuppliersForCrop(crop);
  }
}
