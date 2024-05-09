// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
// import 'package:projectbluesky/main.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';
import 'package:projectbluesky/signIn/register.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
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
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: () {
                    _firebase.login(_emailController.text.trim(), _passwordController.text.trim());
                    Navigator.pushNamed(context, '/');
                  }, child: const Text('Login')),
                  
                  const Text('Not registered?'),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: const Text('Register'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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
