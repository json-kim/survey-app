import 'package:survey_app/domain/model/answer/answer.dart';

abstract class AnswerRepository {
  Future<int> postAnswer(Answer answer);
}
