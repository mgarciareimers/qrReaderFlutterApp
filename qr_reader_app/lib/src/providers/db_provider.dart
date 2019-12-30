import 'dart:io';

import 'package:qr_reader_app/src/commons/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';
export 'package:qr_reader_app/src/models/scan_model.dart';

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

    return await initDB();
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
          'CREATE TABLE ${Constants.SCANS} ('
            '${Constants.ID} INTEGER PRIMARY KEY,'
            '${Constants.TYPE} TEXT,'
            '${Constants.VALUE} TEXT'
          ')'
        );
      }
    );
  }

  // Method that inserts a new row.
  insertScan(ScanModel scan) async {
    final db = await database;
    final result = await db.insert(Constants.SCANS, scan.toJson());

    return result;
  }
  
  // Method that gets a scan by id.
  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query(Constants.SCANS, where: '${Constants.ID} = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // Method that gets all scans.
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query(Constants.SCANS);

    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];

    return list;
  }

  // Method that gets all scans of a type.
  Future<List<ScanModel>> getAllScansByType(String type) async {
    final db = await database;
    final res = await db.query(Constants.SCANS, where: '${Constants.TYPE} = ?', whereArgs: [type]);

    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];

    return list;
  }

  // Update a scan.
  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final result = await db.update(Constants.SCANS, scan.toJson(), where: '${Constants.ID} = ?', whereArgs: [scan.id]);

    return result;
  }

  // Delete a scan.
  Future <int> deleteScan(int id) async {
    final db = await database;
    final result = await db.delete(Constants.SCANS, where: '${Constants.ID} = ?', whereArgs: [id]);

    return result;
  }

  // Delete all scans.
  Future <int> deleteAll() async {
    final db = await database;
    final result = await db.delete(Constants.SCANS);

    return result;
  }
}