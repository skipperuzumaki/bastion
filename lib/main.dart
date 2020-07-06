import 'package:flutter/material.dart';
import 'package:bastion/Home.dart';
import 'package:bastion/BackTrace.dart';

void main() => runApp(Bastion());

class Bastion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BackTrace bt = new BackTrace();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context)=> Home());
            break;
          case '/bt':
            return MaterialPageRoute(builder: (context)=> bt);
            break;
        }
      },
    );
  }
}
