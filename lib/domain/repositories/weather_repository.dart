import 'package:weather_app/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeatherByCity(
    String cityName, {
    String language = 'en',
  });

  Future<WeatherEntity> getCurrentWeatherByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  });

  Future<List<WeatherEntity>> getForecastByCity(
    String cityName, {
    String language = 'en',
  });

  Future<List<WeatherEntity>> getForecastByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  });
}
