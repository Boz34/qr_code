import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'jdbc:mysql://db.triopt.de:3306/lager'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE signin(id INTEGER PRIMARY KEY, eingang_datum TEXT, ausgang_datum TEXT, adress TEXT, user_id INTEGER, user_id_ausgang INTEGER)',
        );
      },
      version: 1,
    );

    return _database!;
  }
}

class DataObject {
  final int id;
  final DateTime eingang;
  final DateTime ausgang;
  final String address;
  final int userId;
  final int userAusgangId;

  const DataObject({
    required this.id,
    required this.eingang,
    required this.ausgang,
    required this.address,
    required this.userId,
    required this.userAusgangId,
  });

  Future<void> insertBook() async {
    final db = await DatabaseProvider.instance.database;
    await db.insert(
      'signin',
      {
        'id': id,
        'eingang_datum': eingang.toIso8601String(),
        'ausgang_datum': ausgang.toIso8601String(),
        'address': address,
        'user_id': userId,
        'user_id_ausgang': userAusgangId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
