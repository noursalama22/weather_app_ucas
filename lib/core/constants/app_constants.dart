import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String appName = 'Weather App';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String currentWeatherEndpoint = '/weather';
  static const String forecastEndpoint = '/forecast';
  static const String defaultLanguage = 'en';

  static const Duration requestTimeout = Duration(seconds: 15);

  static Future<void> loadEnv() async {
    await dotenv.load(fileName: '.env');
  }

  static String get openWeatherApiKey =>
      dotenv.env['OPENWEATHER_API_KEY'] ?? '';
}
