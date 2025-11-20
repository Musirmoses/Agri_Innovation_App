import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/marketplace_provider.dart';
import '../../widgets/market_price_card.dart';
import '../../navigation/routes.dart';

class SeedlingMarketScreen extends StatefulWidget {
  const SeedlingMarketScreen({super.key});

  @override
  State<SeedlingMarketScreen> createState() => _SeedlingMarketScreenState();
}

class _SeedlingMarketScreenState extends State<SeedlingMarketScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MarketplaceProvider>(context, listen: false).loadSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarketplaceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Seedling Marketplace")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.suppliers.length,
              itemBuilder: (context, index) {
                final supplier = provider.suppliers[index];
                return MarketPriceCard(
                  supplier: supplier,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.supplierDetail,
                      arguments: supplier,
                    );
                  },
                );
              },
            ),
    );
  }
}
