class WeatherEntity {
  final String cityName;
  final String description;
  final String iconCode;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final DateTime dateTime;

  const WeatherEntity({
    required this.cityName,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
  });
}
