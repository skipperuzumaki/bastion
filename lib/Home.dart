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
  bool tracing = false;
  IconData ct = Icons.play_arrow;
  String cts = 'Start Contact Tracing';
  SendData s_dta = new SendData();
  Broadcast bdcast = new Broadcast();
  Tracer tr = new Tracer();

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
              onPressed: (){ setState(() {
                if (!tracing){
                  tracing = true;
                  ct = Icons.stop;
                  cts = 'Stop Contact Tracing';
                  bdcast.Start(s_dta);
                  //Workmanager.registerOneOffTask("1", "Trace");
                  tr.Trace();
                }
                else{
                  tracing = false;
                  ct = Icons.play_arrow;
                  cts = 'Start Contact Tracing';
                  bdcast.Stop();
                  //Workmanager.cancelAll();
                  tr.Stop();
                }
              });
              },
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(ct,),
                  SizedBox(width: 10.0,),
                  Text(cts)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: RaisedButton(
              onPressed: (){ setState(() {
                s_dta.generate_key();
              });
              },
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(Icons.enhanced_encryption,),
                  SizedBox(width: 10.0,),
                  Text("Update Encryption Key")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: RaisedButton(
              onPressed: (){ setState(() {
                Navigator.pushNamed(context, '/bt');
              });
              },
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(Icons.dehaze,),
                  SizedBox(width: 10.0,),
                  Text("Show Recieved UUIDS")
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
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Icon(
                val,
                color: col,
                size: 300.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}