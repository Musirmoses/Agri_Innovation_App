import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../theme/app_colors.dart';

class CropHealthWidget extends StatelessWidget {
  final Crop crop;

  const CropHealthWidget({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    final disease = crop.diseaseStatus ?? "Healthy";

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Health Status",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  disease == "Healthy"
                      ? Icons.check_circle
                      : Icons.warning_rounded,
                  color: disease == "Healthy"
                      ? AppColors.success
                      : AppColors.warning,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Text(
                  disease,
                  style: TextStyle(
                    fontSize: 16,
                    color: disease == "Healthy"
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // SDG supportive advice
            if (disease != "Healthy")
              Text(
                "Recommended Action:\n• Remove infected leaves\n• Use organic pesticide\n• Improve spacing & airflow",
                style: const TextStyle(fontSize: 14),
              )
            else
              const Text(
                "Your crop is healthy. Keep monitoring irrigation and fertilizer schedule.",
                style: TextStyle(fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}
