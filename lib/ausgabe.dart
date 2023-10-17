import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// Import your database-related code here, such as database operations

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Define a QR code scanner controller
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
        title: const Text('QR Scanner'),
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
                  color: Colors.transparent,
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
                Navigator.pop(context);
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
    controller.scannedDataStream.listen((scanData) async {
      String? barcodeData = scanData.code;

      // Check if the data exists in the database
      bool dataExists = await checkDataExistsInDatabase(barcodeData!);

      if (dataExists) {
        // Data exists, so delete it from the database
        await deleteDataFromDatabase(barcodeData);
      }

      // Implement your QR code scanning logic here (e.g., display a message)
      if (kDebugMode) {
        print('Scanned QR Code: $barcodeData');
      }
    });
  }

  // Replace these hypothetical functions with your actual database operations
  Future<bool> checkDataExistsInDatabase(String data) async {
    // Perform a database query to check if data exists
    // Return true if it exists, false if it doesn't
    return false; // Replace with your logic
  }

  Future<void> deleteDataFromDatabase(String data) async {
    // Perform a database operation to delete data
    // Implement your logic to delete the data from the database
  }
}

void main() {
  runApp(const MaterialApp(
    home: MenuPage(),
  ));
}