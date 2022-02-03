import 'package:survey_app/data/data_source/survey_fake_data_source.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/repository/survey_repository.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyFakeDataSource _dataSource;

  SurveyRepositoryImpl(this._dataSource);

  @override
  Future<Survey> getSurvey(int surveyId) async {
    final jsonResult = await _dataSource.getSurveyData(surveyId);

    final survey = Survey.fromJson(jsonResult);

    return survey;
  }
}
