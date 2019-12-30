import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = new MapController();
  final mapTypes = ['streets', 'dark', 'light', 'outdoors', 'satellite'];

  int mapTypeIndex = 0;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Coordinates'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              this.mapController.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: this._createFlutterMap(scan),
      floatingActionButton: this._createFloatingActionButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: this.mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        this._createMapLayer(),
        this._createMarkersLayer(scan),
      ],
    );
  }

  _createMapLayer() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoibWdhcmNpYXJlaW1lcnMiLCJhIjoiY2s0cjByNzNvMGx2NjNpcDR2NHlyZmczYSJ9.GFW_tQV-_GJYXhjOScXuGQ',
        'id': 'mapbox.${this.mapTypes[this.mapTypeIndex]}', // streets, dark, light, outdoors, satellite
      }
    );
  }

  _createMarkersLayer(ScanModel scan) {
      return MarkerLayerOptions(
        markers: <Marker>[
          Marker(
            width: 100,
            height: 100,
            point: scan.getLatLng(),
            builder: (context) => Container(
              child: Icon(
                Icons.location_on,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
            )
          ),
        ]
      );
  }

  FloatingActionButton _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          this.mapTypeIndex++;

          if (this.mapTypeIndex >= this.mapTypes.length) {
            this.mapTypeIndex = 0;
          }
        });
      },
    );
  }
}
