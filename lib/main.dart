import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MyTodo());
}

class MyTodo extends StatelessWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
