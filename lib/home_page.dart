import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/create_pge.dart';
import 'package:todo/see_all.dart';
import 'package:todo/state%20management/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<Serrvices>(context, listen: false).fetchDataProvider();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Serrvices>(context, listen: false);
    List myData = Provider.of<Serrvices>(context).myData;
    return Scaffold(
      backgroundColor: kBlackColor,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _key.currentState?.showBottomSheet((context) => CreatePage());
        },
        child: Icon(Icons.add , color: kWhiteColor,),
        elevation: 0,
        backgroundColor: kOrangeColor,
      ),
      appBar: AppBar(
        surfaceTintColor: kBlackColor,
        foregroundColor: kWhiteColor,
        backgroundColor: kBlackColor,
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
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: kOrangeColor,
                      ),
                      child: Text(
                       DateFormat.yMMMEd().format(DateTime.now()),
                        style: TextStyle(
                          color: kWhiteColor,
                        ),
                  ),
                ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: kBlack2Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      padding: EdgeInsets.all(12.0)
                    ),
                    onPressed: (){
                  //fetchData();
                }, icon: Icon(Icons.refresh, color: kWhiteColor,))
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Text("today's task"),
              ],
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll()));
                } ,child: Text("see all")),
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
                        color: kBlack2Color,
                        borderRadius: BorderRadius.circular(12.0),
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
                            SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text(
                                  data['description'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kGreyColor,
                                  ),
                                ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(DateFormat.yMMMEd().format(DateTime.parse(data['created_at'])).toString(),
                                style: TextStyle(
                                  color: kGreyColor,
                                ),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(itemData: data,)));
                                      },
                                    icon: Icon(Icons.edit ,color: kGreenColor,)),
                                IconButton(onPressed: (){
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: kBlack2Color,
                                      title: Align(alignment:  Alignment.topCenter,child: Text("Alert!", style: TextStyle(color: kGreyColor))),
                                      icon: Icon(Icons.warning, color: kRedColor, size: 40,),
                                      content: Text(
                                        'are you sure you want to delete !!',
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: kRedColor,
                                          ),
                                            onPressed: (){
                                          prov.delete(idd: data["_id"]);
                                          Navigator.pop(context);
                                        }, child: Text("YES", style: TextStyle(color: kWhiteColor,),)),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: kBlackColor,
                                            ),
                                            onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("NO",  style: TextStyle(color: kWhiteColor,),)),
                                      ],
                                    );
                                  }
                                  );
                                }, icon: Icon(Icons.delete , color: kRedColor,)),
                                Checkbox(
                                    shape: CircleBorder(side: BorderSide(
                                      color: kWhiteColor,
                                    )),
                                    activeColor: kOrangeColor,
                                    side: BorderSide(
                                      color: kWhiteColor,
                                    ),
                                    value: data['is_completed'], onChanged: (val){
                                  prov.check(check : val!, idd : data["_id"], title : data["title"], description : data["description"]);
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

}
