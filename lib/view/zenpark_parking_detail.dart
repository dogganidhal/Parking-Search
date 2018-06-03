import 'package:flutter/material.dart';
import 'package:parking_search/model/zenpark_search_result.dart';

class ZenparkParkingDetail extends StatelessWidget {

  final SearchResult searchResult;

  ZenparkParkingDetail(this.searchResult);

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Parking details')
        ),
        body: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new ListView(
            children: <Widget>[
              new Text(searchResult.parking.name, 
                textScaleFactor: 2.0, 
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(searchResult.parking.address, 
                style: new TextStyle(color: Colors.grey)
              ),
            ],
          ),
        ),
      );
    }

}