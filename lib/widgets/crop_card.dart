import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../theme/app_colors.dart';

class CropCard extends StatelessWidget {
  final Crop crop;
  final VoidCallback onTap;

  const CropCard({
    super.key,
    required this.crop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Icon(Icons.local_florist,
                  size: 38, color: AppColors.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crop.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Planted: ${crop.plantedOn.toLocal().toString().split(' ')[0]}",
                      style: const TextStyle(fontSize: 13),
                    ),
                    if (crop.expectedHarvest != null)
                      Text(
                        "Harvest: ${crop.expectedHarvest!.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(fontSize: 13),
                      ),
                    if (crop.growthStage != null)
                      Text(
                        "Stage: ${crop.growthStage}",
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
