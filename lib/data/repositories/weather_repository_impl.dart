import 'package:weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final LocationService locationService;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.locationService,
  });

  @override
  Future<WeatherEntity> getCurrentWeatherByCity(
    String cityName, {
    String language = 'en',
  }) {
    return remoteDataSource.fetchCurrentWeatherByCity(
      cityName,
      language: language,
    );
  }

  @override
  Future<WeatherEntity> getCurrentWeatherByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  }) {
    return remoteDataSource.fetchCurrentWeatherByLocation(
      latitude,
      longitude,
      language: language,
    );
  }

  @override
  Future<List<WeatherEntity>> getForecastByCity(
    String cityName, {
    String language = 'en',
  }) {
    return remoteDataSource.fetchForecastByCity(cityName, language: language);
  }

  @override
  Future<List<WeatherEntity>> getForecastByLocation(
    double latitude,
    double longitude, {
    String language = 'en',
  }) {
    return remoteDataSource.fetchForecastByLocation(
      latitude,
      longitude,
      language: language,
    );
  }
}
