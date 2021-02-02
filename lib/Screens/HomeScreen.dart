import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0,
        title: Text("Chat App"),
      ),
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.attach_money_rounded),
      ),
      body: Center(child: Text("Welcome to chat app",style: TextStyle(fontSize: 30,color: Colors.white),),),
    );
  }
}
