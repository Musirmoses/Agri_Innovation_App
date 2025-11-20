import 'package:flutter/material.dart';
import '../models/farm.dart';
import '../theme/app_colors.dart';

class FarmCard extends StatelessWidget {
  final Farm farm;
  final VoidCallback onTap;

  const FarmCard({
    super.key,
    required this.farm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.landscape, size: 40, color: AppColors.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farm.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "📍 ${farm.location ?? 'Unknown location'}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (farm.sizeAcres != null)
                      Text(
                        "Farm Size: ${farm.sizeAcres!.toStringAsFixed(1)} acres",
                        style: const TextStyle(fontSize: 13),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
