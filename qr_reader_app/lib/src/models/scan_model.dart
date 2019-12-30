import 'package:qr_reader_app/src/commons/constants.dart';

import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    if (this.value.contains(Constants.HTTP)) {
      this.type = Constants.HTTP;
    } else if (this.value.contains(Constants.GEO)){
      this.type = Constants.GEO;
    } else {
      this.type = '';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json[Constants.ID],
    type: json[Constants.TYPE],
    value: json[Constants.VALUE],
  );

  Map<String, dynamic> toJson() => {
    Constants.ID: id,
    Constants.TYPE: type,
    Constants.VALUE: value,
  };

  // Method that gets latitude and longitude.
  LatLng getLatLng() {
    if (type != Constants.GEO) {
      return null;
    }

    final latLng = value.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }
}