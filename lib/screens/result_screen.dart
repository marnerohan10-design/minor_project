import 'package:flutter/material.dart';

import 'quiz_screen.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    required this.correctAnswers,
    required this.questionCount,
    super.key,
  });

  final int correctAnswers;
  final int questionCount;

  @override
  Widget build(BuildContext context) {
    final incorrectAnswers = questionCount - correctAnswers;
    final percentage = (correctAnswers / questionCount * 100).round();
    final message =
        percentage >= 80
            ? 'Excellent work!'
            : percentage >= 50
            ? 'Good effort!'
            : 'Keep learning!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1EFE9),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.emoji_events_outlined,
                          color: Color(0xFF176B5B),
                          size: 42,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          message,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF17352E),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$correctAnswers / $questionCount',
                          style: Theme.of(
                            context,
                          ).textTheme.displaySmall?.copyWith(
                            color: const Color(0xFF176B5B),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '$percentage% score',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFF52635D)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _ScoreRow(
                    label: 'Correct answers',
                    count: correctAnswers,
                    icon: Icons.check_circle_outline_rounded,
                    color: const Color(0xFF28734C),
                  ),
                  const SizedBox(height: 10),
                  _ScoreRow(
                    label: 'Incorrect answers',
                    count: incorrectAnswers,
                    icon: Icons.highlight_off_rounded,
                    color: const Color(0xFFB54432),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (context) => const QuizScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Restart quiz'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF176B5B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home_outlined),
                    label: const Text('Back to welcome'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF176B5B),
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

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String label;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 62),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E7E3)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF344A43),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$count',
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
