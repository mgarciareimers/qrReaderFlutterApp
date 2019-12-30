import 'dart:async';

import 'package:qr_reader_app/src/commons/constants.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

class Validator {
  final validateGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
      handleData: (scans, sink) {
        final geoScans = scans.where((scan) => scan.type == Constants.GEO).toList();
        sink.add(geoScans);
      }
  );

  final validateHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
      handleData: (scans, sink) {
        final geoScans = scans.where((scan) => scan.type == Constants.HTTP).toList();
        sink.add(geoScans);
      }
  );
}