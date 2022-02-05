import 'package:survey_app/domain/model/answer/answer.dart';
import 'package:survey_app/domain/model/answer/answer_item.dart';

class AnswerBuilder {
  int? _id;
  DateTime? _date;
  String? _memberId;
  int? _surveyId;
  final List<AnswerItem> _itemList = [];

  AnswerBuilder();

  AnswerItem? getAnswerItem(int surveyItemId) {
    final answerItem =
        _itemList.where((item) => item.surveyItemId == surveyItemId);
    if (answerItem.isEmpty) return null;
    return answerItem.first;
  }

  void addId(int id) {
    _id = id;
  }

  void addDate(DateTime date) {
    _date = date;
  }

  void addMemberId(String memberId) {
    _memberId = memberId;
  }

  void addSurveyId(int surveyId) {
    _surveyId = surveyId;
  }

  void addAnswerItem(AnswerItem addedItem) {
    _itemList
        .removeWhere((item) => item.surveyItemId == addedItem.surveyItemId);
    _itemList.add(addedItem);
  }

  void answerToMultiItem(int surveyItemId, int answer) {
    final answerItem =
        _itemList.where((item) => item.surveyItemId == surveyItemId);
    if (answerItem.isEmpty) {
    } else {}
  }

  Answer buildAnswer() {
    if (_id == null ||
        _date == null ||
        _memberId == null ||
        _surveyId == null) {
      throw Exception('input value is null');
    }

    return Answer(
      id: _id!,
      date: _date!,
      memberId: _memberId!,
      surveyId: _surveyId!,
      itemList: _itemList,
    );
  }
}
