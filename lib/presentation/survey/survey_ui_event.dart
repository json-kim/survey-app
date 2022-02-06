import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_ui_event.freezed.dart';

@freezed
class SurveyUiEvent with _$SurveyUiEvent {
  const factory SurveyUiEvent.snackBar(String message) = SnackBar;
  const factory SurveyUiEvent.movePage(int page) = MovePage;
  const factory SurveyUiEvent.navPop() = NavPop;
}
