import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Auth {
  final databaseReference = FirebaseDatabase.instance.reference();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return [user.uid, "Success"];
    }catch(e){
      print(e);
      return(["error", e]);
    }


  }

  Future signUp(String email, String password) async {

    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      databaseReference.child("Delivery Personel").child(user.uid).child("UserID").set(user.uid);
      databaseReference.child("Delivery Personel").child(user.uid).child("Email").set(user.email);
      databaseReference.child("Delivery Personel").child(user.uid).child("Display Name").set(user.displayName);
      databaseReference.child("Delivery Personel").child(user.uid).child("Total Deliveries").set(0);
      databaseReference.child("Delivery Personel").child(user.uid).child("User Rating").set(100);
      databaseReference.child("Delivery Personel").child(user.uid).child("Deliveries Attempted").set(0);
      databaseReference.child("Delivery Personel").child(user.uid).child("Display Name").set("No Name");
      databaseReference.child("Delivery Personel").child(user.uid).child("New User").set(true);


      return (["Success", user.uid]);
    }catch(e){
      print(e);
      return (["Error", e]);
    }



  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}