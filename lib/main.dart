import 'dart:io';

import 'package:flutter/material.dart';
import 'package:esim_installer_flutter/esim_installer_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EsimInstallerHome(),
    );
  }
}

class EsimInstallerHome extends StatefulWidget {
  @override
  _EsimInstallerHomeState createState() => _EsimInstallerHomeState();
}

class _EsimInstallerHomeState extends State<EsimInstallerHome> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await EsimInstallerFlutter().getPlatformVersion() ??
          'Unknown platform version';
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _installEsimProfile() async {
    String result;
    try {
      result = await EsimInstallerFlutter().installESimProfile(
        smdpAddress: 'RSP-0026.OBERTHUR.NET',
        activationToken: '777FG-KSFV1-F2O3E-CW2X4',
      );
    } catch (e) {
      result = 'Failed to install eSIM profile.';
    }

    setState(() {});
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
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(
              onPressed: () {
                if (Platform.isIOS) {
                  launchUrlString(
                    esimUrl,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  _installEsimProfile;
                }
              },
              child: const Text('Install eSIM Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
