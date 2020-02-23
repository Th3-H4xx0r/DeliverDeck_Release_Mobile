import 'package:deliverdeck/datamanagement.dart';
import 'package:deliverdeck/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPage extends StatefulWidget {
  @override
  ApplicationPageState createState() => ApplicationPageState();
}

class ApplicationPageState extends State<ApplicationPage> {

  //Global Var
  var userID = "";
  var dataManagementInstance = DataManagement();

  //Text Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  Future updateData() async {
    var prefs = await SharedPreferences.getInstance();

    userID = prefs.getString("StoredUser");

  }

  @override
  void initState() {
    updateData().then((_){
      setState(() {

      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 100),
            Center(
              child: Text(
                'Application',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: 60),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 60,
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      hintText: 'ex. John',
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      focusColor: Colors.grey[400],
                    ),
                  )),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 60,
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      hintText: 'ex. Doe',
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      focusColor: Colors.grey[400],
                    ),
                  )),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 60,
                  child: TextField(
                    controller: carNameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Car Name',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      hintText: 'ex. Year Company Model',
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      focusColor: Colors.grey[400],
                    ),
                  )),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 170,
                  child: TextField(
                    controller: bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      hintText: 'Give some basic info about yourself',
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      focusColor: Colors.grey[400],
                    ),
                  )),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    'Upload Resume',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height:30),
            GestureDetector(
              onTap: () async{
                await dataManagementInstance.deliveryPersonelApplication(firstNameController.text.toString(), lastNameController.text.toString(), carNameController.text, bioController.text, userID);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}