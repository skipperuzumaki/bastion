import 'package:flutter_blue/flutter_blue.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Tracer {
  bool Run = false;
  void Trace() async {
    Run = true;
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    var DataStore = File('$path/counter.txt');
    FlutterBlue flutterBlue = FlutterBlue.instance;
    while (Run) {
      await flutterBlue.startScan(timeout: Duration(seconds: 60));
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
              var epochtime = (new DateTime.now()).millisecondsSinceEpoch;
              epochtime = (epochtime / 1000).round();
              epochtime = (epochtime / 86400).round();
              data = data + ":" + epochtime.toString() + "\n";
              print("Writing : " + data);
              if (!DataStore.existsSync()) {
                DataStore.writeAsString(data);
              }
              else {
                DataStore.writeAsString(data, mode: FileMode.append);
              }
            }
          });
        }
      });
      await flutterBlue.stopScan();
    }
  }
}