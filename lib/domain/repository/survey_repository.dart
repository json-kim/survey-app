import 'package:survey_app/domain/model/survey/survey.dart';

abstract class SurveyRepository {
  Future<Survey> getSurvey(int surveyId);
}
