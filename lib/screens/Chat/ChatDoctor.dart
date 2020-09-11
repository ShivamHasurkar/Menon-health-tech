import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String phone;
  Chat(this.phone);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Comming Soon",
          style: TextStyle(
              fontSize: 30,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
