import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/state%20management/provider.dart';


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
      titleCon.text = data?['title'];
      descriptionCon.text = data?['description'];
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final prov = Provider.of<Serrvices>(context, listen: false);
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(
                    fontSize: 16.0
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: descriptionCon,
                decoration: InputDecoration(
                  hintText: "Type title here ...",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreenColor),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: kBlackColor,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Task Description",
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                maxLines: 5,
                controller: descriptionCon,
                decoration: InputDecoration(
                  hintText: "Type description here ...",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreenColor),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: kBlackColor,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kOrangeColor,
                      ),
                      onPressed: (){
                    isEdit ? prov.updateData(widget.itemData!["_id"], titleCon.text, descriptionCon.text, context) : prov.postData(title: titleCon.text, description: descriptionCon.text, context: context);
                  }, child: Text(isEdit ? "Modify task" : "Create task", style: TextStyle(color: kWhiteColor),))),
                ],
              ),

            ],
          ),
        ),
    );
  }
}
