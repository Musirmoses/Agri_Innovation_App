import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/weather_provider.dart';
import '../../widgets/weather_card.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key});

  @override
  State<WeatherDashboard> createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  final countyCtrl = TextEditingController(text: "Nairobi");

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Weather & Recommendations")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: countyCtrl,
              decoration: const InputDecoration(
                labelText: "Enter County",
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => provider.loadWeather(countyCtrl.text.trim()),
              child: const Text("Check Weather"),
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.weatherData == null
                    ? const SizedBox()
                    : WeatherCard(
                        weather: provider.weatherData!,
                        recommendation: provider.recommendation!,
                      ),
          ],
        ),
      ),
    );
  }
}
