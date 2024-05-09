// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
// import 'package:projectbluesky/main.dart';
import 'package:projectbluesky/signIn/auth_gate.dart';
import 'package:projectbluesky/signIn/firebaseSignin.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
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
                    _firebase.register(_emailController.text.trim(), _passwordController.text.trim(), _nameController.text.trim());
                    Navigator.pushNamed(context, '/');
                  }, child: const Text('Register')),
                   const Text('Already logged in?'),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: const Text('Login'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthGate()));
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
