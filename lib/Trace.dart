import 'package:flutter_blue/flutter_blue.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:workmanager/workmanager.dart';

void write(File DataLoc, String data){
  var epochtime = (new DateTime.now()).millisecondsSinceEpoch;
  epochtime = (epochtime / 1000).round();
  epochtime = (epochtime / 86400).round();
  data = data + ":" + epochtime.toString() + "\n";
  print("Writing : " + data);
  if (!DataLoc.existsSync()) {
    DataLoc.writeAsString(data);
  }
  else {
    DataLoc.writeAsString(data, mode: FileMode.append);
  }
}


void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    String path = inputData["File"];
    write(File('$path/counter.txt'), inputData['uuid']);
    return Future.value(true);
  });
}

class Tracer {
  bool Run;
  int i;
  Tracer(){
    Run = false;
    i = 0;
    Workmanager.initialize(
        callbackDispatcher,
        isInDebugMode: true
    );
  }
  void Trace() async {
    Run = true;
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path.toString();
    FlutterBlue flutterBlue = FlutterBlue.instance;
    while (Run) {
      await flutterBlue.startScan(timeout: Duration(seconds: 10));
      flutterBlue.scanResults.listen((results) async {
        for (ScanResult r in results) {
          var svuuids = r.advertisementData.serviceUuids;
          svuuids.forEach((uuid) {
            if (uuid.substring(0, 6) == '000000') {
              var data = uuid.substring(0, 8) +
                  uuid.substring(9, 13) +
                  uuid.substring(15, 18) +
                  uuid.substring(20, 23) +
                  uuid.substring(24);
              data = data.substring(6);
              Workmanager.registerOneOffTask(
                data,
                "Write",
                inputData: {
                  'File': path,
                  'uuid': data,
                },
              );
            }
          });
        }
      });
      await flutterBlue.stopScan();
      Workmanager.cancelAll();
    }
  }
  void Stop(){
    Run = false;
    Workmanager.cancelAll();
  }
}