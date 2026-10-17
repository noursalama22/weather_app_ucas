class WeatherFormatters {
  static String toCelsius(num value) => '${value.toStringAsFixed(0)}°C';

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
