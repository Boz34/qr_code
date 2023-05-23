import 'package:flutter/material.dart';
import 'package:qr_code/dataobject.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _insertData(),
          child: Text('Insert Data'),
        ),
      ),
    );
  }

  Future<void> _insertData() async {
    final dataObject = DataObject(
      id: 1,
      eingang: DateTime.now(),
      ausgang: DateTime.now(),
      adress: 'Sample Address',
      user_id: 999666,
      user_ausgang_id: 456,
    );

    await dataObject.insertBook(dataObject.toMap());
    print('Data inserted successfully.');
  }
}
