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

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
