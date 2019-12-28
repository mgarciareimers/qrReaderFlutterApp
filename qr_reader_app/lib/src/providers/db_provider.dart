import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();
  static final int version = 1;


  DBProvider._();

  // Method that returns the database.
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  // Method that initializes the database.
  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(
        path,
        version: version,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          // Create database tables.
          await db.execute(
            'CREATE TABLE Scans ('
              'id INTEGER PRIMARY KEY,'
              'type TEXT,'
              'value TEXT'
            ')'
          );
        });
  }
}