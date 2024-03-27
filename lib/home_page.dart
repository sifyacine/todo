import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Welcom back!",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            Text(
              "SIF Yacine",
              style: TextStyle(

              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      child: Text(
                        DateTime.now().toString()
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
