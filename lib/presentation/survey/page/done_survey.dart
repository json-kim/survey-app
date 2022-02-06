import 'package:flutter/material.dart';

class DoneSurvey extends StatelessWidget {
  const DoneSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compose',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            'Congratulations, you are Compose',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          const Text(
              'You are a curious developer, always willing to try something new. You want to stay up to date with the trends to Compose is yout middle name'),
        ],
      ),
    );
  }
}
