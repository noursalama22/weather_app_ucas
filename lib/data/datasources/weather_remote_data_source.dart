import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> fetchCurrentWeatherByCity(
    String cityName, {
    String language = 'en',
  });

  Future<WeatherModel> fetchCurrentWeatherByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  });

  Future<List<WeatherModel>> fetchForecastByCity(
    String cityName, {
    String language = 'en',
  });

  Future<List<WeatherModel>> fetchForecastByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({http.Client? client})
    : client = client ?? http.Client();

  String _apiKeyOrThrow() {
    final apiKey = AppConstants.openWeatherApiKey;
    if (apiKey.isEmpty) {
      throw Exception(
        'Missing OPENWEATHER_API_KEY. Add it to a local .env file before running the app.',
      );
    }
    return apiKey;
  }

  @override
  Future<WeatherModel> fetchCurrentWeatherByCity(
    String cityName, {
    String language = 'en',
  }) async {
    final apiKey = _apiKeyOrThrow();
    final response = await client
        .get(
          Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.currentWeatherEndpoint}?q=$cityName&appid=$apiKey&units=metric&lang=$language',
          ),
        )
        .timeout(AppConstants.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch current weather for city');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherModel.fromJson(json, cityName: cityName);
  }

  @override
  Future<WeatherModel> fetchCurrentWeatherByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  }) async {
    final apiKey = _apiKeyOrThrow();
    final response = await client
        .get(
          Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.currentWeatherEndpoint}?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=$language',
          ),
        )
        .timeout(AppConstants.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch current weather by location');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherModel.fromJson(json);
  }

  @override
  Future<List<WeatherModel>> fetchForecastByCity(
    String cityName, {
    String language = 'en',
  }) async {
    final apiKey = _apiKeyOrThrow();
    final response = await client
        .get(
          Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.forecastEndpoint}?q=$cityName&appid=$apiKey&units=metric&lang=$language',
          ),
        )
        .timeout(AppConstants.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch forecast for city');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final list = (json['list'] as List?) ?? const [];

    return list
        .map((item) => WeatherModel.fromJson(item, cityName: cityName))
        .toList();
  }

  @override
  Future<List<WeatherModel>> fetchForecastByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  }) async {
    final apiKey = _apiKeyOrThrow();
    final response = await client
        .get(
          Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.forecastEndpoint}?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=$language',
          ),
        )
        .timeout(AppConstants.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch forecast by location');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final list = (json['list'] as List?) ?? const [];

    return list.map((item) => WeatherModel.fromJson(item)).toList();
  }
}
