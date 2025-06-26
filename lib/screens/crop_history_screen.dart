import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/crop_history.dart';

class CropHistoryScreen extends StatelessWidget {
  const CropHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample crop history data
    final List<CropHistory> historyItems = [
      CropHistory(
        cropName: 'Wheat',
        dateAnalyzed: DateTime.now().subtract(const Duration(days: 2)),
        analysisType: 'Disease',
        resultSummary: 'Healthy crop, minor pest risk detected',
        imageUrl: '',
      ),
      CropHistory(
        cropName: 'Rice',
        dateAnalyzed: DateTime.now().subtract(const Duration(days: 5)),
        analysisType: 'Soil Health',
        resultSummary: 'Good soil condition, pH level optimal',
        imageUrl: '',
      ),
      CropHistory(
        cropName: 'Cotton',
        dateAnalyzed: DateTime.now().subtract(const Duration(days: 8)),
        analysisType: 'Both',
        resultSummary: 'Late blight detected, treatment recommended',
        imageUrl: '',
      ),
      CropHistory(
        cropName: 'Sugarcane',
        dateAnalyzed: DateTime.now().subtract(const Duration(days: 12)),
        analysisType: 'Soil Health',
        resultSummary: 'Nutrient deficiency identified, fertilization needed',
        imageUrl: '',
      ),
      CropHistory(
        cropName: 'Maize',
        dateAnalyzed: DateTime.now().subtract(const Duration(days: 15)),
        analysisType: 'Disease',
        resultSummary: 'Healthy crop, no issues found',
        imageUrl: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Crop History'),
      ),
      body: historyItems.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return CropHistoryCard(historyItem: historyItems[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No crop analysis history yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start analyzing your crops to see history here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class CropHistoryCard extends StatelessWidget {
  final CropHistory historyItem;

  const CropHistoryCard({Key? key, required this.historyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with crop name and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.lightGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCropIcon(historyItem.cropName),
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          historyItem.cropName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatDate(historyItem.dateAnalyzed),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getAnalysisTypeColor(historyItem.analysisType),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    historyItem.analysisType,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Result summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Analysis Result:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    historyItem.resultSummary,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showDetailedReport(context, historyItem);
                    },
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('View Report'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    _shareReport(context, historyItem);
                  },
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Share'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.earthyBrown,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCropIcon(String cropName) {
    switch (cropName.toLowerCase()) {
      case 'wheat':
        return Icons.grain;
      case 'rice':
        return Icons.grass;
      case 'cotton':
        return Icons.eco;
      case 'sugarcane':
        return Icons.nature;
      case 'maize':
        return Icons.agriculture;
      default:
        return Icons.eco;
    }
  }

  Color _getAnalysisTypeColor(String analysisType) {
    switch (analysisType.toLowerCase()) {
      case 'disease':
        return Colors.red;
      case 'soil health':
        return AppTheme.primaryGreen;
      case 'both':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showDetailedReport(BuildContext context, CropHistory historyItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${historyItem.cropName} Analysis Report'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildReportItem('Date Analyzed', _formatDate(historyItem.dateAnalyzed)),
                _buildReportItem('Analysis Type', historyItem.analysisType),
                _buildReportItem('Result Summary', historyItem.resultSummary),
                const SizedBox(height: 16),
                const Text(
                  'Detailed Report:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'This is a placeholder for the detailed analysis report. In a real implementation, this would contain comprehensive information about the crop analysis including charts, recommendations, and treatment plans.',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _shareReport(context, historyItem);
              },
              child: const Text('Share Report'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _shareReport(BuildContext context, CropHistory historyItem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${historyItem.cropName} analysis report...'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }
}
