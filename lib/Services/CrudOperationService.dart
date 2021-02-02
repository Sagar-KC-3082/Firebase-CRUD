import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudOperationServices{

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _fb = FirebaseAuth.instance; //This is irrelevant to CRUD operation. Its just to get UID.

  createOperation()async{
    var uid = await _fb.currentUser.uid; //This is irrelevant to CRUD operation. Its just to get UID.
    Map<String,dynamic> data = {"UID":uid,"Name":"Sagar"};
    var result = await _db.collection("UserTokens").add(data);
    print(result);
  }

  readOperation()async{
    QuerySnapshot querySnapshot = await _db.collection("UserTokens").get();
    var data  = querySnapshot.docs;
    return data;
  }

  updateOperation()async{
    QuerySnapshot querySnap = await FirebaseFirestore.instance.collection("UserTokens").get();
    querySnap.docs[0].reference.update({"Name":"Santosh KC"});
  }

  deleteOperation()async{
    QuerySnapshot querySnapshot = await _db.collection("UserTokens").get();
    querySnapshot.docs[0].reference.delete();
  }

}