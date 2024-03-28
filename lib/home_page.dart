import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/create_pge.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List myData = [];
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
                       DateFormat.yMMMEd().format(DateTime.now()),
                  ),
                ),
                ),
                IconButton(onPressed: (){
                  fetchData();
                }, icon: Icon(Icons.refresh))
              ],
            ),
            Row(
              children: [
                Text("today's task"),
              ],
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(onTap: (){} ,child: Text("see all")),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, index){
                  Map <String, dynamic> data = myData.reversed.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data['title'],
                                  style: TextStyle(
                                    decoration: data['is_completed'] ? TextDecoration.lineThrough : TextDecoration.none,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text(
                                  data['description'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(DateFormat.yMMMEd().format(DateTime.parse(data['created_at'])).toString()),
                                Spacer(),
                                IconButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(itemData: data,)));
                                      },
                                    icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text("Alert!"),
                                      icon: Icon(Icons.warning),
                                      content: Text(
                                        'are you sure you want to delete this task!!',
                                      ),
                                      actions: [
                                        TextButton(onPressed: (){
                                          delete(data["_id"]);
                                          Navigator.pop(context);
                                        }, child: Text("YES")),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("NO")),
                                      ],
                                    );
                                  }
                                  );
                                  //delete(data['_id']);
                                }, icon: Icon(Icons.delete)),
                                Checkbox(value: data['is_completed'], onChanged: (val){
                                  check(val!, data["_id"], data["title"], data["description"]);
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //get
  Future<void> fetchData() async{
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map <String, dynamic> json = jsonDecode(response.body);
      setState(() {
        myData = json['items'];
      });
    }
  }
  // check
  void check(bool check, String idd, String title, String description) async {
    final url = Uri.parse("https://api.nstack.in/v1/todos/$idd");
    final body = {
      "title": title,
      "description": description,
      "is_completed": check,
    };

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      fetchData();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  delete(String idd)async{
    final url = Uri.parse("https://api.nstack.in/v1/todos/$idd");
    await http.delete(url);
    fetchData();
  }
}
