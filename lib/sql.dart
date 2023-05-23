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

Future<List<ResultRow>> getUsers() async {
  var conn = await openConnection();

  var results =
      await conn.query('SELECT * FROM signin'); // Update the table name here

  await conn.close();

  return results.toList();
}
