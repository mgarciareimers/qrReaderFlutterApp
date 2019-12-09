import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/pages/addresses_page.dart';
import 'package:qr_reader_app/src/pages/maps_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              // TODO.
            },
          )
        ],
      ),
      body: this._callPage(this._currentPageIndex),
      bottomNavigationBar: this._createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          this._scanQR();
        },
      ),
    );
  }

  // Method that returns the page.
  Widget _callPage(int currentPage) {
    switch(currentPage) {
      case 0: return MapsPage();
      case 1: return AddressesPage();
      default: return MapsPage();
    }
  }

  // Method that creates the bottom navigation bar.
  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: this._currentPageIndex,
      onTap: (int newIndex) {
        this.setState(() {
          this._currentPageIndex = newIndex;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Addresses'),
        ),
      ],
    );
  }

  // Method that opens the scan.
  _scanQR() async {
    String futureString = '';

    try {
      futureString = await new QRCodeReader().scan();
    } catch(e) {
      futureString = e.toString();
    }

    // TODO - Delete.
    futureString = 'https://magocodeapps.com';
    //futureString = 'geo:40.42381951269892,-3.7030543371093927';

    print('futureString: $futureString');

    if (futureString != null) {
      print('We have information');
    }
  }
}
