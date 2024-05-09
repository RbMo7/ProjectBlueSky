import 'package:flutter/material.dart';

class Challenges extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text("Challenges"));
  }
}
