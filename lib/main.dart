import 'dart:io';

import 'package:esim/esim_installer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esim/flutter_esim.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EsimInstallerHome(),
    );
  }
}

class EsimInstallerHome extends StatefulWidget {
  const EsimInstallerHome({super.key});

  @override
  EsimInstallerHomeState createState() => EsimInstallerHomeState();
}

class EsimInstallerHomeState extends State<EsimInstallerHome> {
  bool isSupportESim = false;
  final _flutterEsimPlugin = FlutterEsim();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _flutterEsimPlugin.onEvent.listen((event) {
      print(event);
    });
  }

  Future<void> initPlatformState() async {
    bool isSupportESim;
    try {
      isSupportESim = await _flutterEsimPlugin.isSupportESim([]);
    } on PlatformException {
      isSupportESim = false;
    }

    if (!mounted) return;

    setState(() {
      isSupportESim = isSupportESim;
    });
  }

  Future<void> installEsim() async {
    await _flutterEsimPlugin.installEsimProfile(
      "LPA:1\$RSP-0026.OBERTHUR.NET\$777FG-KSFV1-F2O3E-CW2X4",
    );
  }

  @override
  Widget build(BuildContext context) {
    const String esimUrl =
        "https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=LPA:1\$RSP-0026.OBERTHUR.NET\$777FG-KSFV1-F2O3E-CW2X4";

    return Scaffold(
      appBar: AppBar(
        title: const Text('eSIM Installer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // if (Platform.isIOS) {
                //   print('launched');
                //   launchUrlString(
                //     esimUrl,
                //     mode: LaunchMode.externalApplication,
                //   );
                // } else {
                installEsim();
                // }
              },
              child: const Text('Install eSIM Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
