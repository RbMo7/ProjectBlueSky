import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:projectbluesky/main.dart';
import 'package:projectbluesky/signIn/auth_gate.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final Firebase _firebase = Firebase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              
              Row(
                children: [
                  ElevatedButton(onPressed: () {
                    _firebase.register(_emailController.text.trim(), _passwordController.text.trim(), _nameController.text.trim());
                    Navigator.pushNamed(context, '/');
                  }, child: Text('Register')),
                   Text('Already logged in?'),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Text('Login'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthGate()));
                    },),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
