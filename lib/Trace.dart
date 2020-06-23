import 'package:flutter_blue/flutter_blue.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// TODO: Add File IO

void Trace() async {
  final directory = await getApplicationDocumentsDirectory();
  var path = directory.path;
  var DataStore = File('$path/counter.txt');
  FlutterBlue flutterBlue = FlutterBlue.instance;
  while(true) {
    await flutterBlue.startScan(timeout: Duration(seconds: 300));
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        var svuuids = r.advertisementData.serviceUuids;
        svuuids.forEach((uuid) {
          if (uuid.substring(0,6) == '000000'){
            print(uuid);
            DataStore.writeAsString(uuid, mode: FileMode.append);
          }
        });
      }
    });
    await flutterBlue.stopScan();
  }
}