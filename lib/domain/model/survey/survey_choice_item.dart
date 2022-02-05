import 'survey_item.dart';

class SurveyChoiceItem extends SurveyItem {
  final List<String> choices;

  SurveyChoiceItem({
    required int id,
    required String question,
    required SurveyCategory category,
    required this.choices,
  }) : super(id: id, question: question, category: category);

  factory SurveyChoiceItem.fromJson(Map<String, dynamic> json) {
    final choices = (json['choices'] as List).map((e) => e.toString()).toList();
    return SurveyChoiceItem(
      id: json['id'] as int,
      question: json['question'] as String,
      category: SurveyCategory.values[json['category'] as int],
      choices: choices,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'category': category.index,
      'choices': choices,
    };
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
