import 'package:deliverdeck/datamanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget{
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {

  static const routeName = 'settings-screen';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        title: Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue,
                    child: Text(
                      'HP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    userData[2] + " " + userData[3],
                  ),
                  subtitle: Text('Your settings'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Colors.grey.shade600,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Setting(Icon(Icons.save,color: Colors.white),'Save Credentials', Colors.orange,false),
            Setting(Icon(Icons.gps_fixed,color: Colors.white),'Turn on discovery', Colors.green,false),
            Setting(Icon(Icons.search,color: Colors.white),'Turn on Job Search', Colors.blue,false),
            Setting(Icon(Icons.save_alt,color: Colors.white),'Save data locally', Colors.limeAccent,false),
            Setting(Icon(Icons.perm_data_setting,color: Colors.white),'Turn off app in data', Colors.pink,false),
            Setting(Icon(Icons.sync,color: Colors.white),'Run app in background', Colors.grey,false),
            Setting(Icon(Icons.insert_chart,color: Colors.white),'DO SOM', Colors.indigo,false),
            Setting(Icon(Icons.brightness_3,color: Colors.white),'Dark Mode', Colors.black,false),
            Setting(Icon(Icons.show_chart,color: Colors.white),'setting 1', Colors.yellow,false),
          ],
        ),
      ),
    );
  }
}