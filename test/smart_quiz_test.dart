import 'package:flutter_test/flutter_test.dart';
import 'package:minor_project/data/quiz_questions.dart';
import 'package:minor_project/main.dart';

void main() {
  testWidgets('completes the quiz, shows the score, and can restart',
      (tester) async {
    await tester.pumpWidget(const SmartQuizApp());

    expect(find.text('Smart Quiz'), findsOneWidget);
    await tester.tap(find.text('Start quiz'));
    await tester.pumpAndSettle();

    for (var questionIndex = 0;
        questionIndex < quizQuestions.length;
        questionIndex++) {
      final question = quizQuestions[questionIndex];
      final correctOption = question.options[question.correctAnswerIndex];

      await tester.ensureVisible(find.text(correctOption));
      await tester.tap(find.text(correctOption));
      await tester.pump();
      await tester.tap(find.text('Check answer'));
      await tester.pumpAndSettle();

      final nextButton = questionIndex == quizQuestions.length - 1
          ? 'See results'
          : 'Next question';
      await tester.tap(find.text(nextButton));
      await tester.pumpAndSettle();
    }

    expect(find.text('10 / 10'), findsOneWidget);
    expect(find.text('Correct answers'), findsOneWidget);
    expect(find.text('Incorrect answers'), findsOneWidget);

    await tester.tap(find.text('Restart quiz'));
    await tester.pumpAndSettle();
    expect(find.text('QUESTION 1 OF 10'), findsOneWidget);
  });
}