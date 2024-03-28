import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CreatePage extends StatefulWidget {
  Map? itemData;
  CreatePage({super.key, this.itemData});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    final data = widget.itemData;
    if (widget.itemData != null){
      isEdit = true;
      titleCon.text = data!['title'];
      descriptionCon.text = data!['description'];
    }
    super.initState();
  }

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
                    isEdit ? updateData() : postData();
                  }, child: Text(isEdit ? "Modify task" : "Create task"))),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  // update
  Future<void> updateData() async{
    final id = widget.itemData!["_id"];
    final body = {
      "title": titleCon.text,
      "description": descriptionCon.text,
      "is_completed": 'false'
    };
    final url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final response = await http.put(url, body: jsonEncode(body), headers: {'Content-Type' : 'application/json'});
    if (response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('updated '), backgroundColor: Colors.green,));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error '), backgroundColor: Colors.red,));
    }
  }


  // post
  Future<void> postData() async {
    final body = {
      "title": titleCon.text,
      "description": descriptionCon.text,
      "is_completed": 'false'
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.post(
      url,
      headers: { 'Content-Type' : 'application/json'},
      body: jsonEncode(body),);
    if (response.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('created '), backgroundColor: Colors.green,));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error '), backgroundColor: Colors.red,));
    }
  }



}
