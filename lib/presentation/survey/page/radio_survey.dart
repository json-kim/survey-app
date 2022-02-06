import 'package:flutter/material.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';

class RadioSurvey extends StatelessWidget {
  final SurveyChoiceItem choiceItem;
  final int answer;
  final void Function(int) onTap;

  const RadioSurvey(
      {required this.choiceItem,
      required this.answer,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              choiceItem.question,
              style: Theme.of(context).textTheme.headline5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: choiceItem.choices.length,
                itemBuilder: (context, index) => RadioListTile<int>(
                  groupValue: answer,
                  value: index,
                  onChanged: (value) => onTap(value ?? answer),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(choiceItem.choices[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
