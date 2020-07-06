import 'package:cryptography/cryptography.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SendData {
  final algorithm = chacha20;
  SecretKey key;
  Nonce nonce = new Nonce([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
  var rng = new Random();
  SendData() {
    get_key_value();
  }
  Future<String> GetString() async {
    List<int> vals = new List<int>();
    for (var i = 0; i < 6; i++){
      vals.add(rng.nextInt(256));
    }
    for (var i = 0; i < 3; i++){
      vals.add(255);
    }
    final encrypted = await algorithm.encrypt(
      vals,
      secretKey: key,
      nonce: nonce,
    );
    String data = "";
    for (var i = 0; i < 9; i++){
      var j = encrypted[i].toString();
      while (j.length < 3){
        j = '0' + j;
      }
      data += j;
    }
    data = '000000' + data;
    data = data.substring(0,8) + '-' +
        data.substring(8, 12) + "-4" +
        data.substring(12, 15) + "-8" +
        data.substring(15, 18) + "-" +
        data.substring(18);
    print(data);
    return data;
  }
  Future<bool> Verify(String data, SecretKey Key) async {
    List<int> lst;
    for (var i = 0;i < 88; i+=8){
      lst.add(int.parse(data.substring(i,i+8),radix: 2));
    }
    final decrypted = await algorithm.decrypt(
      lst,
      secretKey: Key,
      nonce: nonce,
    );
    bool ret = true;
    for (var i = 7; i < 12; i++){
      if (decrypted[i] != 255){
        ret = false;
        break;
      }
    }
    return ret;
  }

  void get_key_value() async {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    if (await File('$path/Key.txt').exists()) {
      var Key_value = File('$path/Key.txt');
      var data = await Key_value.readAsBytes();
      key = new SecretKey(data);
    }
    else{
      generate_key();
    }
  }

  void generate_key() async {
    print("Generating Keys");
    key = await algorithm.newSecretKey();
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    print(path);
    var Key_value = File('$path/Key.txt');
    Key_value.writeAsBytes(key.extractSync());
    print(key.extractSync());
    }
}
