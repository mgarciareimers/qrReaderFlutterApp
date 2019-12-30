import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_reader_app/src/commons/constants.dart';

class Utils {
  // Method that loads a scan value.
  static loadScanValue(BuildContext context, ScanModel scan) {
    switch (scan.type) {
      case Constants.HTTP: _loadUrl(scan.value); break;
      case Constants.GEO: _loadMap(context, scan); break;
      default: break;
    }
  }

  // Method that loads an url.
  static _loadUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Method that loads a map.
  static _loadMap(BuildContext context, ScanModel scan) async {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}