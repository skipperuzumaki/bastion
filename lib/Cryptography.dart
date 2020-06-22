import 'package:cryptography/cryptography.dart';
import 'dart:math';

// TODO: Add File IO

class SendData {
  final algorithm = chacha20;
  SecretKey key;
  Nonce nonce;
  var rng = new Random();
  SendData() {
    // try to get key from file
    // if key not found
    // store key to file
    // replace with constant 96 bit nonce
  }
  Future<String> GetString() async {
    final key = await algorithm.newSecretKey();
    final nonce = await algorithm.newNonce();
    List<int> vals = new List<int>();
    for (var i = 0; i < 6; i++){
      vals.add(rng.nextInt(256));
    }
    for (var i = 0; i < 3; i++){
      vals.add(255);
    }
    print(vals);
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
}
