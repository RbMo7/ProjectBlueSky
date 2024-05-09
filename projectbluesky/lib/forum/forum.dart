import 'package:flutter/material.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  Firebase _firebase = new Firebase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  SafeArea(child: ElevatedButton(onPressed: (){
      _firebase.logout();
      Navigator.pushNamed(context, '/');
    }, child: Text('logout'))));
  }
}
