import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';

part 'survey_event.freezed.dart';

@freezed
class SurveyEvent with _$SurveyEvent {
  const factory SurveyEvent.answerMulti(
      int itemId, SurveyCategory category, List<int> answers) = AnswerMulti;
  const factory SurveyEvent.answerSingle(
      int itemId, SurveyCategory category, int answer) = AnswerSingle;
  const factory SurveyEvent.answerDate(DateTime date) = AnswerDate;
  const factory SurveyEvent.answerDone() = AnswerDone;
}
