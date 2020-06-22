import 'package:flutter/material.dart';
import 'package:bastion/Home.dart';

void main() => runApp(Bastion());

class Bastion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (Context) => Home(),
      },
    );
  }
}
