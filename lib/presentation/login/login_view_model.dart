import 'dart:async';

import 'package:survey_app/presentation/login/login_event.dart';
import 'package:survey_app/presentation/login/login_ui_event.dart';

class LoginViewModel {
  final _eventController = StreamController<LoginUiEvent>.broadcast();
  Stream<LoginUiEvent> get eventStream => _eventController.stream;

  void onEvent(LoginEvent event) {
    event.when(
        startSurvey: (email) => email == null
            ? _startSurveyAsGuest()
            : _startSurveyWithEmail(email));
  }

  void _startSurveyWithEmail(String email) {
    if (!_checkEmail(email)) {
      // 이메일 유효성 검사 실패
      _eventController.add(const LoginUiEvent.showSnackBar('이메일이 잘못되었습니다.'));
      return;
    }

    // 설문조사 시작
    _eventController.add(LoginUiEvent.start(email: email));
  }

  bool _checkEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  void _startSurveyAsGuest() {
    // 설문조사 시작
    _eventController.add(const LoginUiEvent.start());
  }
}
