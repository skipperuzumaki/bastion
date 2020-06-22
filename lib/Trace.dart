import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

// TODO: Add File IO

void Trace() async {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  print("Scan Started");
  while(true) {
    await flutterBlue.startScan(timeout: Duration(seconds: 5));
    print("Scan Done");
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        var svuuids = r.advertisementData.serviceUuids;
        print(svuuids);
      }
    });
    await flutterBlue.stopScan();
  }
}