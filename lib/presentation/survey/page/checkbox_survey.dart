import 'package:flutter/material.dart';
import 'package:survey_app/domain/model/answer/answer_multi_item.dart';
import 'package:survey_app/domain/model/survey/survey_choice_item.dart';

class CheckboxSurvey extends StatelessWidget {
  final SurveyChoiceItem choiceItem;
  final AnswerMultiItem? answerItem;
  final void Function() onTap;

  const CheckboxSurvey(
      {required this.choiceItem,
      this.answerItem,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              choiceItem.question,
              style: Theme.of(context).textTheme.headline5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: choiceItem.choices.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    choiceItem.id;
                    index;
                    choiceItem.category;
                    answerItem?.answerList.contains(index) ?? false;
                  },
                  title: Text(choiceItem.choices[index]),
                  leading: Icon(
                    answerItem?.answerList.contains(index) ?? false
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
