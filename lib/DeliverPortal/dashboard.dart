import 'package:cached_network_image/cached_network_image.dart';
import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:deliverdeck/datamanagement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  //Global var
  var userID = "";
  List userData = [];
  List pendingDeliveries = [];

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs");

  var dataManagementInstance = DataManagement();


  Future updateData() async {
    var prefs = await SharedPreferences.getInstance();

    userID = prefs.getString("StoredUser");

    userData = await dataManagementInstance.getUserData(userID);

    pendingDeliveries = await dataManagementInstance.getActiveDeliveries("Amazon");

    print(pendingDeliveries);


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


  void _showbottomsheet(String packageID) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.redAccent,
                  height: 300,
                  width: MediaQuery.of(context).size.width - 40,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async{
                    await dataManagementInstance.markPackageDelivered(userID, "Amazon", packageID);
                    Navigator.pop(context);
                    updateData().then((_){
                      setState(() {

                      });
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10)),
                    height: 55,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.8,
          );
        });
  }

  void _showerrorbottomsheet(String packageID) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return KeyboardAvoider(
            curve: Curves.fastLinearToSlowEaseIn,
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Unable to Deliver',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 170,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blueAccent[400]),
                            ),
                            labelText: 'Give Context',
                            labelStyle: TextStyle(color: Colors.grey[300]),
                            hintText: 'I am unable to deliver because...',
                            hintStyle: TextStyle(color: Colors.grey[200]),
                            focusColor: Colors.grey[400],
                          ),
                        )),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async{
                      await dataManagementInstance.markPackageProblem(userID, "Amazon", packageID);
                      Navigator.pop(context);

                      updateData().then((_){
                        setState(() {

                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                    ),
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          );
        });
  }

  final List<String> entries = <String>['35', '36', '37'];

  void _showlistbottomsheet() {

    updateData().then((_){
      setState(() {

      });
    });


    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Package List',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height * 0.8 - 300,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: pendingDeliveries.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(pendingDeliveries);
                          if(pendingDeliveries.length != 0){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 50,
                                color: Colors.grey[900],
                                child: Center(
                                    child: Text(
                                      'Package #${pendingDeliveries[index][0]}',
                                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),
                                    )),
                              ),
                            );

                          } else {
                            return Center(
                              child: Text("No Pending Deliveries", style: TextStyle(color: Colors.grey, fontSize: 20),),
                            );
                          }

                        }),
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.8,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap){
        if(pendingDeliveries.length != 0){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Center(
                  child: Text(
                    'Dashboard',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: PageView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            userData[2] + " " + userData[3],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: CircleWaveProgress(
                            size: 300,
                            borderWidth: 10.0,
                            borderColor: Colors.grey[100],
                            waveColor: Colors.grey[900],
                            progress: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  userData[6].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Active Packages',
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  userData[4].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Delivered',
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // Problem
                            GestureDetector(
                              onTap: () {
                                _showerrorbottomsheet(pendingDeliveries[0][0]);
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Icon(
                                  Icons.error_outline,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                            ),
                            // Take Photo Of Package
                            GestureDetector(
                              onTap: () {
                                _showbottomsheet(pendingDeliveries[0][0]);
                              },
                              child: Container(
                                height: 45,
                                width: 95,
                                child: Icon(
                                  Icons.check,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black),
                              ),
                            ),
                            // View All Packages
                            GestureDetector(
                              onTap: () {
                                _showlistbottomsheet();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Icon(
                                  Icons.list,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        Center(
                          child: Text(
                            userData[2] + " " + userData[3],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 60),
                        Center(
                          child: Text(
                            'Active Delivery',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            'Package # ' + pendingDeliveries[0][0],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: MediaQuery.of(context).size.width - 200,
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://zdnet1.cbsistatic.com/hub/i/r/2019/01/16/41a395b2-f69a-4787-84ac-398d181f2aba/resize/1200xauto/69f7371c1b4cad1c5bb4bb6a68175981/paris-duckduckgo.png',
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black, BlendMode.color)),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 60),
                        Center(
                          child: Text(
                            'Delivery Address',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            pendingDeliveries[0][2],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'City',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Mountain House',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        } else {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Center(
                  child: Text(
                    'Dashboard',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body:
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            userData[2] + " " + userData[3],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: CircleWaveProgress(
                            size: 300,
                            borderWidth: 10.0,
                            borderColor: Colors.grey[100],
                            waveColor: Colors.grey[900],
                            progress: 50,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  userData[6].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Active Packages',
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  userData[4].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Delivered',
                                  style: TextStyle(fontSize: 22),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // Problem
                            GestureDetector(
                              onTap: () {
                                _showerrorbottomsheet(pendingDeliveries[0][0]);
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Icon(
                                  Icons.error_outline,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                            ),
                            // Take Photo Of Package
                            GestureDetector(
                              onTap: () {
                                _showbottomsheet(pendingDeliveries[0][0]);
                              },
                              child: Container(
                                height: 45,
                                width: 95,
                                child: Icon(
                                  Icons.check,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black),
                              ),
                            ),
                            // View All Packages
                            GestureDetector(
                              onTap: () {
                                _showlistbottomsheet();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Icon(
                                  Icons.list,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        );
        }
      },
    );
  }
}