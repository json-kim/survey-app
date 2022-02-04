import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:survey_app/data/data_source/answer_fake_data_source.dart';
import 'package:survey_app/data/data_source/survey_fake_data_source.dart';
import 'package:survey_app/data/repository/answer_repository_impl.dart';
import 'package:survey_app/data/repository/survey_repository_impl.dart';
import 'package:survey_app/domain/repository/answer_repository.dart';
import 'package:survey_app/domain/repository/survey_repository.dart';
import 'package:survey_app/domain/usecase/load_survey_usecase.dart';
import 'package:survey_app/domain/usecase/submit_answer_usecase.dart';

List<SingleChildWidget> globalProviders = [
  ...independentProviders,
  ...dependentProviders,
  ...changeNotifierProviders,
];

List<SingleChildWidget> independentProviders = [
  Provider<SurveyFakeDataSource>(
    create: (_) => SurveyFakeDataSource(),
  ),
  Provider<AnswerFakeDataSource>(
    create: (_) => AnswerFakeDataSource(),
  )
];

List<SingleChildWidget> dependentProviders = [
  // repository
  ProxyProvider<SurveyFakeDataSource, SurveyRepository>(
    update: (context, datasource, _) => SurveyRepositoryImpl(datasource),
  ),
  ProxyProvider<AnswerFakeDataSource, AnswerRepository>(
    update: (context, datasource, _) => AnswerRepositoryImpl(datasource),
  ),

  // usecase
  ProxyProvider<SurveyRepository, LoadSurveyUseCase>(
    update: (context, repository, _) => LoadSurveyUseCase(repository),
  ),
  ProxyProvider<AnswerRepository, SubmitAnswerUseCase>(
    update: (context, repository, _) => SubmitAnswerUseCase(repository),
  ),
];

List<SingleChildWidget> changeNotifierProviders = [];
