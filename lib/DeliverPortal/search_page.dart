import 'dart:ui';
import 'package:deliverdeck/datamanagement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  //Global var
  var userID = "";
  List userData = [];

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs");

  var dataManagementInstance = DataManagement();


  Future updateData() async {
    var prefs = await SharedPreferences.getInstance();

    userID = prefs.getString("StoredUser");

    //job = await dataManagementInstance.getJobOffers();
  }


  @override
  void initState() {
    updateData().then((_){
      print("Updated Data");
      setState(() {

      });
    });

    super.initState();
  }

  List job = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Colors.white ,
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                SizedBox(
                  width: 200,
                ),

              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Find Job Requests',
                  style: TextStyle(
                      color:  Colors.black ,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 45,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),

                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextField(
                        style: TextStyle(
                          color:  Colors.black ,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '   Search',
                          hintStyle: TextStyle(
                            color:   Colors.white24,
                          ),
                        ),
                      ),
                    ),
                    Container(width: 10,),
                    Icon(Icons.search),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color:
                    Colors.grey[100],

                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 0,
            ),

            SizedBox(
              height: 20,
            ),

            StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snap){
                if(snap.hasData && snap.data != null){

                  DataSnapshot dataSnapshot = snap.data.snapshot;

                  if(dataSnapshot.value != null){
                    Map<dynamic, dynamic> rawData = dataSnapshot.value;

                    job.clear();

                    rawData.forEach((key, value){
                      job.add([value["Job Description"], value["Job Name"], value["Job Time"], value["Active Deliveries"]]);
                    });

                  }

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                        itemCount: job.length,
                        itemBuilder: (context, int index){
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          'https://media.npr.org/assets/img/2013/11/26/amazon_wide-27f5802cec7710e52f61620c0d6d9373f4cb55e6-s800-c85.jpg',
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          // BoxFit.cover resizes and crops the image so that it fits nicely into the container
                                        ),
                                        // Image.network creates an image widget that reaches out to the network to fetch the image
                                      ),
                                      //ClipRRect takes a child and forces that child into a certain form - ex. child is an image that is forced to have rounded corner          ],
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(

                                      // empty space in the row is split up evenly
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.timer, size: 25,),
                                            SizedBox(width: 6),
                                            Text(
                                              job[index][2].toString(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20,),

                                        Row(
                                          children: <Widget>[
                                            Icon(LineIcons.cube, size: 25,),
                                            SizedBox(width: 6),
                                            Text((job[index][3]).length.toString()),
                                          ],
                                        ),
                                        Expanded(child: Container(),),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child:
                                          Text(job[index][1].toString(), style: TextStyle(fontWeight: FontWeight.bold),),

                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Text("No Job Offers", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),)
                  );
                }
              },
            ),



            SizedBox(
              height: 40,
            ),

          ],
        ));
  }
}