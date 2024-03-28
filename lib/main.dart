import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/state%20management/provider.dart';

import 'home_page.dart';

void main() {
  runApp(MyTodo());
}

class MyTodo extends StatelessWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Serrvices(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(useMaterial3: true, textTheme: Theme.of(context).textTheme.apply(bodyColor: kWhiteColor)),
      ),
    );
  }
}
