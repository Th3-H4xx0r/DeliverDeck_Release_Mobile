import 'dart:ui';

import 'package:deliverdeck/datamanagement.dart';
import 'package:flutter/material.dart';

class CompanyDashboard extends StatefulWidget {
  @override
  _CompanyDashboardState createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {


  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  var datamanagementInstance = DataManagement();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,

          title: Text(
            'Company Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,
            ),
          ),),
        body: Column(
          children: <Widget>[
            SizedBox(height: 80),
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(360)),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Amazon',

                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28,),
              ),
            ),
            SizedBox(height: 50,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Column(
                    children: <Widget>[
                      Center(child:  Text('0', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                      SizedBox(height: 5,),
                      Center(child:  Text('Total Deliveries', style: TextStyle(color: Colors.grey[400]),),),
                    ],

                  ),

                  Column(
                    children: <Widget>[
                      Center(child:  Text('1', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                      SizedBox(height: 5,),
                      Center(child:  Text('Active Members', style: TextStyle(color: Colors.grey[400]),),),
                    ],

                  ),


                  Column(
                    children: <Widget>[
                      Center(child:  Text('1', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                      SizedBox(height: 5,),
                      Center(child:  Text('Admins', style: TextStyle(color: Colors.grey[400]),),),
                    ],

                  ),


                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 350,
              child: Divider(thickness: 1.2,),
            ),
            SizedBox(height: 30,),
            Center(
              child: Text('Quick Add', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 30,),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey[300]),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent[400]),
                    ),
                    labelText: 'Address',
                    labelStyle:
                    TextStyle(color: Colors.grey[300]),
                    hintText: 'ex. 714 North Riata Dr',
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    focusColor: Colors.grey[400],
                  ),
                )),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey[300]),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent[400]),
                    ),
                    labelText: 'City',
                    labelStyle:
                    TextStyle(color: Colors.grey[300]),
                    hintText: 'ex. San Fransisco',
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    focusColor: Colors.grey[400],
                  ),
                )),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () async{

                print("WORKS");

                await datamanagementInstance.addPackage("Amazon", addressController.text);

                addressController.clear();

                cityController.clear();

                setState(() {

                });


              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:FlatButton(onPressed: null, child: Text(
                    'Add Package',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),)),
            )


          ],
        ));
  }
}