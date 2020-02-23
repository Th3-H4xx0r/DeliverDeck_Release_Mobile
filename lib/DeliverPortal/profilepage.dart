import 'package:deliverdeck/DeliverPortal/settingsscreen.dart';
import 'package:deliverdeck/datamanagement.dart';
import 'package:deliverdeck/loginpage.dart';
import 'package:deliverdeck/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //Global var
  var userID = "";
  List userData = [];

  var dataManagementInstance = DataManagement();


  Future updateData() async {
    var prefs = await SharedPreferences.getInstance();

    userID = prefs.getString("StoredUser");

    userData = await dataManagementInstance.getUserData(userID);
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap){
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,

              title: Text(
                'Member Profile',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,
                ),
              ),),
            body: ListView(
              physics: BouncingScrollPhysics(),
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
                    userData[2].toString() + " " + userData[3].toString(),
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
                          Center(child:  Text(userData[4].toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                          SizedBox(height: 5,),
                          Center(child:  Text('Total Deliveries', style: TextStyle(color: Colors.grey[400]),),),
                        ],

                      ),

                      Column(
                        children: <Widget>[
                          Center(child:  Text(userData[5].toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                          SizedBox(height: 5,),
                          Center(child:  Text('User Rating', style: TextStyle(color: Colors.grey[400]),),),
                        ],

                      ),


                      Column(
                        children: <Widget>[
                          Center(child:  Text(userData[6].toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),),
                          SizedBox(height: 5,),
                          Center(child:  Text('Deliveries Attempted', style: TextStyle(color: Colors.grey[400]),),),
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
                  child: Text('Quick Actions', style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 30,),

                Container(
                  width: 370,
                  height: 40,
                  child: Center(
                    child: Text('Active Deleveries', style: TextStyle(color: Colors.grey[400])),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 370,
                  height: 40,
                  child: Center(
                    child: Text('Account Status', style: TextStyle(color: Colors.grey[400])),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 370,
                  height: 40,
                  child: Center(
                    child: Text('Account Settings', style: TextStyle(color: Colors.grey[400])),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 370,
                  height: 40,
                  child: Center(
                    child: Text('Support', style: TextStyle(color: Colors.grey[400])),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),

                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async{
                    var prefs = await SharedPreferences.getInstance();

                    prefs.setString("StoredUser", "");

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSignupPage()));
                  },
                  child: Container(
                    width: 370,
                    height: 40,
                    child: Center(
                      child: Text('Log Out', style: TextStyle(color: Colors.red)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(40)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ));
      },
    );
  }
}