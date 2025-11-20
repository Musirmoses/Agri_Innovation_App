import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "YOUR_OPENWEATHER_API_KEY";

  Future<Map<String, dynamic>> getWeatherByCounty(String county) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$county,KE&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Weather API error: ${response.statusCode}");
    }

    return json.decode(response.body);
  }

  /// Simple logic for best planting week (based on rainfall forecast)
  String recommendPlanting(Map<String, dynamic> weather) {
    final list = weather['list'] as List;
    int rainDays = 0;

    for (final day in list.take(7)) {
      final rain = day['rain'] != null ? day['rain']['3h'] ?? 0 : 0;
      if (rain > 1) rainDays++;
    }

    if (rainDays >= 3) return "Good planting week 🌧️";
    return "Dry week — irrigation recommended 💧";
  }
}
