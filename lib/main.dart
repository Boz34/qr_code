import 'package:flutter/material.dart';
import 'dataobject.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataObject = DataObject(
      id: 1,
      eingang: DateTime.now(),
      ausgang: DateTime.now(),
      adress: 'Sample Address',
      user_id: 999666,
      user_ausgang_id: 456,
    );

    _insertData() async {
      await dataObject.insertBook(dataObject.toMap());
      print('Data inserted into the database!');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _insertData,
          child: Text('Insert Data'),
        ),
      ),
    );
  }
}
