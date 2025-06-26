import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/chart_widget.dart';

class YieldDetailsScreen extends StatelessWidget {
  final String state;
  final String crop;

  const YieldDetailsScreen({
    Key? key,
    required this.state,
    required this.crop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$crop Yield Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop image and basic info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Crop image placeholder
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGreen.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getCropIcon(crop),
                            size: 80,
                            color: AppTheme.primaryGreen,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            crop,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Basic information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem('State', state),
                        _buildInfoItem('Crop Type', crop),
                        _buildInfoItem('Season', _getCropSeason(crop)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Current statistics
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Average Yield',
                            '${_getAverageYield(crop)} tonnes/hectare',
                            Icons.trending_up,
                            AppTheme.primaryGreen,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatCard(
                            'Market Price',
                            '₹${_getMarketPrice(crop)}/quintal',
                            Icons.currency_rupee,
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Growing Period',
                            '${_getGrowingPeriod(crop)} days',
                            Icons.calendar_today,
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatCard(
                            'Water Requirement',
                            '${_getWaterRequirement(crop)} mm',
                            Icons.water_drop,
                            Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Yield prediction chart
            const YieldPredictionChart(),
            const SizedBox(height: 16),

            // Key insights
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInsightItem(
                      Icons.trending_up,
                      'Increasing Trend',
                      'Yield has shown a 12% increase over the last 5 years',
                      Colors.green,
                    ),
                    _buildInsightItem(
                      Icons.cloud,
                      'Weather Impact',
                      'Monsoon patterns significantly affect yield variability',
                      Colors.blue,
                    ),
                    _buildInsightItem(
                      Icons.science,
                      'Technology Adoption',
                      'Modern farming techniques can improve yield by 15-20%',
                      Colors.purple,
                    ),
                    _buildInsightItem(
                      Icons.warning,
                      'Risk Factors',
                      'Pest attacks and soil degradation are major concerns',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recommendations
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: AppTheme.primaryGreen,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Recommendations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildRecommendationItem('Use high-yield variety seeds'),
                    _buildRecommendationItem('Implement precision farming techniques'),
                    _buildRecommendationItem('Monitor soil health regularly'),
                    _buildRecommendationItem('Follow proper irrigation schedule'),
                    _buildRecommendationItem('Apply integrated pest management'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              recommendation,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCropIcon(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return Icons.grass;
      case 'wheat':
        return Icons.grain;
      case 'cotton':
        return Icons.eco;
      case 'sugarcane':
        return Icons.nature;
      default:
        return Icons.agriculture;
    }
  }

  String _getCropSeason(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return 'Kharif';
      case 'wheat':
        return 'Rabi';
      case 'cotton':
        return 'Kharif';
      case 'sugarcane':
        return 'Annual';
      default:
        return 'Seasonal';
    }
  }

  double _getAverageYield(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return 3.8;
      case 'wheat':
        return 3.2;
      case 'cotton':
        return 0.5;
      case 'sugarcane':
        return 70.0;
      default:
        return 2.5;
    }
  }

  int _getMarketPrice(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return 2500;
      case 'wheat':
        return 2200;
      case 'cotton':
        return 5500;
      case 'sugarcane':
        return 350;
      default:
        return 2000;
    }
  }

  int _getGrowingPeriod(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return 120;
      case 'wheat':
        return 150;
      case 'cotton':
        return 180;
      case 'sugarcane':
        return 365;
      default:
        return 90;
    }
  }

  int _getWaterRequirement(String crop) {
    switch (crop.toLowerCase()) {
      case 'rice':
        return 1500;
      case 'wheat':
        return 600;
      case 'cotton':
        return 800;
      case 'sugarcane':
        return 2000;
      default:
        return 500;
    }
  }
}
