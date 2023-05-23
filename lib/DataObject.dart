import 'dart:async';
import 'package:sqflite/sqflite.dart';

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

  get database => null;

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
    final db =
        await database; // assuming you have a `database` object defined somewhere
    await db.insert(
      'signin',
      bookMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}