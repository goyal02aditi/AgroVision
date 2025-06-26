import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'about_us_screen.dart';
import 'report_issue_screen.dart';
import 'terms_conditions_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.lightGreen),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help,
                        color: AppTheme.primaryGreen,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'How can we help you?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find answers to your questions or get in touch with our support team.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Help options
            _buildHelpOption(
              context,
              icon: Icons.info,
              title: 'About Us',
              description: 'Learn more about AgroVision and our mission',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),
            _buildHelpOption(
              context,
              icon: Icons.bug_report,
              title: 'Report an Issue',
              description: 'Found a problem? Let us know so we can fix it',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportIssueScreen(),
                  ),
                );
              },
            ),
            _buildHelpOption(
              context,
              icon: Icons.description,
              title: 'Terms and Conditions',
              description: 'Read our terms of service and privacy policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsConditionsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // FAQ Section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFAQItem(
              'How accurate is the crop disease diagnosis?',
              'Our AI-powered diagnosis system has an accuracy rate of over 90% for common crop diseases. However, we recommend consulting with agricultural experts for critical decisions.',
            ),
            _buildFAQItem(
              'Can I use the app offline?',
              'Some features like crop history and saved reports can be accessed offline. However, disease diagnosis and weather data require an internet connection.',
            ),
            _buildFAQItem(
              'How do I get better analysis results?',
              'For best results, take clear, well-lit photos of affected plant parts. Ensure the camera is steady and focus on the specific symptoms you want analyzed.',
            ),
            _buildFAQItem(
              'Is my data secure?',
              'Yes, we take data security seriously. All your crop data and photos are encrypted and stored securely. We do not share your personal information with third parties.',
            ),
            const SizedBox(height: 24),

            // Contact section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support,
                        color: Colors.blue,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Still need help?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Contact our support team:'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue, size: 16),
                      const SizedBox(width: 4),
                      const Text('support@agrovision.com'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue, size: 16),
                      const SizedBox(width: 4),
                      const Text('+91 1234567890'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
