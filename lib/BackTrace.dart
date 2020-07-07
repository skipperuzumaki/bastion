import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BackTrace extends StatelessWidget {
  List<Widget> scftree = new List<Widget>();
  String Key = "Dummy";
  Widget Body = Column();
  void rt() async {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    var Dataread = File('$path/counter.txt');
    var Keyread = File('$path/Key.txt');
    var val = await Keyread.readAsBytes();
    Key = val.toString();
    String temp = await Dataread.readAsString();
    print(temp);
    var t2 = temp.split("\n");
    t2.forEach((element) {
      //scftree.add(Layout(element));
    });
    Body = Column(
      children: scftree,
    );
    print(Body);
  }
  BackTrace(){
    rt();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BackTrace"), backgroundColor: Colors.black,),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Text(Key),
          Body,
        ],
      ),
    );
  }
}

class Layout extends StatelessWidget {
  String uuid;
  String timestamp;
  Layout(String text){
    var test = text.split(":");
    uuid = test[0];
    timestamp = test[1];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(uuid),
            SizedBox(width: 10.0,),
            Text(timestamp),
          ],
        ),
      ),
    );
  }
}
