import 'survey_item.dart';

class SurveySliderItem extends SurveyItem {
  final int step;

  SurveySliderItem({
    required int id,
    required String question,
    required SurveyCategory category,
    required this.step,
  }) : super(id: id, question: question, category: category);

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
