import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_esim/flutter_esim.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSupportESim = false;
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
      _isSupportESim = isSupportESim;
    });
  }

  Future<void> installEsim() async {
    await _flutterEsimPlugin.installEsimProfile("LPA:1\$lpa.airalo.com\$TEST");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('isSupportESim: $_isSupportESim\n'),
              ElevatedButton(
                onPressed: () {
                  installEsim();
                },
                child: const Text('Install eSim'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
