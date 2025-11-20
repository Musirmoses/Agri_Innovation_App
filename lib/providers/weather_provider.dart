import 'package:flutter/material.dart';

import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final _weather = WeatherService();

  Map<String, dynamic>? weatherData;
  String? recommendation;
  bool isLoading = false;

  Future<void> loadWeather(String county) async {
    isLoading = true;
    notifyListeners();

    try {
      weatherData = await _weather.getWeatherByCounty(county);
      recommendation = _weather.recommendPlanting(weatherData!);
    } catch (e) {
      debugPrint("Weather error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
