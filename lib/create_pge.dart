import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
              ),
              TextField(
                controller: titleCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Task Title",
              ),
              TextField(
                controller: descriptionCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){
                    postData();
                  }, child: Text("creat task"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  // post
  Future<void> postData() async {
    final body = {
      "title": titleCon.text,
      "description": descriptionCon.text,
      "is_completed": 'false'
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.post(url, headers: { 'content type' :  'Content-Type: application/json'}, body: jsonEncode(body),);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');



    /*var url = Uri.https('api.nstack.in', '/v1/todos');
    var response = await http.post(url, body: {
      "title": "string",
      "description": "string",
      "is_completed": 'false'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

     */
  }





}
