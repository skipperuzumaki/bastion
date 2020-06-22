import 'package:flutter_ble_peripheral/data.dart';
import 'package:flutter_ble_peripheral/main.dart';
import 'Cryptography.dart';

class Broadcast {
  // TODO: Add continously updating advertising
  FlutterBlePeripheral blePeripheral = FlutterBlePeripheral();
  Future<void> Start(SendData s_dta) async {
    AdvertiseData _data = AdvertiseData();
    _data.includeDeviceName = false;
    _data.uuid = await s_dta.GetString();
    blePeripheral.start(_data);
  }
  void Stop() {
    blePeripheral.stop();
  }
}