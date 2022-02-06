import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_app/domain/model/survey/survey.dart';

part 'survey_state.freezed.dart';

@freezed
class SurveyState with _$SurveyState {
  const factory SurveyState({
    @Default(0) page,
    String? email,
    Survey? survey,
    DateTime? date,
    @Default({}) Map<int, dynamic> answerData,
    @Default(false) isLoading,
  }) = _SurveyState;
}
