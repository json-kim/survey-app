import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/repository/survey_repository.dart';
import 'package:survey_app/domain/usecase/usecase.dart';

class LoadSurveyUseCase implements UseCase<Survey, int> {
  final SurveyRepository _repository;

  LoadSurveyUseCase(this._repository);

  @override
  Future<Survey> call(int surveyId) async {
    final result = _repository.getSurvey(surveyId);

    return result;
  }
}
