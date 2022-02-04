import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/core/di/provider_setting.dart';
import 'package:survey_app/presentation/login/login_view_model.dart';

import 'presentation/login/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Provider(
          create: (context) => LoginViewModel(), child: const LoginScreen()),
    );
  }
}
