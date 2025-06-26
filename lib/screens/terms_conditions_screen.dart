import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                        Icons.description,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Legal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please read these terms and conditions carefully before using AgroVision.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last updated: June 26, 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Terms content
            _buildSection(
              'Terms of Service',
              'By downloading, installing, or using AgroVision, you agree to be bound by these Terms of Service. If you disagree with any part of these terms, then you may not access the service.',
            ),
            _buildSection(
              'Use License',
              'Permission is granted to temporarily use AgroVision for personal, non-commercial agricultural purposes. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n'
              '• Modify or copy the materials\n'
              '• Use the materials for any commercial purpose\n'
              '• Attempt to reverse engineer the software\n'
              '• Remove any copyright or proprietary notations',
            ),
            _buildSection(
              'User Accounts',
              'When you create an account with us, you must provide information that is accurate, complete, and current at all times. You are responsible for safeguarding the password and for all activities that occur under your account.',
            ),
            _buildSection(
              'Data Collection and Privacy',
              'We collect and process your personal data in accordance with our Privacy Policy. By using AgroVision, you consent to the collection and processing of your data as described in our Privacy Policy.',
            ),
            _buildSection(
              'Content Ownership',
              'The service and its original content, features, and functionality are and will remain the exclusive property of AgroVision and its licensors. The service is protected by copyright, trademark, and other laws.',
            ),
            _buildSection(
              'Prohibited Uses',
              'You may not use our service:\n\n'
              '• For any unlawful purpose or to solicit others to perform unlawful acts\n'
              '• To violate any international, federal, provincial, or state regulations, rules, laws, or local ordinances\n'
              '• To infringe upon or violate our intellectual property rights or the intellectual property rights of others\n'
              '• To harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate\n'
              '• To submit false or misleading information',
            ),
            _buildSection(
              'Service Availability',
              'AgroVision is provided on an "as is" and "as available" basis. We do not guarantee that the service will be uninterrupted, timely, secure, or error-free. We reserve the right to modify or discontinue the service at any time.',
            ),
            _buildSection(
              'Limitation of Liability',
              'In no event shall AgroVision, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.',
            ),
            _buildSection(
              'Disclaimer',
              'The information, recommendations, and analysis provided by AgroVision are for informational purposes only and should not be considered as professional agricultural advice. Always consult with qualified agricultural professionals before making farming decisions.',
            ),
            _buildSection(
              'Governing Law',
              'These terms shall be interpreted and governed by the laws of India, without regard to its conflict of law provisions. Any disputes arising from these terms will be subject to the jurisdiction of the courts in Punjab, India.',
            ),
            _buildSection(
              'Changes to Terms',
              'We reserve the right to modify or replace these terms at any time. If a revision is material, we will try to provide at least 30 days notice prior to any new terms taking effect.',
            ),
            _buildSection(
              'Contact Information',
              'If you have any questions about these Terms and Conditions, please contact us:\n\n'
              'Email: legal@agrovision.com\n'
              'Phone: +91 1234567890\n'
              'Address: Agricultural Tech Hub, Punjab, India',
            ),

            const SizedBox(height: 32),

            // Acceptance section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.handshake,
                        color: Colors.blue,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Acceptance of Terms',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'By using AgroVision, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Terms and Conditions accepted'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Accept Terms'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showPrintDialog(context);
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print/Save'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  void _showPrintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Print/Save Terms'),
          content: const Text(
            'This feature would allow you to print or save the terms and conditions to your device. In a real implementation, this would generate a PDF or open the system print dialog.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Terms saved to device'),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
