import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_reader_app/src/pages/maps_page.dart';
import 'package:qr_reader_app/src/pages/addresses_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._createAppBar(),
      body: this._loadPage(this._currentIndex),
      bottomNavigationBar: this._createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: this._createFloatingActionButton(),
    );
  }

  // Method that creates the app bar.
  Widget _createAppBar() {
    return AppBar(
      title: Text('QR Scanner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {

          },
        ),
      ],
    );
  }

  // Method that loads the page.
  Widget _loadPage(int currentIndex) {
    switch(currentIndex) {
      case 0: return MapsPage();
      case 1: return AddressesPage();
      default: return MapsPage();
    }
  }

  // Method that creates the bottom navigation bar.
  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: this._currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Addresses'),
        )
      ],
      onTap: (int index) {
        this.setState(() => this._currentIndex = index);
      }
    );
  }

  // Method that creates the floating action button.
  Widget _createFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: _scanQR,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  // Method that opens the qr scanner.
  _scanQR() async {
    String futureString = '';

    try {
      futureString = await BarcodeScanner.scan();
    } catch(e) {
      futureString = e.toString();
    }

    print(futureString);
  }
}
