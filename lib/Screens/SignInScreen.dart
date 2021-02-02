import 'package:chatapp/Services/SignInService.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Authentication _authObj = Authentication();

  bool _isListening = false;
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           InkWell(
             onTap: ()async{
               setState(() {
                 _isListening=true;
               });
               var result = await _authObj.signInWithGoogle();
               if(result==null){
                 setState(() {
                   _isListening=false;
                   _isError=true;
                 });
               }
               else{
                 setState(() {
                   _isListening=false;
                   Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
                     return HomeScreen();
                   }));
                 });
               }
             },
             child:  Container(
               child: Text("Google SignIn",style: TextStyle(fontSize: 20,color: Colors.white),),
               padding: EdgeInsets.symmetric(horizontal: 30,vertical: 12),
               decoration: BoxDecoration(
                   color: Colors.red,
                   borderRadius: BorderRadius.circular(20)
               ),
             ),
           ),
            SizedBox(height: 50,),
            _isListening==true? Container(
              height: 40,width:width,child: Center(child: CircularProgressIndicator(),),
            ):
            Container()
          ],
        ),
      ),
    );
  }
}
