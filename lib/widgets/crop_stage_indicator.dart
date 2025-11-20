import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CropStageIndicator extends StatelessWidget {
  final int days;

  const CropStageIndicator({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    String stage = "Seedling";
    double progress = 0.2;

    if (days >= 10 && days < 30) {
      stage = "Vegetative";
      progress = 0.4;
    } else if (days >= 30 && days < 60) {
      stage = "Flowering";
      progress = 0.65;
    } else if (days >= 60) {
      stage = "Maturing";
      progress = 1.0;
    }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Growth Stage", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text("Current Stage: $stage"),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: AppColors.primary,
              backgroundColor: AppColors.muted.withOpacity(0.2),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}
