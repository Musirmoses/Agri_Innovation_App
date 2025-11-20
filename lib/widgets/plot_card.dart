import 'package:flutter/material.dart';
import '../models/plot.dart';
import '../theme/app_colors.dart';

class PlotCard extends StatelessWidget {
  final Plot plot;
  final VoidCallback onTap;

  const PlotCard({
    super.key,
    required this.plot,
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
              const Icon(Icons.square_foot, size: 38, color: AppColors.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plot.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (plot.size != null)
                      Text(
                        "Size: ${plot.size} acres",
                        style: const TextStyle(fontSize: 13),
                      ),
                    if (plot.cropType != null)
                      Text(
                        "Crop: ${plot.cropType}",
                        style: const TextStyle(fontSize: 13),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
