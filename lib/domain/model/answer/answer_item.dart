import 'package:equatable/equatable.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';

import 'answer_multi_item.dart';
import 'answer_single_item.dart';

abstract class AnswerItem implements Equatable {
  final int id;
  final int surveyItemId;
  final SurveyCategory category;

  AnswerItem({
    required this.id,
    required this.surveyItemId,
    required this.category,
  });

  factory AnswerItem.fromJson(Map<String, dynamic> json) {
    final SurveyCategory jsonCategory =
        SurveyCategory.values[json['category'] as int];

    switch (jsonCategory) {
      case SurveyCategory.radio:
      case SurveyCategory.slider:
        return AnswerSingleItem.fromJson(json);
      case SurveyCategory.checkbox:
        return AnswerMultiItem.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'AnswerItem {id : $id, surveyItemId : $surveyItemId, category : $category';
  }
}
