import 'dart:convert';

import 'package:survey_app/data/data_source/answer_fake_data_source.dart';
import 'package:survey_app/domain/model/answer/answer.dart';
import 'package:survey_app/domain/repository/answer_repository.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerFakeDataSource _dataSource;

  AnswerRepositoryImpl(this._dataSource);

  @override
  Future<int> postAnswer(Answer answer) async {
    final result = await _dataSource.postAnswer(jsonEncode(answer.toJson()));

    return result;
  }
}
