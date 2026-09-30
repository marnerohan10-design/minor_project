import 'dart:async';

import 'package:flutter/material.dart';

import '../data/quiz_questions.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const _secondsPerQuestion = 20;

  Timer? _timer;
  int _questionIndex = 0;
  int _selectedAnswerIndex = -1;
  int _correctAnswers = 0;
  int _secondsRemaining = _secondsPerQuestion;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        _submitAnswer();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _submitAnswer() {
    if (_hasSubmitted) return;

    _timer?.cancel();
    setState(() {
      _hasSubmitted = true;
      if (_selectedAnswerIndex ==
          quizQuestions[_questionIndex].correctAnswerIndex) {
        _correctAnswers++;
      }
    });
  }

  void _advanceQuestion() {
    if (_questionIndex == quizQuestions.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder:
              (context) => ResultScreen(
                correctAnswers: _correctAnswers,
                questionCount: quizQuestions.length,
              ),
        ),
      );
      return;
    }

    setState(() {
      _questionIndex++;
      _selectedAnswerIndex = -1;
      _hasSubmitted = false;
      _secondsRemaining = _secondsPerQuestion;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[_questionIndex];
    final progress = (_questionIndex + 1) / quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Quiz'),
        leading: IconButton(
          tooltip: 'Exit quiz',
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'QUESTION ${_questionIndex + 1} OF ${quizQuestions.length}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF52635D),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 18,
                            color:
                                _secondsRemaining <= 5
                                    ? const Color(0xFFB54432)
                                    : const Color(0xFF176B5B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$_secondsRemaining s',
                            style: TextStyle(
                              color:
                                  _secondsRemaining <= 5
                                      ? const Color(0xFFB54432)
                                      : const Color(0xFF17352E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor: const Color(0xFFDCE5E0),
                      color: const Color(0xFF176B5B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF17352E),
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: question.options.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final isSelected = _selectedAnswerIndex == index;
                        final isCorrect = index == question.correctAnswerIndex;
                        final showCorrect = _hasSubmitted && isCorrect;
                        final showIncorrect =
                            _hasSubmitted && isSelected && !isCorrect;
                        final backgroundColor =
                            showCorrect
                                ? const Color(0xFFE0F2E8)
                                : showIncorrect
                                ? const Color(0xFFFFE8E2)
                                : isSelected
                                ? const Color(0xFFE4F0EC)
                                : Colors.white;
                        final borderColor =
                            showCorrect
                                ? const Color(0xFF3E8A60)
                                : showIncorrect
                                ? const Color(0xFFCA654F)
                                : isSelected
                                ? const Color(0xFF176B5B)
                                : const Color(0xFFE0E7E3);

                        return Semantics(
                          button: !_hasSubmitted,
                          selected: isSelected,
                          child: InkWell(
                            onTap:
                                _hasSubmitted
                                    ? null
                                    : () => setState(
                                      () => _selectedAnswerIndex = index,
                                    ),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 58),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: borderColor,
                                  width: isSelected || showCorrect ? 1.5 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          isSelected || showCorrect
                                              ? borderColor
                                              : const Color(0xFFEEF2EF),
                                    ),
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        color:
                                            isSelected || showCorrect
                                                ? Colors.white
                                                : const Color(0xFF52635D),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: const TextStyle(
                                        color: Color(0xFF263D35),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (showCorrect)
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF3E8A60),
                                    ),
                                  if (showIncorrect)
                                    const Icon(
                                      Icons.cancel_rounded,
                                      color: Color(0xFFCA654F),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_hasSubmitted)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Text(
                        _selectedAnswerIndex == question.correctAnswerIndex
                            ? 'Correct. Nicely done!'
                            : _selectedAnswerIndex == -1
                            ? 'Time is up. The correct answer is highlighted.'
                            : 'Not quite. The correct answer is highlighted.',
                        style: TextStyle(
                          color:
                              _selectedAnswerIndex ==
                                      question.correctAnswerIndex
                                  ? const Color(0xFF28734C)
                                  : const Color(0xFF9B4937),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed:
                          _hasSubmitted
                              ? _advanceQuestion
                              : _selectedAnswerIndex == -1
                              ? null
                              : _submitAnswer,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF176B5B),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFDCE5E0),
                        disabledForegroundColor: const Color(0xFF819089),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        _hasSubmitted
                            ? _questionIndex == quizQuestions.length - 1
                                ? 'See results'
                                : 'Next question'
                            : 'Check answer',
                        style: const TextStyle(fontWeight: FontWeight.w700),
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
