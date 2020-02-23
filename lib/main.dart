import 'package:deliverdeck/loginpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SplashScreen()));

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {




  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 3000)).then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginSignupPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black,
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      child: Text(
                        'DeliverDeck',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 350,
                      child: Image.network(
                        'https://thumbs.dreamstime.com/b/open-box-icon-black-background-black-flat-style-vector-illustration-open-box-icon-black-background-black-flat-style-vector-170441923.jpg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
