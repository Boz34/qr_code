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
 print("blablabla");
 return conn;
}

Future<void> insertData() async {
 final MySqlConnection conn = await openConnection();

 try {
    var result = await conn.query(
      "INSERT INTO lager.lager (serialnummer, name) VALUES (?, ?)",
      ['12346276', 'Example Book'],
    );

    print("Inserted ${result.affectedRows} row(s)");
 } catch (e) {
    print("Error: $e");
 } finally {
    conn.close();
 }
}