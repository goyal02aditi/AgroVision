import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import 'choose_analysis_screen.dart';
import 'package:path_provider/path_provider.dart';


class AnalyzeCropScreen extends StatefulWidget {
  const AnalyzeCropScreen({Key? key}) : super(key: key);

  @override
  State<AnalyzeCropScreen> createState() => _AnalyzeCropScreenState();
}

class _AnalyzeCropScreenState extends State<AnalyzeCropScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

Future<void> _pickImage(ImageSource source) async {
  try {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return; // User canceled

    final pickedImage = File(image.path);

    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/AgroVisionImages');

    // Create directory if it doesn't exist
    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    final savedImage = await pickedImage.copy(
      '${saveDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    setState(() {
      _selectedImage = savedImage;
    });

    // Navigate to analysis screen
 
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking image: $e')),
    );
  }
}


  Future<List<File>> _loadSavedImages() async {
  final dir = await getApplicationDocumentsDirectory();
  final imagesDir = Directory('${dir.path}/AgroVisionImages');
  if (!await imagesDir.exists()) return [];
  final files = imagesDir
      .listSync()
      .where((f) => f.path.endsWith('.jpg') || f.path.endsWith('.png'))
      .map((f) => File(f.path))
      .toList();
  return files.reversed.toList(); // latest first
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyze My Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null) ...[
  const SizedBox(height: 16),
  const Text(
    'Preview:',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  ),
  const SizedBox(height: 8),
  Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(_selectedImage!, fit: BoxFit.cover),
    ),
  ),
  const SizedBox(height: 16),
  ElevatedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChooseAnalysisScreen(image: _selectedImage!),
        ),
      );
    },
    icon: Icon(Icons.arrow_forward),
    label: Text('Next'),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
],

            // Upload instruction
            Container(
              padding: const EdgeInsets.all(24),
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
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 80,
                    color: AppTheme.primaryGreen,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upload a Photo of Your Crop',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Take a clear photo of your crop for analysis',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Camera and gallery buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Previously Uploaded',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      FutureBuilder<List<File>>(
        future: _loadSavedImages(), // Function we'll define next
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final images = snapshot.data!;
          if (images.isEmpty) {
            return const Text('No images yet.');
          }
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ChooseAnalysisScreen(image: images[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ],
  ),
),

              ],
            ),
            const SizedBox(height: 24),

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
                        'Tips for better analysis:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('• Ensure good lighting'),
                  const Text('• Keep the camera steady'),
                  const Text('• Focus on the crop leaves and stems'),
                  const Text('• Avoid shadows and reflections'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
