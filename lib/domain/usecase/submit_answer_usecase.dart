import 'package:survey_app/domain/model/answer/answer.dart';
import 'package:survey_app/domain/repository/answer_repository.dart';

import 'usecase.dart';

class SubmitAnswerUseCase implements UseCase<int, Answer> {
  final AnswerRepository _repository;

  SubmitAnswerUseCase(this._repository);

  @override
  Future<int> call(Answer answer) async {
    final result = await _repository.postAnswer(answer);

    return result;
  }
}
