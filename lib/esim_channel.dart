import 'package:flutter/services.dart';

class EsimChannel {
  static const platform = MethodChannel('com.example.esim/install');

  Future<void> installEsim(String lpaUrl) async {
    try {
      await platform.invokeMethod('installEsim', {'lpaUrl': lpaUrl});
    } on PlatformException catch (e) {
      print("Failed to install eSIM: '${e.message}'.");
    }
  }
}
