import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agrovision/screens/home_screen.dart'; // existing home



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboard1.jpg',
      'text': 'Identify plant diseases with a single click.',
    },
    {
      'image': 'assets/images/onboard2.jpg',
      'text': 'Get actionable farming tips and guidance.',
    },
    {
      'image': 'assets/images/onboard3.jpg',
      'text': 'Let us revolutionize farming with tech!',
    },
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(onboardingData[index]['image']!, height: 300),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  onboardingData[index]['text']!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.green[800],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (dotIndex) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == dotIndex
                          ? Colors.green
                          : Colors.green.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              IconButton(
                onPressed: _nextPage,
                icon: const Icon(Icons.arrow_forward, size: 30),
              ),
            ],
          );
        },
      ),
    );
  }
}
