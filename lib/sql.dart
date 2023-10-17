import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

Future<MySqlConnection> openConnection() async {
  var settings = ConnectionSettings(
    host: 'db.triopt.de',
    port: 3306,
    user: 'junaid',
    password: 'y^ZJ3Dea',
    db: 'lager',
  );

  var conn = await MySqlConnection.connect(settings);
  return conn;
}

Future<void> insertData(String barcode, String data1, String data2,
    String data3, String data4) async {
  final MySqlConnection conn = await openConnection();

  if (kDebugMode) {
    print('blablabla');
  }

  try {
    final results = await conn.query(
      "INSERT INTO lager.lager (`s/n`, datum, standort, anhang) VALUES (?, ?, ?, ?, ?)",
      [barcode, data1, data2, data3, data4],
    );

    if (results.affectedRows! > 0) {
    } else {
      if (kDebugMode) {
        print("Data not inserted.");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
  } finally {
    conn.close();
  }
}
