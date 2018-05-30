import 'package:flutter/material.dart';

class ParkingListPage extends StatelessWidget {

  final searchResults;

  ParkingListPage(this.searchResults);

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.pink,
          title: new Text('Search Results'),
        ),
        body: new ListView.builder(
          itemBuilder: (listContext, index) {
            final searchResult = searchResults[index];
            return new Column(
              children: <Widget>[
                new ParkingCellWidget(searchResult)
              ],
            );
          },
          itemCount: searchResults.length,
        ),
      );
    }

}

class ParkingCellWidget extends StatelessWidget {

  final searchResult;

  ParkingCellWidget(this.searchResult);

  @override
    Widget build(BuildContext context) {
      return new Row(
        children: <Widget>[
          new Icon(Icons.place),
          new Column(
            children: <Widget>[
              new Text(searchResult.name),
              new Text(searchResult.address),
              new Text(searchResult.distance.toString()),
              new Text(searchResult.travelTime.toString()),
            ],
          ),
          new Center(
            child: new Text(searchResult.price.toString() + '\$'),
          )
        ],
      );
    }

}