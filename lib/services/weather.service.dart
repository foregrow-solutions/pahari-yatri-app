import 'package:http/http.dart' as http;
import 'dart:convert';

import '../common/app.config.dart';

class WeatherService {
  static Future<String> getWeatherReport(double latitude, double longitude, DateTime dateTime) async {
    const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'dt': (dateTime.millisecondsSinceEpoch ~/ 1000).toString(),
      'appid': openWeatherAPIKey,
    };

    final uri = Uri.parse(apiUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final weatherDescription =
      weatherData['weather'][0]['description'] as String;
      final temperature = weatherData['main']['temp'] as double;
      final cityName = weatherData['name'] as String;

      return 'Weather report for $cityName on ${dateTime.toString()}: \n'
          'Description: $weatherDescription\n'
          'Temperature: $temperature°C';
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
