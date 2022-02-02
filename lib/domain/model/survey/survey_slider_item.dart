import 'survey_item.dart';

class SurveySliderItem extends SurveyItem {
  final int step;

  SurveySliderItem({
    required int id,
    required String question,
    required SurveyCategory category,
    required this.step,
  }) : super(id: id, question: question, category: category);

  factory SurveySliderItem.fromJson(Map<String, dynamic> json) {
    return SurveySliderItem(
      id: json['id'] as int,
      question: json['question'] as String,
      category: SurveyCategory.values[json['category'] as int],
      step: json['step'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'category': category.index,
      'step': step,
    };
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
