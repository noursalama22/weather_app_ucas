import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';

class WeatherDashboardScreen extends StatelessWidget {
  const WeatherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          TextButton(
            onPressed: provider.toggleLanguage,
            child: Text(provider.language.toUpperCase()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search city',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => provider.searchCityWeather(value),
            ),
            const SizedBox(height: 16),
            if (provider.status == WeatherStatus.loading)
              const Center(child: CircularProgressIndicator()),
            if (provider.status == WeatherStatus.error)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red.shade100,
                child: Text(provider.errorMessage ?? 'Something went wrong'),
              ),
            const SizedBox(height: 16),
            const Expanded(
              child: Center(child: Text('Weather dashboard placeholder')),
            ),
          ],
        ),
      ),
    );
  }
}
