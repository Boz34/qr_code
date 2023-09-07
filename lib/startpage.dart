import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_code/menu.dart';
import 'package:qr_code/scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyAppState(),
    );
  }
}

class _MyAppState extends StatelessWidget {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('QR Code Lager'),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRScan()),
                        );
                      },
                      child: const Text('QRScan')),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MenuPage()),
                        );
                      },
                      child: const Text('Menu'))
                ]),
          )),
    );
  }
}
