import 'dart:async';

import 'package:qr_reader_app/src/providers/db_provider.dart';
import 'package:qr_reader_app/src/bloc/validator.dart';

class ScansBloc with Validator{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Get Scans from Database.
    this.getAllScans();
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamGeo => _scansStreamController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansStreamController.stream.transform(validateHttp);

  dispose() {
    _scansStreamController?.close();
  }

  // Get all scans and update list.
  getAllScans() async {
    _scansStreamController.sink.add(await DBProvider.db.getAllScans());
  }

  // Insert a scan and update list.
  insertScan(ScanModel scan) async {
    await DBProvider.db.insertScan(scan);
    this.getAllScans();
  }

  // Delete a scan and update list.
  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    this.getAllScans();
  }

  // Delete all scans and update list.
  deleteAll() async {
    await DBProvider.db.deleteAll();
    this.getAllScans();
  }
}