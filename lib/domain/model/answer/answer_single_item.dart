import 'package:survey_app/domain/model/survey/survey_item.dart';

import 'answer_item.dart';

class AnswerSingleItem extends AnswerItem {
  final int answer;

  AnswerSingleItem({
    required int id,
    required int surveyItemId,
    required SurveyCategory category,
    required this.answer,
  }) : super(id: id, surveyItemId: surveyItemId, category: category);

  factory AnswerSingleItem.fromJson(Map<String, dynamic> json) {
    return AnswerSingleItem(
        id: json['id'] as int,
        surveyItemId: json['surveyItemId'] as int,
        category: SurveyCategory.values[json['category'] as int],
        answer: json['answer'] as int);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyItemId': surveyItemId,
      'category': category.index,
      'answer': answer,
    };
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
