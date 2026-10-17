import 'package:weather_app/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.minTemperature,
    required super.maxTemperature,
    required super.humidity,
    required super.windSpeed,
    required super.dateTime,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json, {
    String cityName = '',
  }) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? const [];
    final weather = weatherList.isNotEmpty
        ? weatherList.first as Map<String, dynamic>
        : <String, dynamic>{};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final dt = json['dt'] is int
        ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
        : DateTime.now();

    return WeatherModel(
      cityName: cityName.isNotEmpty
          ? cityName
          : (json['name'] ?? 'Unknown City').toString(),
      description: (weather['description'] ?? 'clear sky').toString(),
      iconCode: (weather['icon'] ?? '01d').toString(),
      temperature: (main['temp'] as num?)?.toDouble() ?? 0.0,
      minTemperature: (main['temp_min'] as num?)?.toDouble() ?? 0.0,
      maxTemperature: (main['temp_max'] as num?)?.toDouble() ?? 0.0,
      humidity: (main['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      dateTime: dt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'description': description,
      'iconCode': iconCode,
      'temperature': temperature,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
