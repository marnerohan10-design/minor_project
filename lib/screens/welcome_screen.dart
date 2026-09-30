import 'package:flutter/material.dart';

import 'quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCEFE8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline_rounded,
                      color: Color(0xFF176B5B),
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'THINK. PICK.\nLEARN.',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF176B5B),
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Smart Quiz',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: const Color(0xFF17352E),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'A quick mix of questions to put your knowledge to the test. Choose your answers, beat the clock, and see how you did.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF52635D),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _QuizFact(
                    icon: Icons.quiz_outlined,
                    label: '10 general knowledge questions',
                  ),
                  const SizedBox(height: 12),
                  const _QuizFact(
                    icon: Icons.timer_outlined,
                    label: '20 seconds to answer each one',
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => const QuizScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Start quiz'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF176B5B),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizFact extends StatelessWidget {
  const _QuizFact({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF176B5B), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF344A43),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
