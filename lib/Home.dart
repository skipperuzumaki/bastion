import 'package:bastion/Broadcast.dart';
import 'package:flutter/material.dart';
import 'Trace.dart';
import 'Broadcast.dart';
import 'Cryptography.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  IconData val = Icons.sync;
  Color col = Colors.white;

  SendData s_dta = new SendData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bastion'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: RaisedButton(
              onPressed: (){setState(() {
                val = Icons.block;
                col = Colors.red;
                Broadcast(s_dta);
                //Trace();
              });
              },
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(Icons.play_arrow,),
                  SizedBox(width: 10.0,),
                  Text('Start Contact Tracing')
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Divider(
              height: 8.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter Pincode',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white)
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: RaisedButton(
              onPressed: (){
                setState(() {
                  val = Icons.check_circle;
                  col = Colors.lightGreen;
                });
              },
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(Icons.sync,),
                  SizedBox(width: 10.0,),
                  Text('Check Databases')
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Icon(
              val,
              color: col,
              size: 300.0,
            ),
          )
        ],
      ),
    );
  }
}