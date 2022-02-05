import 'package:flutter/cupertino.dart';
import 'package:survey_app/domain/model/answer/answer_multi_item.dart';
import 'package:survey_app/domain/model/answer/answer_single_item.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';
import 'package:survey_app/domain/usecase/load_survey_usecase.dart';
import 'package:survey_app/domain/usecase/submit_answer_usecaseart';
import 'package:survey_app/presentation/survey/survey_state.dart';

class SurveyViewModel with ChangeNotifier {
  final SubmitAnswerUseCase _submitAnswerUseCase;
  final LoadSurveyUseCase _loadSurveyUseCase;

  SurveyState _state;
  SurveyState get state => _state;

  SurveyViewModel(this._submitAnswerUseCase, this._loadSurveyUseCase, {email})
      : _state = SurveyState(
          email: email,
        ) {
    _loadSurvey();
  }

  void onEvent(SurveyEvent event) {
    event.when(
      loadSurvey: _loadSurvey,
      answerMulti: _answerMulti,
      answerSingle: _answerSingle,
      answerDate: _answerDate,
      answerDone: _submitAnswer,
    );
  }

  Future<void> _loadSurvey() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    // main surveyId = 1
    final survey = await _loadSurveyUseCase(1);
    setAnswerData(survey);

    _state = _state.copyWith(survey: survey, isLoading: false);
    notifyListeners();
  }

  void setAnswerData(Survey survey) {
    final Map<int, dynamic> answerData = {};
    survey.itemList.forEach((item) {
      if (item.category == SurveyCategory.checkbox) {
        answerData[item.id] = List.generate(
            (item as SurveyChoiceItem).choices.length, (_) => false);
      } else {
        answerData[item.id] = 0;
      }
    });

    _state = _state.copyWith(answerData: answerData);
  }

  void _answerMulti(int itemId, SurveyCategory category, List<int> answers) {
    final item = AnswerMultiItem(
      id: DateTime.now().hashCode + _state.email.hashCode + itemId.hashCode,
      surveyItemId: itemId,
      category: category,
      answerList: answers,
    );

    _state.answerBuilder.addAnswerItem(item);
  }

  void _answerSingle(int itemId, SurveyCategory category, int answer) {
    final item = AnswerSingleItem(
      id: DateTime.now().hashCode + _state.email.hashCode + itemId.hashCode,
      surveyItemId: itemId,
      category: category,
      answer: answer,
    );

    _state.answerBuilder.addAnswerItem(item);
  }

  void _answerDate(DateTime date) {
    _state.answerBuilder.addDate(date);
  }

  Future<void> _submitAnswer() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final survey = _state.survey;
    if (survey == null) {
      return;
    }
    _state.answerBuilder.addId(
        DateTime.now().hashCode + survey.id.hashCode + _state.email.hashCode);
    _state.answerBuilder.addMemberId(_state.email ?? 'unknown');
    _state.answerBuilder.addSurveyId(survey.id);

    try {
      final answer = _state.answerBuilder.buildAnswer();

      if (survey.itemList.length == answer.itemList.length) {
        final result = await _submitAnswerUseCase(answer);

        if (result != -1) {
          // 응답 제출 성공
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
