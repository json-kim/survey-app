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

  factory AnswerMultiItem.fromJson(Map<String, dynamic> json) {
    return AnswerMultiItem(
        id: json['id'] as int,
        surveyItemId: json['surveyItemId'] as int,
        category: SurveyCategory.values[json['category'] as int],
        answerList: json['answerList'] as List<int>);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyItemId': surveyItemId,
      'category': category.index,
      'answerList': answerList,
    };
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
