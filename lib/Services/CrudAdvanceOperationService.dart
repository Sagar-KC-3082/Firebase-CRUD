import 'package:cloud_firestore/cloud_firestore.dart';

class CrudAdvanceOperation{

  final FirebaseFirestore _fb = FirebaseFirestore.instance;

  readData()async{
   QuerySnapshot queryCollection = await _fb.collection("Users").get();
   var data = queryCollection.docs;
   return data;
  }

  //This function continuously reads the data from firebase and reflects any changes without needing to hot restart..
  Stream readDataContinuously()async*{
    while(true){
          yield await readData();
    }
  }

  writeData(Map<String,dynamic>userInfo)async{
    CollectionReference _collectionRef =await _fb.collection("Users");
    _collectionRef.add(userInfo);
  }

  deleteData(String firebaseID)async{
    await _fb.collection("Users").doc(firebaseID).delete();
  }

  updateData(String firebaseID,Map<String,dynamic>userInfo)async{
    await _fb.collection("Users").doc(firebaseID).update(userInfo);
  }

}