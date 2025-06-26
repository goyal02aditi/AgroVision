import 'package:flutter/material.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/chart_widget.dart';
import '../models/weather.dart';

class CropAnalysisResultsScreen extends StatelessWidget {
  final File image;

  const CropAnalysisResultsScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample weather data
    final weather = Weather(
      location: 'Punjab, India',
      temperature: 25,
      minTemp: 18,
      maxTemp: 32,
      humidity: 65,
      pressure: 1013.25,
      windSpeed: 12,
      clouds: 20,
      condition: 'Sunny',
      icon: 'sunny',
    );

    // Sample forecast data
    final List<WeatherForecast> forecast = [
      WeatherForecast(
        day: 'Today',
        date: '26/06',
        temperature: 25,
        condition: 'Sunny',
        icon: 'sunny',
      ),
      WeatherForecast(
        day: 'Tomorrow',
        date: '27/06',
        temperature: 28,
        condition: 'Cloudy',
        icon: 'cloudy',
      ),
      WeatherForecast(
        day: 'Thu',
        date: '28/06',
        temperature: 22,
        condition: 'Rainy',
        icon: 'rainy',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Analysis Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location detected from image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          weather.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Current Weather
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Weather',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherItem('Temperature', '${weather.minTemp}°C - ${weather.maxTemp}°C'),
                        _buildWeatherItem('Humidity', '${weather.humidity}%'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherItem('Pressure', '${weather.pressure} mb'),
                        _buildWeatherItem('Wind', '${weather.windSpeed} km/h'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherItem('Clouds', '${weather.clouds}%'),
                        _buildWeatherItem('Precipitation', '0 mm'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3-Day Forecast
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3-Day Forecast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: forecast.length,
                        itemBuilder: (context, index) {
                          final item = forecast[index];
                          return Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: AppTheme.lightGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.day,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.date,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Icon(
                                  _getWeatherIcon(item.condition),
                                  color: AppTheme.primaryGreen,
                                  size: 24,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.temperature}°C',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Additional data cards
            Row(
              children: [
                Expanded(
                  child: _buildDataCard('Soil Moisture', '68%', Icons.water_drop),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDataCard('Evapotranspiration', '4.2 mm/day', Icons.cloud_upload),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildDataCard('Flux', '245 W/m²', Icons.flash_on),
            const SizedBox(height: 16),

            // Charts
            const SoilHealthChart(),
            const SizedBox(height: 16),
            const YieldComparisonChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryGreen,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.cloud;
      case 'rainy':
        return Icons.grain;
      default:
        return Icons.wb_sunny;
    }
  }
}
