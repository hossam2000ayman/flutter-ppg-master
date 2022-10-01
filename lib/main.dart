// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_ui/screen/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'LOGIN UI',
      debugShowCheckedModeBanner: false,
      // theme: theme.copyWith(),
      theme: ThemeData(
          canvasColor: Color(0xFF028090),
          fontFamily: 'Georgia',
          brightness: Brightness.light,
          primaryColor: Color(0xFF028090),
          colorScheme: ColorScheme.light(
            primary: Color(0xFF028090),
          )),
      home: LoginScreen(),
    );
  }
}
