import 'package:chatapp/Services/CrudAdvanceOperationService.dart';
import 'package:flutter/material.dart';

class CrudAdvanceHomeScreen extends StatelessWidget {

  final CrudAdvanceOperation _crudobj = CrudAdvanceOperation();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final GlobalKey<ScaffoldState> _key1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key1,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add,size: 30,),
        onPressed: (){
          _key1.currentState.showSnackBar(SnackBar(
              backgroundColor: Color(0xFFeaac7f),
              duration: Duration(seconds: 30),
              content:Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Name : ",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Age : ",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    icon:Icon(Icons.done),
                    onPressed: (){
                      _key1.currentState.hideCurrentSnackBar();
                      String name = _nameController.text;
                      String age = _ageController.text;
                      Map<String,dynamic>userInfo={"Name":name,"Age":age};
                      if(_nameController.text!="" && _ageController.text!=""){
                        _crudobj.writeData(userInfo);
                      }
                    },
                  )
                ],
              )
          ));
        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Advance CRUD Operations"),
        backgroundColor: Color(0xFFc19277),
      ),
      backgroundColor:Color(0xFFe1bc91),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          StreamBuilder(
              stream: _crudobj.readDataContinuously(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics:ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                      return CustomContainer(key2:_key1,name: snapshot.data[index]["Name"],age: snapshot.data[index]["Age"],firebaseId: snapshot.data[index].id,);
                    },
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              }),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {

  CrudAdvanceOperation _obj = CrudAdvanceOperation();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  GlobalKey<ScaffoldState> key2;
  String name;
  String age;
  String firebaseId;
  CustomContainer({this.name,this.age,this.firebaseId,this.key2});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(3,3)
              )
            ]
        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        child: Row(
          children: [
            Container(width:width*0.4,child: Text("Name : ${name}",style: TextStyle(fontSize: 13,color: Colors.black),textScaleFactor: 1,overflow: TextOverflow.ellipsis,softWrap: false,)),
            Container(child: Text("Age : ${age}",style: TextStyle(fontSize: 13,color: Colors.black),textScaleFactor: 1,)),
            Spacer(),
            InkWell(
                onTap: (){
                    _obj.deleteData(firebaseId);
                },
                child: Icon(Icons.delete,size: 17,color: Colors.grey,)
            ),
            SizedBox(width: 20,),
            InkWell(
                onTap: (){
                  key2.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 30),
                    backgroundColor: Color(0xFFeaac7f),
                    content: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: "Name : ",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: TextField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: "Age : ",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                          icon:Icon(Icons.done),
                          onPressed: (){
                            key2.currentState.hideCurrentSnackBar();
                            String name = _nameController.text;
                            String age = _ageController.text;
                            Map<String,dynamic>userInfo={"Name":name,"Age":age};
                            if(_nameController.text!="" && _ageController.text!=""){
                              _obj.updateData(firebaseId,userInfo);
                            }
                          },
                        )
                      ],
                    ),
                  ));
                  _obj.updateData(firebaseId,{"Name":"Unkown","Age":"0"});
                },
                child: Icon(Icons.edit,size: 17,color: Colors.grey,)
            ),
          ],
        ),
    );
  }
}
