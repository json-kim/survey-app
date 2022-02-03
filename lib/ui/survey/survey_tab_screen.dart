import 'package:flutter/material.dart';
import 'package:survey_app/ui/survey/page/calendar_survey.dart';
import 'package:survey_app/ui/survey/page/checkbox_survey.dart';
import 'package:survey_app/ui/survey/page/done_survey.dart';
import 'package:survey_app/ui/survey/page/radio_survey.dart';

class SurveyTapScreen extends StatefulWidget {
  const SurveyTapScreen({Key? key}) : super(key: key);

  @override
  _SurveyTapScreenState createState() => _SurveyTapScreenState();
}

class _SurveyTapScreenState extends State<SurveyTapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
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
        children: [
          CheckboxSurvey(),
          RadioSurvey(),
          CalendarSurvey(),
          DoneSurvey(),
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
}
