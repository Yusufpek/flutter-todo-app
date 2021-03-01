import 'package:flutter/material.dart';

import 'components/theme.dart';
import 'ui/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData _todoTheme = buildTodoTheme();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App Demo',
      theme: _todoTheme,
      home: MainScreen(),
    );
  }
}
