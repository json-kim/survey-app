import 'package:equatable/equatable.dart';

import 'survey_item.dart';

class Survey implements Equatable {
  final int id;
  final DateTime date;
  final List<SurveyItem> itemList;

  Survey({
    required this.id,
    required this.date,
    required this.itemList,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    final List<SurveyItem> itemList =
        (json['itemList'] as List).map((e) => SurveyItem.fromJson(e)).toList();
    return Survey(
        id: json['id'], date: DateTime.parse(json['date']), itemList: itemList);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'itemList': itemList.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return 'Survey {id : $id, date : $date, itemList : $itemList}';
  }
}
