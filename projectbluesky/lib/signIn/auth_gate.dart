import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:projectbluesky/main.dart';

class AuthGate extends StatefulWidget {
  AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(),
              TextField(),
              ElevatedButton(onPressed: () {}, child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
