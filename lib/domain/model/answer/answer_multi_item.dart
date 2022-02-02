import 'package:survey_app/domain/model/survey/survey_item.dart';

import 'answer_item.dart';

class AnswerMultiItem extends AnswerItem {
  final List<int> answerList;

  AnswerMultiItem({
    required int id,
    required int surveyItemId,
    required SurveyCategory category,
    required this.answerList,
  }) : super(id: id, surveyItemId: surveyItemId, category: category);

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
