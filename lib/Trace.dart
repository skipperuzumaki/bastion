import 'package:flutter_blue/flutter_blue.dart';

void Trace() async {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  while(true){
    flutterBlue.startScan();
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        List<BluetoothService> services = await r.device.discoverServices();
        services.forEach((service) {
          print(service.uuid);
          if (int.parse(service.uuid.toString().substring(0,32),radix: 2) == 0){
            print(service.uuid.toString());
          }
        });
      }
    });
  }
}