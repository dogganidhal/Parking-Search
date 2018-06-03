import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_search/view/zenpark_parking_list.dart';
import 'package:parking_search/controller/zenpark_search_controller.dart';
import 'package:parking_search/view/date_time_picker.dart';

class ParkingSearchApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
    State<StatefulWidget> createState() {
      return new ZenparkSearchParkings();
    }
}

class ZenparkSearchParkings extends State<ParkingSearchApp> {

  final _formatter = new DateFormat('yyyy-MM-dd HH:mm');
  bool _isLoading = false;

  final GlobalKey<FormState> _locationFieldKey = new GlobalKey();
  final GlobalKey<FormState> _startDateFieldKey = new GlobalKey();
  final GlobalKey<FormState> _endDateFieldKey = new GlobalKey();
  
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'Zenpark parkings search',
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.pink,
          accentColor: Colors.pinkAccent,
        ),
        home: new Builder(
          builder: (concreteContext) {
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Zenpark parkings search'),
              ),
              body: new Center(
                child: _isLoading ? new CircularProgressIndicator() : _buildBodyWidget(concreteContext),
              ),
            );
          },
        ),
      );
    }

  Widget _buildBodyWidget(BuildContext concreteContext) {
    return new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          children: <Widget>[
            new TextFormField(
              key: _locationFieldKey,
              controller: new TextEditingController(),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                icon: new Icon(Icons.place),
                hintText: 'ex: Louvre museum, Eiffel tower',
                labelText: 'Location'
              ),
            ),
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    key: _startDateFieldKey,
                    controller: new TextEditingController(),
                    keyboardType: TextInputType.datetime,
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.timer),
                      labelText: 'Start time'
                    )
                  ),
                ),
                new IconButton(
                  color: Colors.pink,
                  icon: new Icon(Icons.calendar_today),
                  onPressed: () {
                    final TextFormField field = _startDateFieldKey.currentWidget;
                    showDateTimePicker(concreteContext, new DateTime.now()).then((pickedDateTime) {
                      field.controller.text = _formatter.format(pickedDateTime);
                    });
                  },
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    key: _endDateFieldKey,
                    controller: new TextEditingController(),
                    keyboardType: TextInputType.datetime,
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.timer_off),
                      labelText: 'End time'
                    )
                  ),
                ),
                new IconButton(
                  color: Colors.pink,
                  icon: new Icon(Icons.calendar_today),
                  onPressed: () {
                    final TextFormField field = _endDateFieldKey.currentWidget;
                    DateTime minimumDateTime;
                    final TextFormField startDateField = _startDateFieldKey.currentWidget;
                    if (startDateField.controller.text.length > 0) {
                      minimumDateTime = _formatter.parse(startDateField.controller.text);
                      minimumDateTime = new DateTime(
                        minimumDateTime.year,
                        minimumDateTime.month,
                        minimumDateTime.day
                      );
                    } else {
                      minimumDateTime = new DateTime.now();
                    }
                    showDateTimePicker(concreteContext, minimumDateTime).then((pickedDateTime) {
                      field.controller.text = _formatter.format(pickedDateTime);
                    });
                  },
                )
              ],
            ),
            new Container(
              height: 48.0,
              margin: new EdgeInsets.only(top: 16.0),
              child: new MaterialButton(
                color: Colors.pink,
                textColor: Colors.white,
                child: new Text('Search', textScaleFactor: 1.33,),
                onPressed: () {
                  setState(() {
                    _isLoading = true;                       
                  });
                  _searchParkings(concreteContext);
                }
              )
            )
          ],
        ),
      ),
    );
  }

  void _searchParkings(BuildContext concreteContext) async {
    final TextFormField startDateField = _startDateFieldKey.currentWidget;
    final TextFormField endDateField = _endDateFieldKey.currentWidget;
    final TextFormField locationField = _locationFieldKey.currentWidget;

    List results = await
    ZenparkParkingSearchController.shared.performSearch(
      beginUTC: startDateField.controller.text,
      endUTC: endDateField.controller.text,
      address: locationField.controller.text
    );

    Navigator.push(concreteContext, new MaterialPageRoute(
      builder: (context) => new ZenparkParkingList(
        searchResults: results,
        beginUTC: startDateField.controller.text,
        endUTC: endDateField.controller.text,
      )
    ));

    setState(() {
       _isLoading = false;   
    });
  }

}