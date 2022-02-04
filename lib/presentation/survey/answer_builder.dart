import 'package:survey_app/domain/model/answer/answer.dart';
import 'package:survey_app/domain/model/answer/answer_item.dart';

class AnswerBuilder {
  int? _id;
  DateTime? _date;
  String? _memberId;
  int? _surveyId;
  final List<AnswerItem> _itemList = [];

  AnswerBuilder();

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

  void addAnswerItem(AnswerItem item) {
    _itemList.add(item);
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
