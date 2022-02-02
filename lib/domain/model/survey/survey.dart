import 'survey_item.dart';

class Survey {
  final int id;
  final String date;
  final List<SurveyItem> itemList;

  Survey({
    required this.id,
    required this.date,
    required this.itemList,
  });
}
