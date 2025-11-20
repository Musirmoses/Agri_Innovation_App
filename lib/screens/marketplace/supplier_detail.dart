import 'package:flutter/material.dart';
import '../../models/supplier.dart';
import '../../theme/app_colors.dart';

class SupplierDetailScreen extends StatelessWidget {
  final Supplier supplier;

  const SupplierDetailScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(supplier.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Supplier Name
            Text(
              supplier.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            // Location
            if (supplier.location != null)
              Text(
                "Location: ${supplier.location}",
                style: const TextStyle(fontSize: 14),
              ),

            // Phone
            if (supplier.phone != null)
              Text(
                "Phone: ${supplier.phone}",
                style: const TextStyle(fontSize: 14),
              ),

            const SizedBox(height: 20),

            const Text(
              "Available Seedlings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Crops + Prices List
            ...supplier.crops.map(
              (crop) {
                final price = supplier.prices?[crop]?.toString() ?? "N/A";
                return Card(
                  child: ListTile(
                    title: Text(crop),
                    subtitle: Text("KES $price / seedling"),
                    trailing: const Icon(Icons.local_florist, color: AppColors.primary),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
