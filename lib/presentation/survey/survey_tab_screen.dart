import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/domain/model/answer/answer_multi_item.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';
import 'package:survey_app/presentation/survey/answer_builder.dart';
import 'package:survey_app/presentation/survey/survey_event.dart';

import 'page/checkbox_survey.dart';
import 'page/radio_survey.dart';
import 'page/slider_survey.dart';
import 'survey_view_model.dart';

class SurveyTapScreen extends StatefulWidget {
  const SurveyTapScreen({Key? key}) : super(key: key);

  @override
  _SurveyTapScreenState createState() => _SurveyTapScreenState();
}

class _SurveyTapScreenState extends State<SurveyTapScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();
    final state = viewModel.state;

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final survey = state.survey;

    if (survey == null) {
      return Center(
        child: IconButton(
          onPressed: () {
            viewModel.onEvent(const SurveyEvent.loadSurvey());
          },
          icon: const Icon(Icons.refresh),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Which Jetpack library are you?',
          maxLines: 2,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ..._buildSurveyPage(survey, state.answerBuilder)
          // TODO: 각 페이지에 콜백 함수 등록
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () {}, child: Text('Previous')),
            Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.purple)),
                  ),
                )
              ],
            ),
            TextButton(onPressed: () {}, child: Text('Next')),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSurveyPage(Survey survey, AnswerBuilder builder) {
    final pages = survey.itemList.map((item) {
      switch (item.category) {
        case SurveyCategory.checkbox:
          return CheckboxSurvey(
            choiceItem: item as SurveyChoiceItem,
            answerItem: builder.getAnswerItem(item.id) as AnswerMultiItem?,
            onTap: (int value) {
              builder.answerToItem(survey.id, value);
            },
          );
        case SurveyCategory.radio:
          return RadioSurvey();
        case SurveyCategory.slider:
          return SliderSurvey();
      }
    }).toList();

    return pages;
  }
}
