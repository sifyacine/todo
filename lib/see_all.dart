import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/create_pge.dart';
import 'package:http/http.dart' as http;
import 'package:todo/state%20management/provider.dart';
class SeeAll extends StatefulWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  void initState() {
    //fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Serrvices>(context).allList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: Icon(Icons.add),
        elevation: 0,
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            //fetchData();
          }, icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: Text("all tasks"),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
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
      //fetchData();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  delete(String idd)async{
    final url = Uri.parse("https://api.nstack.in/v1/todos/$idd");
    await http.delete(url);
    //fetchData();
  }
}
