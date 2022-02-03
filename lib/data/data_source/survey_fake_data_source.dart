import 'dart:convert';

class SurveyFakeDataSource {
  Future<Map<String, dynamic>> getSurveyData(int surveyId) async {
    return jsonDecode(fakeSurveyData);
  }
}

const String fakeSurveyData = '''
{"id": 1, "date": "2022-01-01T00:00:00.000", "itemList": [{"id": 1, "question": "In my free time I like to ...", "category": 0, "choices": ["Read", "Work out", "Draw", "Play video games", "Dance", "Watch movies"]}, {"id": 2, "question": "Pick a superhero", "category": 1, "choices": ["Spider man (Avengers)", "Irom man (Avengers)", "Uni-kitty (Lego Movie)", "Captain Planet"]}, {"id": 3, "question": "What's your favourite movie", "category": 1, "choices": ["Star Trek", "The social network", "Back to the future", "Outbreak"]}, {"id": 4, "question": "How do you feel about selfies?", "category": 2, "step": 4}]}
''';
