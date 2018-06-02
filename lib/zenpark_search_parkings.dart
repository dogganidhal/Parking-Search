import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'main.dart';
import 'date_time_picker.dart';

class ZenparkSearchParkings extends State<HelloWorldApp> {

  final formatter = new DateFormat('yyyy-MM-dd HH:mm');
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = new GlobalKey();
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
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Zenpark parkings search'),
          ),
          body: new Center(
            child: isLoading ? new CircularProgressIndicator() : _buildBodyWidget(context),
          ),
        ),
      );
    }

  Widget _buildBodyWidget(BuildContext context) {
    return new Builder(
      builder: (BuildContext nestedContext) {
        return new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Form(
            key: _formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
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
                        showDateTimePicker(nestedContext, new DateTime.now()).then((pickedDateTime) {

                          field.controller.text = formatter.format(pickedDateTime);
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
                          minimumDateTime = formatter.parse(startDateField.controller.text);
                          minimumDateTime = new DateTime(
                            minimumDateTime.year,
                            minimumDateTime.month,
                            minimumDateTime.day
                          );
                        } else {
                          minimumDateTime = new DateTime.now();
                        }
                        showDateTimePicker(nestedContext, minimumDateTime).then((pickedDateTime) {
                          field.controller.text = formatter.format(pickedDateTime);
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
                    child: new Text('Search', textScaleFactor: 2.0,),
                    onPressed: () {
                      setState(() {
                        isLoading = true;                       
                      });
                      _searchParkings(nestedContext);
                    }
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _searchParkings(BuildContext context) {
    print('Looking for parkings');
  }

}