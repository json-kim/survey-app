import 'package:equatable/equatable.dart';

import 'answer_item.dart';

class Answer implements Equatable {
  final int id;
  final DateTime date;
  final String memberId;
  final int surveyId;
  List<AnswerItem> itemList;

  Answer({
    required this.id,
    required this.date,
    required this.memberId,
    required this.surveyId,
    required this.itemList,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    final List<AnswerItem> itemList = (json['itemList'] as List)
        .map((json) => AnswerItem.fromJson(json))
        .toList();
    return Answer(
      id: json['id'] as int,
      date: DateTime.parse(json['date']),
      memberId: json['memberId'] as String,
      surveyId: json['surveyId'] as int,
      itemList: itemList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'memberId': memberId,
      'surveyId': surveyId,
      'itemList': itemList.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Answer {id : $id, surveyId : $surveyId, date : $date, itemList : $itemList}';
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
