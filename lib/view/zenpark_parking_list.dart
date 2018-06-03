import 'package:flutter/material.dart';
import 'package:parking_search/model/zenpark_search_result.dart';
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
        body: searchResults.length == 0 ? 
        new Center(
          child: new Text('No parkings found')
        ) :
        new Builder(
          builder: (concreteContext) {
            return new Column(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('\$BEGIN'),
                      new Container(
                        child: new Icon(Icons.chevron_right, color: Colors.pink,),
                        margin: new EdgeInsets.only(left: 16.0, right: 16.0),
                      ),
                      new Text('\$END')
                    ],
                  ),
                ),
                new Flexible(
                  child: new ListView.builder(
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
                  ),
                )
              ],
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
              leading: const Icon(Icons.image, color: Colors.black45,),
              trailing: new Text('$price €', style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink
                ),
              ),
              title: new Text(searchResult.parking.name, style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0
                ),
              ),
              subtitle: new Text(searchResult.parking.address, style: new TextStyle(
                  fontSize: 12.0
                ),
              ),
            ), 
          ],
        ),
      );
    }
}