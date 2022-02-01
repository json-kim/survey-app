import 'package:flutter/material.dart';

class RadioSurvey extends StatelessWidget {
  const RadioSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Pick a superhero'),
          Column(
            children: [
              ...List.generate(
                5,
                (index) => RadioListTile<int>(
                  groupValue: 1,
                  value: index,
                  onChanged: (value) {},
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Read'),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
