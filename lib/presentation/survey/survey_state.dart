import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/presentation/survey/answer_builder.dart';

part 'survey_state.freezed.dart';

@freezed
class SurveyState with _$SurveyState {
  const factory SurveyState({
    String? email,
    Survey? survey,
    @Default({}) answerData,
    @Default(false) isLoading,
  }) = _SurveyState;
}
