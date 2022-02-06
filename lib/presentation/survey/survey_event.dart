import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_event.freezed.dart';

@freezed
class SurveyEvent with _$SurveyEvent {
  const factory SurveyEvent.pageChange(int page) = PageChange;
  const factory SurveyEvent.loadSurvey() = LoadSurvey;
  const factory SurveyEvent.answerMulti(int itemId, int index, bool checked) =
      AnswerMulti;
  const factory SurveyEvent.answerSingle(int itemId, int answer) = AnswerSingle;
  const factory SurveyEvent.answerDate(DateTime date) = AnswerDate;
  const factory SurveyEvent.answerDone() = AnswerDone;
}
