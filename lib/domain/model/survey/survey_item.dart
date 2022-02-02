import 'package:equatable/equatable.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_slider_item.dart';

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

  factory SurveyItem.fromJson(Map<String, dynamic> json) {
    SurveyCategory jsonCategory =
        SurveyCategory.values[json['category'] as int];

    switch (jsonCategory) {
      case SurveyCategory.checkbox:
      case SurveyCategory.radio:
        return SurveyChoiceItem.fromJson(json);
      case SurveyCategory.slider:
        return SurveySliderItem.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SurveyItem {id : $id, question : $question, category : $category}';
  }
}
