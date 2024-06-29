import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.esim/esim');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('eSIM Installer'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              installEsim();
            },
            child: Text('Install eSIM'),
          ),
        ),
      ),
    );
  }

  Future<void> installEsim() async {
    try {
      final String activationCode = 'LPA:1\$RSP-0026.OBERTHUR.NET\$777FG-KSFV1-F2O3E-CW2X4';
      final String result = await platform.invokeMethod('installEsim', {'activationCode': activationCode});
      print(result); // Print success message
    } on PlatformException catch (e) {
      print("Failed to install eSIM: '${e.message}'.");
    }
  }
}
