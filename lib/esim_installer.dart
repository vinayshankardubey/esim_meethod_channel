import 'package:flutter/material.dart';
import 'esim_channel.dart';

class EsimInstaller extends StatefulWidget {
  @override
  _EsimInstallerState createState() => _EsimInstallerState();
}

class _EsimInstallerState extends State<EsimInstaller> {
  final EsimChannel _esimChannel = EsimChannel();

  void installEsim() async {
    const lpaUrl = "LPA:1\$RSP-0026.OBERTHUR.NET\$777FG-KSFV1-F2O3E-CW2X4";
    await _esimChannel.installEsim(lpaUrl);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('eSIM installation process started')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Install eSIM'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: installEsim,
          child: Text('Install eSIM'),
        ),
      ),
    );
  }
}
