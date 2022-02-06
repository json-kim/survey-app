import 'package:flutter/material.dart';

class CalendarSurvey extends StatelessWidget {
  final DateTime? pickedDate;
  final void Function(DateTime) dateChanged;

  const CalendarSurvey({this.pickedDate, required this.dateChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'When was the last time you ordered takeaway because you couldn\'t be bothered to cook?',
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(30)),
              onPressed: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2022, 12, 31));

                if (date != null) {
                  dateChanged(date);
                }
              },
              child: const Text(
                'Pick a date',
              ),
            ),
          ),
          if (pickedDate != null)
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    '${pickedDate!.month} ${pickedDate!.day}, ${pickedDate!.year}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
