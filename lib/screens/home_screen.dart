import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';
import '../widgets/navigation_card.dart';
import '../widgets/news_card.dart';
import '../models/weather.dart';
import '../models/crop_history.dart';
import '../theme/app_theme.dart';
import 'analyze_crop_screen.dart';
import 'crop_yield_predictor_screen.dart';
import 'chatbot_screen.dart';
import 'crop_history_screen.dart';
import '../widgets/OnlineStatusIndicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

    // Sample news data
    final List<NewsItem> newsItems = [
      NewsItem(
        title: 'New Pest Management Techniques for Cotton Crops',
        description: 'Learn about the latest integrated pest management strategies...',
        imageUrl: '',
        publishDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NewsItem(
        title: 'Weather Alert: Heavy Rainfall Expected This Week',
        description: 'Farmers advised to take necessary precautions for their crops...',
        imageUrl: '',
        publishDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NewsItem(
        title: 'Government Announces New Subsidy Schemes',
        description: 'New agricultural subsidies available for small-scale farmers...',
        imageUrl: '',
        publishDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroVision'),
        backgroundColor: AppTheme.primaryGreen,
          actions: const [
      Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: Center(child: OnlineStatusIndicator()),
    ),
  ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Card
            WeatherCard(weather: weather),
            const SizedBox(height: 24),

            // Welcome Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Farmer!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How can we help you today?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Cards
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  NavigationCard(
                    title: 'Analyze My Crop',
                    icon: Icons.camera_alt,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalyzeCropScreen(),
                        ),
                      );
                    },
                  ),
                  NavigationCard(
                    title: 'Crop Yield Predictor',
                    icon: Icons.trending_up,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CropYieldPredictorScreen(),
                        ),
                      );
                    },
                  ),
                  NavigationCard(
                    title: 'Chatbot',
                    icon: Icons.chat,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatbotScreen(),
                        ),
                      );
                    },
                  ),
                  NavigationCard(
                    title: 'Crop History',
                    icon: Icons.history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CropHistoryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // News & Tips Section
            const Text(
              'News & Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                return NewsCard(newsItem: newsItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
