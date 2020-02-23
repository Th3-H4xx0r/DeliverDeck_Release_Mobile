
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;

class DataManagement{
  
  Future getUserData(String userID) async {
    
    List userDataList = [];
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Delivery Personel").child(userID);
    
    DataSnapshot snapshot = await databaseReference.once();

    print(snapshot.value);

    
    if(snapshot.value != null){
      Map<dynamic, dynamic> rawData = snapshot.value;


      userDataList = [rawData["UserID"], rawData["Email"], rawData["First Name"], rawData["Last Name"], rawData["Total Deliveries"], rawData["User Rating"], rawData["Deliveries Attempted"]];
    }

    print(userDataList);
    return userDataList;
  }


  Future deliveryPersonelApplication(String firstName, String lastName, String carName, String bio, String userID){

    print(firstName);

    print(lastName);

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Delivery Personel").child(userID);

    databaseReference.child("First Name").set(firstName.toString());

    databaseReference.child("Last Name").set(lastName.toString());

    databaseReference.child("Bio").set(bio);

    databaseReference.child("Car Name").set(carName);

    databaseReference.child("New User").set(false);

  }
  
  Future checkIfUserIsNew(String userID) async {
    
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Delivery Personel").child(userID).child("New User");

    DataSnapshot snapshot = await databaseReference.once();

    return snapshot.value;
  }


  Future getJobOffers() async{

    List jobOffersList = [];
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs");

    DataSnapshot dataSnapshot = await databaseReference.once();

    if(dataSnapshot.value != null){
      Map<dynamic, dynamic> rawData = dataSnapshot.value;

      rawData.forEach((key, value){
        jobOffersList.add([value["Job Description"], value["Job Name"], value["Job Size"]]);
      });

    }

    return jobOffersList;
  }

  Future markPackageDelivered(String userID, String companyName, String packageID) async{
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Delivery Personel").child(userID).child("Total Deliveries");

    DataSnapshot dataSnapshot = await databaseReference.once();

    databaseReference.set(dataSnapshot.value + 1);

    //DatabaseReference reference = FirebaseDatabase.instance.reference().child("Jobs").child(companyName).child("Active Deliveries").child(packageID);

    //reference.remove();
  }

  Future markPackageProblem(String userID, String jobName, String packageID) async{

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs").child(jobName).child("Active Deliveries").child(packageID).child("Status");

    databaseReference.set("Incomplete");

  }

  Future getActiveDeliveries(String jobName) async {
    List activeDeliveriesList = [];
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs").child(jobName).child("Active Deliveries");

    DataSnapshot dataSnapshot = await databaseReference.once();

    if(dataSnapshot.value != null){
      Map<dynamic, dynamic> rawData = dataSnapshot.value;

      rawData.forEach((key, value){
        activeDeliveriesList.add([value["Delivery ID"], value["Status"], value["Address"]]);
      });
    }

    return activeDeliveriesList;


  }

  Future saveCompanyInfo(String companyName, String jobDescription, String companySize) async{
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs").child(companyName.toString());

    
    databaseReference.child("Job Name").set(companyName.toString());
    
    databaseReference.child("Job Description").set(jobDescription.toString());

    databaseReference.child("Company Size").child(companySize.toString());

  }

  Future addPackage(String companyName, String address) async {

    var generatedCode = "";

    var randomInstance = new math.Random();
    var next = randomInstance.nextInt(9);
    for (int i = 0; i <= 5; i++) {
      generatedCode = generatedCode + next.toString();
      next = randomInstance.nextInt(9);
    }

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Jobs").child(companyName).child("Active Deliveries").child(generatedCode);

    databaseReference.child("Delivery ID").set(generatedCode);

    print("SOME");

    databaseReference.child("Status").set("Pending");

    databaseReference.child("Address").set(address);



  }
}