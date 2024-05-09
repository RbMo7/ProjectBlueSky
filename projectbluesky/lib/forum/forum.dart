import 'package:flutter/material.dart';

class forum extends StatefulWidget {
  const forum({super.key});

  @override
  State<forum> createState() => _forumState();
}

class _forumState extends State<forum> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Forum"));
  }
}
