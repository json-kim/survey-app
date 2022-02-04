import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/domain/usecase/load_survey_usecase.dart';
import 'package:survey_app/domain/usecase/submit_answer_usecase.dart';
import 'package:survey_app/presentation/login/login_event.dart';
import 'package:survey_app/presentation/login/login_view_model.dart';
import 'package:survey_app/presentation/survey/survey_tab_screen.dart';
import 'package:survey_app/presentation/survey/survey_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<LoginViewModel>();

      _subscription = viewModel.eventStream.listen((event) {
        event.when(start: (email) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => SurveyViewModel(
                        context.read<SubmitAnswerUseCase>(),
                        context.read<LoadSurveyUseCase>(),
                      ),
                  child: const SurveyTapScreen())));
        }, showSnackBar: (message) {
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/image/survey.png'),
                const Text('Jetsurvey'),
                const Text('Better surveys with Jetpack Compose'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Sign in or create an account'),
                  TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Email', border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        final email = _textEditingController.text;
                        viewModel.onEvent(LoginEvent.startSurvey(email: email));
                      },
                      child: const Text('Continue')),
                  const Text('or'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      viewModel.onEvent(const LoginEvent.startSurvey());
                    },
                    child: const Text('Sign in as guest'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
