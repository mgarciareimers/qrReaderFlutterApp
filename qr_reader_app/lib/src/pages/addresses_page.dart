import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/commons/utils.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';

class AddressesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getAllScans();

    return StreamBuilder<List<ScanModel>>(
      stream: this.scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(child: Text('No addresses have been found!'));
        }

        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Theme.of(context).primaryColor),
              child: ListTile(
                leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
                title: Text(scans[index].value),
                subtitle: Text('ID: ${scans[index].id}'),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () {
                  Utils.loadScanValue(context, scans[index]);
                },
              ),
              onDismissed: (direction) => this.scansBloc.deleteScan(scans[index].id),
            )
        );
      },
    );
  }
}
