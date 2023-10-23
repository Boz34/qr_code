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

Future<void> insertData(String data1, String data2,
    String data3) async {
  final MySqlConnection conn = await openConnection();

  try {
    final results = await conn.query(
      "INSERT INTO lager.lager (serialnummer, datum, standort) VALUES (?, ?, ?)",
      [data1, data2, data3],
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
