import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/create_pge.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: Icon(Icons.add),
        elevation: 0,
      ),
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
                       DateFormat.yMEd().format(DateTime.now()),
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
