import 'package:deliverdeck/CompanyPortal/company_application.dart';
import 'package:deliverdeck/DeliverPortal/applicationpage.dart';
import 'package:deliverdeck/DeliverPortal/profilepage.dart';
import 'package:deliverdeck/datamanagement.dart';
import 'package:deliverdeck/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';

class LoginSignupPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new LoginSignupPageState();
}

class LoginSignupPageState extends State<LoginSignupPage> {

  ////inal VoidCallback loginCallback;

  var authReference = Auth();

  final _formKey = new GlobalKey<FormState>();

  var dataManagementInstance = DataManagement();

  getemail() {
    return _email;
  }

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future validateAndSubmit() async{ // CALLS LOGIN FUNCTION
    print(validateAndSave());
    print(_isLoginForm);
    if (validateAndSave()) {
      if(_isLoginForm){
          var x = await authReference.signIn(_email, _password); // CALLS LOGIN
          if(x[0] == "error"){
            //LOGIN ERROR
            _errorMessage = x[1].toString();
            setState(() {

            });
          } else {
            //LOGIN SUCCESSFUL
            print("SUCCESSFUL");
            var prefs = await SharedPreferences.getInstance();

            prefs.setString("StoredUser", x[0].toString());

            print("Stored User ID: " + x[0].toString());

            var newUserBool = await dataManagementInstance.checkIfUserIsNew(x[0].toString());

            print(newUserBool);

            if(newUserBool == true){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicationPage()));
            } else if (newUserBool == false){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
            }

          }

      } else {
          var callSignUp = await authReference.signUp(_email, _password);

          if(callSignUp[0] == "Error"){
            setState(() {
              _errorMessage = callSignUp[1].toString();
            });
          } else {
            print("Sign up success");
            _errorMessage = "";
            toggleFormMode();


          }


      }
    }

  }
  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Stack(
            children: <Widget>[
              _showForm(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _showCircularProgress(),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[400],
        onPressed: (toggleFormMode),
        child: Icon(
          Icons.cached,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }


  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              showEmailInput(),
              showPasswordInput(),
              SizedBox(
                height: 10,
              ),
              showPrimaryButton(),
              SizedBox(
                height: 5,
              ),
              showSecondaryButton(),
              showErrorMessage(),

              SizedBox(
                height: 50,
              ),

              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyApplication()));
                  },
                  child: Text("I am a company", style: TextStyle(color: Colors.grey, fontSize: 15),),
                ),
              ),

              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.redAccent[400],
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[700]),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[700]),
            labelStyle: TextStyle(color: Colors.grey[700]),
            hintText: 'Email',
            icon: new Icon(
              Icons.mail_outline,
              color: Colors.grey[700],
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[700]),
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[700]),
            labelStyle: TextStyle(color: Colors.grey[700]),
            hintText: 'Password',
            icon: new Icon(
              Icons.lock_outline,
              color: Colors.grey[700],
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400])),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
        child: SizedBox(
          height: 45.0,
          child: new RaisedButton(
            elevation: 0.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Colors.redAccent[400],
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }


}