import 'survey_item.dart';

class SurveyChoiceItem extends SurveyItem {
  final List<String> choices;

  SurveyChoiceItem({
    required int id,
    required String question,
    required SurveyCategory category,
    required this.choices,
  }) : super(id: id, question: question, category: category);

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
