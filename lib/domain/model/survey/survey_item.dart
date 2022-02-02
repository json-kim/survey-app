import 'package:equatable/equatable.dart';

enum SurveyCategory {
  checkbox,
  radio,
  slider,
}

abstract class SurveyItem implements Equatable {
  final int id;
  final String question;
  final SurveyCategory category;

  const SurveyItem({
    required this.id,
    required this.question,
    required this.category,
  });
}
