import 'answer_item.dart';

class Answer {
  final int id;
  final String date;
  final String memberId;
  List<AnswerItem> itemList;

  Answer({
    required this.id,
    required this.date,
    required this.memberId,
    required this.itemList,
  });
}
