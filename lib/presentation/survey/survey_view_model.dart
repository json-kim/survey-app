import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:survey_app/domain/model/answer/answer_multi_item.dart';
import 'package:survey_app/domain/model/answer/answer_single_item.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';
import 'package:survey_app/domain/usecase/load_survey_usecase.dart';
import 'package:survey_app/domain/usecase/submit_answer_usecase.dart';
import 'package:survey_app/presentation/survey/survey_event.dart';
import 'package:survey_app/presentation/survey/survey_state.dart';

import 'answer_builder.dart';
import 'survey_ui_event.dart';

class SurveyViewModel with ChangeNotifier {
  final SubmitAnswerUseCase _submitAnswerUseCase;
  final LoadSurveyUseCase _loadSurveyUseCase;

  SurveyState _state;
  SurveyState get state => _state;

  final AnswerBuilder _answerBuilder = AnswerBuilder();

  final _uiStreamController = StreamController<SurveyUiEvent>.broadcast();
  Stream<SurveyUiEvent> get uiStream => _uiStreamController.stream;

  SurveyViewModel(this._submitAnswerUseCase, this._loadSurveyUseCase, {email})
      : _state = SurveyState(
          email: email,
        ) {
    _loadSurvey();
  }

  void onEvent(SurveyEvent event) {
    event.when(
      pageChange: _pageChange,
      loadSurvey: _loadSurvey,
      answerMulti: _answerMulti,
      answerSingle: _answerSingle,
      answerDate: _answerDate,
      answerDone: _submitAnswer,
    );
  }

  void _pageChange(int page) async {
    _state = _state.copyWith(page: page);
    notifyListeners();
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
      } else if (item.category == SurveyCategory.radio) {
        answerData[item.id] = -1;
      } else {
        answerData[item.id] = 0;
      }
    });

    _state = _state.copyWith(answerData: answerData);
  }

  void _answerMulti(int itemId, int index, bool checked) {
    final answerData = _state.answerData;
    (answerData[itemId] as List<bool>)[index] = checked;

    _state = _state.copyWith(answerData: answerData);
    notifyListeners();
  }

  void _answerSingle(int itemId, int answer) {
    final answerData = _state.answerData;
    answerData[itemId] = answer;

    _state = _state.copyWith(answerData: answerData);
    notifyListeners();
  }

  void _answerDate(DateTime date) {
    _state = _state.copyWith(date: date);
    notifyListeners();
  }

  bool _answerValidate(Survey survey, MapEntry<int, dynamic> answerData) {
    final surveyItem =
        survey.itemList.where((item) => item.id == answerData.key).first;

    switch (surveyItem.category) {
      case SurveyCategory.checkbox:
        return (answerData.value as List<bool>).any((e) => e == true);
      case SurveyCategory.radio:
        return (answerData.value as int) != -1;
      default:
        return true;
    }
  }

  void _addAnswerData(Survey survey, MapEntry<int, dynamic> answerData) {
    final surveyItem =
        survey.itemList.where((item) => item.id == answerData.key).first;

    switch (surveyItem.category) {
      case SurveyCategory.checkbox:
        final answerList = (answerData.value as List<bool>)
            .asMap()
            .entries
            .map((e) => e.key + 1)
            .toList();
        final answerItem = AnswerMultiItem(
          id: survey.id.hashCode +
              answerData.key.hashCode +
              DateTime.now().hashCode,
          surveyItemId: answerData.key,
          category: surveyItem.category,
          answerList: answerList,
        );
        _answerBuilder.addAnswerItem(answerItem);
        break;

      case SurveyCategory.radio:
        final answer = answerData.value as int;
        final answerItem = AnswerSingleItem(
          id: survey.id.hashCode +
              answerData.key.hashCode +
              DateTime.now().hashCode,
          surveyItemId: answerData.key,
          category: surveyItem.category,
          answer: answer,
        );
        _answerBuilder.addAnswerItem(answerItem);
        break;

      case SurveyCategory.slider:
        final answer = answerData.value as int;
        final answerItem = AnswerSingleItem(
          id: survey.id.hashCode +
              answerData.key.hashCode +
              DateTime.now().hashCode,
          surveyItemId: answerData.key,
          category: surveyItem.category,
          answer: answer,
        );
        _answerBuilder.addAnswerItem(answerItem);
        break;
    }
  }

  Future<void> _submitAnswer() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final survey = _state.survey;
    if (survey == null) {
      // 설문조사 에러 스낵바
      _uiStreamController.add(const SurveyUiEvent.snackBar('설문조사 에러'));

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      return;
    }
    _answerBuilder.addId(
        DateTime.now().hashCode + survey.id.hashCode + _state.email.hashCode);
    _answerBuilder.addMemberId(_state.email ?? 'unknown');
    _answerBuilder.addSurveyId(survey.id);

    final date = _state.date;
    if (date == null) {
      // 날짜 입력 스낵바 + 페이지 이동
      _uiStreamController.add(const SurveyUiEvent.snackBar('날짜를 입력해주세요'));
      _uiStreamController.add(SurveyUiEvent.movePage(survey.itemList.length));

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      return;
    }
    _answerBuilder.addDate(date);

    final answerData = _state.answerData;
    final answerEntries = answerData.entries.toList();
    for (int i = 0; i < answerEntries.length; i++) {
      final entry = answerEntries[i];
      if (!_answerValidate(survey, entry)) {
        // 스낵바 + 해당 페이지 이동
        _uiStreamController
            .add(const SurveyUiEvent.snackBar('설문조사 항목을 체크해주세요'));

        _uiStreamController.add(SurveyUiEvent.movePage(i));
        _state = _state.copyWith(isLoading: false);
        notifyListeners();

        return;
      }
      _addAnswerData(survey, entry);
    }

    try {
      final answer = _answerBuilder.buildAnswer();

      if (survey.itemList.length == answer.itemList.length) {
        final result = await _submitAnswerUseCase(answer);

        if (result != -1) {
          // 완료 스낵바 + 종료
          _uiStreamController
              .add(const SurveyUiEvent.snackBar('설문조사가 제출되었습니다.'));
          _uiStreamController.add(const SurveyUiEvent.navPop());
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
