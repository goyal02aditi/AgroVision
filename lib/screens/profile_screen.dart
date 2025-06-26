import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User profile section
            Container(
              padding: const EdgeInsets.all(20),
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
                  // User avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryGreen,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // User name
                  const Text(
                    'Farmer Singh',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Punjab, India',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Join date
                  Text(
                    'Member since June 2024',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile options
            _buildProfileOption(
              context,
              icon: Icons.account_circle,
              title: 'My Account',
              subtitle: 'Edit profile and account settings',
              onTap: () {
                _showAccountSettings(context);
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.privacy_tip,
              title: 'Privacy Policy',
              subtitle: 'View our privacy policy and data usage',
              onTap: () {
                _showPrivacyPolicy(context);
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.star_rate,
              title: 'Rate Us',
              subtitle: 'Help us improve by rating the app',
              onTap: () {
                _showRateApp(context);
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Manage your notification preferences',
              onTap: () {
                _showNotificationSettings(context);
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.language,
              title: 'Language',
              subtitle: 'Choose your preferred language',
              onTap: () {
                _showLanguageSettings(context);
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.help,
              title: 'Help & Support',
              subtitle: 'Get help and contact support',
              onTap: () {
                // Navigate to help screen (handled by bottom navigation)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Use the Help tab for support'),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
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
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
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

  void _showAccountSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Settings'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile'),
                  subtitle: Text('Update your personal information'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                  subtitle: Text('+91 9876543210'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email Address'),
                  subtitle: Text('farmer.singh@example.com'),
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Change Password'),
                  subtitle: Text('Update your account password'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'AgroVision Privacy Policy\n\n'
              'We are committed to protecting your privacy and ensuring the security of your personal information.\n\n'
              'Data Collection:\n'
              '• We collect crop images and analysis data to provide our services\n'
              '• Location data is used for weather and regional recommendations\n'
              '• Usage data helps us improve our AI models\n\n'
              'Data Usage:\n'
              '• Your data is used solely for providing agricultural insights\n'
              '• We do not sell or share personal data with third parties\n'
              '• All data is encrypted and stored securely\n\n'
              'Your Rights:\n'
              '• You can request deletion of your data at any time\n'
              '• You have access to all data we store about you\n'
              '• You can opt out of data collection features\n\n'
              'Contact us at privacy@agrovision.com for any privacy concerns.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showRateApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate AgroVision'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How would you rate your experience with AgroVision?'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 32,
                    color: Colors.amber,
                  );
                }),
              ),
              const SizedBox(height: 16),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tell us what you think... (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
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
                    content: Text('Thank you for your feedback!'),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Settings'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: Text('Weather Alerts'),
                  subtitle: Text('Get notified about weather changes'),
                  value: true,
                  onChanged: null,
                ),
                SwitchListTile(
                  title: Text('Disease Warnings'),
                  subtitle: Text('Alerts about crop disease risks'),
                  value: true,
                  onChanged: null,
                ),
                SwitchListTile(
                  title: Text('Market Updates'),
                  subtitle: Text('Price updates and market news'),
                  value: false,
                  onChanged: null,
                ),
                SwitchListTile(
                  title: Text('App Updates'),
                  subtitle: Text('Notifications about new features'),
                  value: true,
                  onChanged: null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: 'en',
                  onChanged: (value) {},
                ),
                RadioListTile<String>(
                  title: const Text('हिंदी (Hindi)'),
                  value: 'hi',
                  groupValue: 'en',
                  onChanged: (value) {},
                ),
                RadioListTile<String>(
                  title: const Text('ਪੰਜਾਬੀ (Punjabi)'),
                  value: 'pa',
                  groupValue: 'en',
                  onChanged: (value) {},
                ),
                RadioListTile<String>(
                  title: const Text('मराठी (Marathi)'),
                  value: 'mr',
                  groupValue: 'en',
                  onChanged: (value) {},
                ),
              ],
            ),
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
                    content: Text('Language preference saved'),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
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
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
