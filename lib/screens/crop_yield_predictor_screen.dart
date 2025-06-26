import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import 'yield_details_screen.dart';

class CropYieldPredictorScreen extends StatefulWidget {
  const CropYieldPredictorScreen({Key? key}) : super(key: key);

  @override
  State<CropYieldPredictorScreen> createState() => _CropYieldPredictorScreenState();
}

class _CropYieldPredictorScreenState extends State<CropYieldPredictorScreen> {
  String? selectedState;
  String? selectedCrop;
  List<String> availableCrops = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Yield Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.lightGreen),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppTheme.primaryGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Yield Prediction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select your state and crop to view historical yield data and future predictions.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // State selection
            const Text(
              'Select State:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryGreen),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedState,
                  hint: const Text('Choose your state'),
                  isExpanded: true,
                  items: Constants.indianStates.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedState = newValue;
                      selectedCrop = null; // Reset crop selection
                      if (newValue != null) {
                        availableCrops = Constants.cropsByState[newValue] ?? Constants.defaultCrops;
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Crop selection
            const Text(
              'Select Crop:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedState != null ? AppTheme.primaryGreen : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCrop,
                  hint: Text(
                    selectedState != null ? 'Choose your crop' : 'Select state first',
                    style: TextStyle(
                      color: selectedState != null ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  isExpanded: true,
                  items: availableCrops.map((String crop) {
                    return DropdownMenuItem<String>(
                      value: crop,
                      child: Text(crop),
                    );
                  }).toList(),
                  onChanged: selectedState != null
                      ? (String? newValue) {
                          setState(() {
                            selectedCrop = newValue;
                          });
                        }
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // View Details button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedState != null && selectedCrop != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YieldDetailsScreen(
                              state: selectedState!,
                              crop: selectedCrop!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Information cards
            if (selectedState != null && selectedCrop != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppTheme.primaryGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Selected Region: $selectedState',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.eco,
                            color: AppTheme.primaryGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Selected Crop: $selectedCrop',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const Spacer(),

            // Bottom info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Predictions are based on historical data, weather patterns, and agricultural trends.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
