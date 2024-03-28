import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Serrvices with ChangeNotifier{
  List myData = [];
  List allList = [];


  //get
  Future<void> fetchDataProvider() async{
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map <String, dynamic> json = jsonDecode(response.body);
      myData = json['items'];
      final filteredList = myData.where((element) => (
          DateFormat.yMMMEd()
              .format(DateTime.parse(element['created_at'])) ==
              DateFormat.yMMMEd().format(DateTime.now()))).toList();
      allList = json['items'];
      myData = filteredList;
      notifyListeners();
    }
  }
  // update
  Future<void> updateData(String idd, String title, String description, BuildContext context) async{
    final id = idd;
    final body = {
      "title": title,
      "description": description,
      "is_completed": 'false'
    };
    final url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    final response = await http.put(url, body: jsonEncode(body), headers: {'Content-Type' : 'application/json'});
    if (response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('updated '), backgroundColor: Colors.green,));
      fetchDataProvider();
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error '), backgroundColor: Colors.red,));
    }
  }

  // post
  Future<void> postData({required String title, required String description, required BuildContext context}) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": 'false'
    };
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.post(
      url,
      headers: { 'Content-Type' : 'application/json'},
      body: jsonEncode(body),);
    if (response.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('created '), backgroundColor: Colors.green,));
      fetchDataProvider();
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error '), backgroundColor: Colors.red,));
    }

  }

  // check
  void check({required bool check,required String idd,required String title, required String description}) async {
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
      fetchDataProvider();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  delete({required String idd})async{
    final url = Uri.parse("https://api.nstack.in/v1/todos/$idd");
    await http.delete(url);
    fetchDataProvider();
  }

}