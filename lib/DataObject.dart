import 'package:mysql1/mysql1.dart';
import 'dart:async';

class DataObject {
  final int id;
  final DateTime eingang;
  final DateTime ausgang;
  final String adress;
  final int user_id;
  final int user_ausgang_id;

  const DataObject({
    required this.id,
    required this.eingang,
    required this.ausgang,
    required this.adress,
    required this.user_id,
    required this.user_ausgang_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eingang_datum': eingang,
      'ausgang_datum': ausgang,
      'adress': adress,
      'user_id': user_id,
      'user_id_ausgang': user_ausgang_id,
    };
  }

  Future<void> insertBook(Map<String, dynamic> bookMap) async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: 'db.triopt.de',
        port: 3306,
        user: 'junaid',
        password: 'y^ZJ3Dea',
        db: 'lager',
      ),
    );

    await conn.query(
      'INSERT INTO signin (id, eingang_datum, ausgang_datum, adress, user_id, user_id_ausgang) '
      'VALUES (?, ?, ?, ?, ?, ?)',
      [
        bookMap['id'],
        bookMap['eingang'],
        bookMap['ausgang'],
        bookMap['adress'],
        bookMap['user_id'],
        bookMap['user_id_ausgang'],
      ],
    );

    await conn.close();
  }
}
