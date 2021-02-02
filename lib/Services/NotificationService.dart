import 'package:chatapp/Screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService extends StatefulWidget {
  @override
  _NotificationServiceState createState() => _NotificationServiceState();
}

class _NotificationServiceState extends State<NotificationService> {

  final FirebaseMessaging _fm = FirebaseMessaging();
  var data;


  getToken()async{
    //Making sure that the token is sent only once..Another method was to perform a read operation in firestore and check if the key is already registered or not..
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool result = storage.getBool("TokenRegistered");
    print(result);
    if(result==true){
      print("Token has already been sent to the firestore!!");
    }
    else{
      var userToken = await _fm.getToken();
      CollectionReference collectionRef = FirebaseFirestore.instance.collection("UserTokens");
      Map<String,dynamic>jsonData={"userToken":userToken};
      collectionRef.add(jsonData);
      storage.setBool("TokenRegistered", true);
    }
  }

  configureFirebaseMessaging(){
    _fm.configure(
        onMessage: (Map<String,dynamic>message)async{
          print("onMessage: $message");
          setState(() {
            data=message["notification"]["title"];
          });
        },

        onLaunch: (Map<String,dynamic>message)async{
          print("onLaunch : $message");
        },

        onResume: (Map<String,dynamic>message)async{
          print("OnResume : $message");
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    configureFirebaseMessaging();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
       child: Text('This is chat screen !!!',style: TextStyle(color: Colors.white,fontSize: 25),)
      ),
    );
  }
}
