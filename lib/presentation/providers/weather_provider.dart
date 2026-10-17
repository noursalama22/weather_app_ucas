import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository repository;
  final LocationService locationService;

  WeatherProvider({required this.repository, required this.locationService});

  WeatherStatus status = WeatherStatus.initial;
  WeatherEntity? currentWeather;
  List<WeatherEntity> forecast = const [];
  String? errorMessage;
  String language = 'en';
  String lastCityName = '';

  Future<void> loadCurrentLocationWeather() async {
    status = WeatherStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final position = await locationService.getCurrentPosition();
      final weather = await repository.getCurrentWeatherByLocation(
        position.latitude,
        position.longitude,
        language: language,
      );
      final upcoming = await repository.getForecastByLocation(
        position.latitude,
        position.longitude,
        language: language,
      );

      currentWeather = weather;
      forecast = upcoming.take(5).toList();
      lastCityName = weather.cityName;
      status = WeatherStatus.loaded;
      notifyListeners();
    } catch (e) {
      status = WeatherStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchCityWeather(String cityName) async {
    final trimmed = cityName.trim();
    if (trimmed.isEmpty) {
      status = WeatherStatus.error;
      errorMessage = 'City name cannot be empty';
      notifyListeners();
      return;
    }

    status = WeatherStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final weather = await repository.getCurrentWeatherByCity(
        trimmed,
        language: language,
      );
      final upcoming = await repository.getForecastByCity(
        trimmed,
        language: language,
      );

      currentWeather = weather;
      forecast = upcoming.take(5).toList();
      lastCityName = weather.cityName;
      status = WeatherStatus.loaded;
      notifyListeners();
    } catch (e) {
      status = WeatherStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void toggleLanguage() {
    language = language == 'en' ? 'ar' : 'en';
    if (lastCityName.isNotEmpty) {
      unawaited(searchCityWeather(lastCityName));
    }
    notifyListeners();
  }
}
