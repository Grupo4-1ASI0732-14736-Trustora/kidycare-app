import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Encuentra niñeras confiables",
      "subtitle": "KidyCare conecta a los padres con profesionales verificadas.",
    },
    {
      "title": "Reserva rápida",
      "subtitle": "Elige la niñera y agenda en segundos.",
    },
    {
      "title": "Seguro y confiable",
      "subtitle": "Con nuestro sistema de validación te sentirás tranquilo.",
    },
  ];

  /// 🚀 Guardamos en SharedPreferences que ya se vio el onboarding
  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);

    // 🔀 Pasamos al login
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          // ✅ Páginas del onboarding
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder para imagen/ilustración
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(Icons.child_care, size: 80),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    onboardingData[index]["title"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    onboardingData[index]["subtitle"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // ✅ Indicadores de página
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _pageIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _pageIndex == index
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onBackground.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),

          // ✅ Botón siguiente / terminar
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_pageIndex == onboardingData.length - 1) {
                  _finishOnboarding();
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
