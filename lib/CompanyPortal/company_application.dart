import 'package:deliverdeck/CompanyPortal/company_dashboard.dart';
import 'package:deliverdeck/datamanagement.dart';
import 'package:deliverdeck/loginpage.dart';
import 'package:flutter/material.dart';

class CompanyApplication extends StatefulWidget {
  CompanyApplication({Key key}) : super(key: key);

  @override
  _CompanyApplicationState createState() => _CompanyApplicationState();
}

class _CompanyApplicationState extends State<CompanyApplication> {

  var dataManagementInstance = DataManagement();

  //Controllers
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController companySizeController = TextEditingController();

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
                    controller: companyNameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Name of Organization',
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
                    controller: companySizeController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Organization Size',
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
                    controller: companyDescriptionController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Job Description',
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
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Estemated Number of MailMan Required',
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
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent[400]),
                      ),
                      labelText: 'Type of Packages',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      hintText: 'ex. John',
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      focusColor: Colors.grey[400],
                    ),
                  )),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () async{
                await dataManagementInstance.saveCompanyInfo(companyNameController.text, companyDescriptionController.text, companySizeController.text);

                Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDashboard()));
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Create Organization',
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

            SizedBox(height: 20),
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget submitButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Company Code"),
      content: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 60,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent[400]),
              ),
              labelText: 'Company Code',
              labelStyle: TextStyle(color: Colors.grey[300]),
              hintText: 'Enter Code',
              hintStyle: TextStyle(color: Colors.grey[200]),
              focusColor: Colors.grey[400],
            ),
          )),
      actions: [
        cancelButton,
        submitButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}