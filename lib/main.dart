import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/screens/weather_dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.loadEnv();

  final repository = WeatherRepositoryImpl(
    remoteDataSource: WeatherRemoteDataSourceImpl(),
    locationService: LocationServiceImpl(),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(
        repository: repository,
        locationService: LocationServiceImpl(),
      ),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WeatherDashboardScreen(),
    );
  }
}
