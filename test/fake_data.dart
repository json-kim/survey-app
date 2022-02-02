import 'package:flutter_test/flutter_test.dart';
import 'package:survey_app/domain/model/answer/answer.dart';
import 'package:survey_app/domain/model/answer/answer_multi_item.dart';
import 'package:survey_app/domain/model/answer/answer_single_item.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';
import 'package:survey_app/domain/model/survey/survey_slider_item.dart';

void main() {
  group('fake 데이터를 테스트합니다.', () {
    test('fake Survey 데이터를 테스트합니다.', () {
      final survey = Survey(id: 1, date: DateTime(2022, 1, 1), itemList: [
        SurveyChoiceItem(
            id: 1,
            question: 'In my free time I like to ...',
            category: SurveyCategory.checkbox,
            choices: [
              'Read',
              'Work out',
              'Draw',
              'Play video games',
              'Dance',
              'Watch movies',
            ]),
        SurveyChoiceItem(
            id: 2,
            question: 'Pick a superhero',
            category: SurveyCategory.radio,
            choices: [
              'Spider man (Avengers)',
              'Irom man (Avengers)',
              'Uni-kitty (Lego Movie)',
              'Captain Planet',
            ]),
        SurveyChoiceItem(
            id: 3,
            question: 'What\'s your favourite movie',
            category: SurveyCategory.radio,
            choices: [
              'Star Trek',
              'The social network',
              'Back to the future',
              'Outbreak',
            ]),
        SurveySliderItem(
            id: 4,
            question: 'How do you feel about selfies?',
            category: SurveyCategory.slider,
            step: 4),
      ]);

      final json = survey.toJson();

      final fromJsonSurvey = Survey.fromJson(json);

      print(json);
    });

    test('fake Answer 데이터를 테스트합니다.', () {
      final answer = Answer(
          id: 1,
          date: DateTime.now(),
          memberId: 'testid',
          surveyId: 1,
          itemList: [
            AnswerMultiItem(
                id: 1,
                surveyItemId: 1,
                category: SurveyCategory.checkbox,
                answerList: [1, 3]),
            AnswerSingleItem(
                id: 2,
                surveyItemId: 2,
                category: SurveyCategory.radio,
                answer: 3),
            AnswerSingleItem(
                id: 3,
                surveyItemId: 3,
                category: SurveyCategory.radio,
                answer: 4),
            AnswerSingleItem(
                id: 4,
                surveyItemId: 4,
                category: SurveyCategory.slider,
                answer: 2),
          ]);

      final answerJson = answer.toJson();

      final fromJsonAnswer = Answer.fromJson(answerJson);

      print(answerJson);
    });
  });
}
