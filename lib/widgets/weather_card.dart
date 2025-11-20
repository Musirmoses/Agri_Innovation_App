import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> weather;
  final String recommendation;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final main = weather['list'][0]['main'];
    final temp = main['temp'];
    final humidity = main['humidity'];

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Weather",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.wb_sunny, size: 32, color: AppColors.primary),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Temp: $temp°C", style: const TextStyle(fontSize: 14)),
                    Text("Humidity: $humidity%",
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              recommendation,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
