import 'package:flutter/material.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';

class CheckboxSurvey extends StatelessWidget {
  final SurveyChoiceItem choiceItem;
  final List<bool> checkedList;
  final void Function(bool, int) onTap;

  const CheckboxSurvey(
      {required this.choiceItem,
      required this.checkedList,
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
                itemBuilder: (context, index) => CheckboxListTile(
                  onChanged: (value) =>
                      onTap(value ?? checkedList[index], index),
                  title: Text(choiceItem.choices[index]),
                  value: checkedList[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
