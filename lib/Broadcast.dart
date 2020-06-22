import 'package:flutter_ble_peripheral/data.dart';
import 'package:flutter_ble_peripheral/main.dart';
import 'Cryptography.dart';

void Broadcast(SendData s_dta) async {
  // change uuid to the data
  FlutterBlePeripheral blePeripheral = FlutterBlePeripheral();
  AdvertiseData _data = AdvertiseData();
  _data.includeDeviceName = false;
  _data.uuid = await s_dta.GetString();
  _data.manufacturerId = 1234;
  _data.manufacturerData = [1, 2, 3, 4, 5, 6];
  blePeripheral.start(_data);
}