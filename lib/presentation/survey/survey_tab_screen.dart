import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/domain/model/survey/survey.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';
import 'package:survey_app/domain/model/survey/survey_item.dart';
import 'package:survey_app/domain/model/survey/survey_slider_item.dart';
import 'package:survey_app/presentation/survey/page/calendar_survey.dart';
import 'package:survey_app/presentation/survey/page/done_survey.dart';
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
  final PageController _controller = PageController(initialPage: 0);
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<SurveyViewModel>();
      _subscription = viewModel.uiStream.listen((event) {
        event.when(
          snackBar: (message) {
            final snackBar = SnackBar(content: Text(message));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          },
          movePage: (page) {
            _controller.jumpToPage(page);
          },
          navPop: () {
            Navigator.of(context).pop();
          },
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    _controller.dispose();
  }

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
        onPageChanged: (page) =>
            viewModel.onEvent(SurveyEvent.pageChange(page)),
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ..._buildSurveyPage(survey, state.answerData),
          CalendarSurvey(
            pickedDate: state.date,
            dateChanged: (date) {
              viewModel.onEvent(SurveyEvent.answerDate(date));
            },
          ),
          const DoneSurvey(),
        ],
      ),
      bottomNavigationBar: state.page == survey.itemList.length + 1
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton(
                onPressed: () {
                  viewModel.onEvent(const SurveyEvent.answerDone());
                },
                child: const Text('Done'),
              ),
            )
          : Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        _controller.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Previous')),
                  Row(
                    children: [
                      ...List.generate(
                        survey.itemList.length + 1,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 15,
                          decoration: BoxDecoration(
                              color: state.page == index
                                  ? Colors.purple
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.purple)),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: const Text('Next')),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildSurveyPage(Survey survey, Map<int, dynamic> answerData) {
    final pages = survey.itemList.map((item) {
      switch (item.category) {
        case SurveyCategory.checkbox:
          return CheckboxSurvey(
            choiceItem: item as SurveyChoiceItem,
            checkedList: answerData[item.id],
            onTap: (value, index) {
              context
                  .read<SurveyViewModel>()
                  .onEvent(SurveyEvent.answerMulti(item.id, index, value));
            },
          );
        case SurveyCategory.radio:
          return RadioSurvey(
            choiceItem: item as SurveyChoiceItem,
            answer: answerData[item.id],
            onTap: (index) {
              context
                  .read<SurveyViewModel>()
                  .onEvent(SurveyEvent.answerSingle(item.id, index));
            },
          );
        case SurveyCategory.slider:
          return SliderSurvey(
            sliderItem: item as SurveySliderItem,
            division: item.step,
            value: answerData[item.id],
            onChanged: (value) {
              context
                  .read<SurveyViewModel>()
                  .onEvent(SurveyEvent.answerSingle(item.id, value));
            },
          );
      }
    }).toList();

    return pages;
  }
}
