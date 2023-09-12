import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey qrKey = GlobalKey();
  QRViewController? _qrController;

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ausgabe'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparent background
                  border: Border.all(
                    color: Colors.orangeAccent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _buildQrView(context),
              ),
            ),
          ),
          Container(
            // Add any other widgets or content you want below the QR scanner
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Your other content goes here.',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                // Implement your Home action here
                Navigator.pop(context); // This will navigate back to the main page (MenuPage)
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      // Implement your QR code scanning logic here
      print('Scanned QR Code: ${scanData.code}');
    });
  }
}
