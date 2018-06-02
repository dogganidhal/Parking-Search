import 'package:flutter/material.dart';
import 'zenpark_search_result.dart';

class ZenparkParkingDetail extends StatelessWidget {

  final ZenparkSearchResult searchResult;

  ZenparkParkingDetail(this.searchResult);

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(searchResult.name)
        ),
        body: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new ListView(
            children: <Widget>[
              new Text(searchResult.name, 
                textScaleFactor: 2.0, 
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(searchResult.address, 
                style: new TextStyle(color: Colors.grey)
              ),
            ],
          ),
        ),
      );
    }

}