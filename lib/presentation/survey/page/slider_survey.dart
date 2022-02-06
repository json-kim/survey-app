import 'package:flutter/material.dart';
import 'package:survey_app/domain/model/survey/survey_slider_item.dart';

class SliderSurvey extends StatelessWidget {
  final SurveySliderItem sliderItem;
  final int division;
  final int value;
  final void Function(int) onChanged;

  const SliderSurvey(
      {required this.sliderItem,
      required this.division,
      required this.value,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sliderItem.question,
            style: Theme.of(context).textTheme.headline5,
          ),
          Slider(
            min: 0,
            max: division / 1,
            divisions: division,
            value: value / 1,
            onChanged: (val) {
              print(val);
              onChanged(val.toInt());
            },
          )
        ],
      ),
    );
  }
}
