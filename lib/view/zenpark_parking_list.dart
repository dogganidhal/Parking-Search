import 'package:flutter/material.dart';
import 'package:zp_parking_search/model/zenpark_search_result.dart';
import 'zenpark_parking_detail.dart';

class ZenparkParkingList extends StatelessWidget {

  final List<SearchResult> searchResults;

  ZenparkParkingList(this.searchResults);

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Search Results'),
        ),
        body: new Builder(
          builder: (concreteContext) {
            return new ListView.builder(
              itemBuilder: (listContext, index) {
                final SearchResult searchResult = searchResults[index];
                return new FlatButton(
                  padding: const EdgeInsets.all(0.0),
                  child: new ParkingCellWidget(searchResult),
                  onPressed: () {
                    Navigator.push(concreteContext, new MaterialPageRoute(
                      builder: (context) => new ZenparkParkingDetail(searchResult),
                    ));
                  },
                );
              },
              itemCount: searchResults.length,
            );
          },
        ),
      );
    }
}

class ParkingCellWidget extends StatelessWidget {

  final SearchResult searchResult;

  ParkingCellWidget(this.searchResult);

  @override
    Widget build(BuildContext context) {
      final price = searchResult.price;
      return new Card(
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.image),
              trailing: new Text('$price €'),
              title: new Text(searchResult.parking.name),
              subtitle: new Text(searchResult.parking.address),
            ), 
          ],
        ),
      );
    }
}