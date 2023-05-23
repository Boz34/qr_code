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

  Future<Database> get database async {
    return openDatabase(
      'jdbc:mysql://db.triopt.de:3306/',
      version: 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eingang_datum': eingang.toIso8601String(),
      'ausgang_datum': ausgang.toIso8601String(),
      'adress': adress,
      'user_id': user_id,
      'user_id_ausgang': user_ausgang_id,
    };
  }

  Future<void> insertBook(Map<String, dynamic> bookMap) async {
    final db = await database;
    await db.insert(
      'signin', // Update the table name here
      bookMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
