import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'destination.dart';

class ZenparkSearchParkings extends State<HelloWorldApp> {

  bool _isLoading = false;

  final TextFormField _startDateTextField = new TextFormField(
    decoration: InputDecoration(
      hintText: 'Start time',
      labelText: 'Start',
      icon: const Icon(Icons.timer)
    ),
    enabled: false,
    controller: new TextEditingController(),
  );

  final TextFormField _endDateTextField = new TextFormField(
    decoration: InputDecoration(
      hintText: 'End time',
      labelText: 'End',
      icon: const Icon(Icons.timer_off)
    ),
    enabled: false,
    controller: new TextEditingController(),
  );

  final TextFormField _locationTextField = new TextFormField(
    decoration: const InputDecoration(
      icon: const Icon(Icons.my_location),
      hintText: 'ex: Louvre museum, Eiffel tower ...',
      labelText: 'Location'
    ),
    controller: new TextEditingController(),
  );
  
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        color: Colors.pink,
        home: new Builder(
          builder: (BuildContext nestedContext) {
            return  new Scaffold(
              appBar: new AppBar(
                title: new Text('Search Parkings'),
                backgroundColor: Colors.pink,
              ),
              body: _isLoading ? new Center(
                child: new CircularProgressIndicator(),
              ) : new Form(
                child: new ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    _locationTextField,
                    new InkWell(
                      child: _startDateTextField,
                      onTap: () {
                        showDatePicker(
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          context: nestedContext
                        ).then((startDate) {
                          showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: nestedContext
                          ).then((startTime) {
                            _populateStartDateTime(startDate, startTime);
                          });
                        });
                      },
                    ),
                    new InkWell(
                      child: _endDateTextField,
                      onTap: () {
                        showDatePicker(
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          context: nestedContext
                        ).then((endDate) {
                          showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: nestedContext
                          ).then((endTime) {
                            _populateEndDateTime(endDate, endTime);
                          });
                        });
                      },
                    ),
                    new Container(
                      child: new MaterialButton(
                        child: new Text('Search', textScaleFactor: 1.33,),
                        color: Colors.pink,
                        textColor: Colors.white,
                        height: 48.0,
                        onPressed: () {
                          setState(() {
                            _isLoading = true;                    
                          });
                          _searchParkings(nestedContext);
                        },
                      ),
                      margin: const EdgeInsets.only(top: 16.0),
                    )
                  ],
                ),
              )
            );
          },
        )
      );
    }

  void _searchParkings(concreteContext) async {
    print('looking for parkings ...');
    final url = 'https://zenithmobileapi.azurewebsites.net/v1/search/reservation';
    final response = await http.post(url, body: json.encode({
      'BeginDateUtc': _startDateTextField.controller.text,
      'EndDateUtc': _endDateTextField.controller.text,
      'location': {
        'Address': _locationTextField.controller.text
      },
      'VehicleTypes': 1
    }), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    final map = json.decode(response.body);
    var searchResults = [];
    for (var item in map['Items']) {
      searchResults.add(SearchResult.fromMap(item));
    }
    Navigator.push(
      concreteContext, 
      new MaterialPageRoute(
        builder: (context) => new ParkingListPage(searchResults)
      )
    );
    setState(() {
      _isLoading = false;   
    });
  }

  void _populateStartDateTime(DateTime date, TimeOfDay time) {
    DateTime preciseDate = DateTime(date.year, date.month, date.day, time.hour, time.minute); 
    print('Start time: ' + preciseDate.toString());
    _startDateTextField.controller.text = preciseDate.toString();
  }

  void _populateEndDateTime(DateTime date, TimeOfDay time) {
    DateTime preciseDate = DateTime(date.year, date.month, date.day, time.hour, time.minute); 
    print('End time: ' + preciseDate.toString());
    _endDateTextField.controller.text = preciseDate.toString();
  }

}

class SearchResult {
  
  final double price;
  final bool hasShuttle;
  final bool almostFull;
  final String publicId;
  final double longitude;
  final double latitude;
  final String name;
  final String address;
  final int distance;
  final int travelTime;

  SearchResult(
    this.address, this.hasShuttle, this.almostFull, this.publicId, 
    this.longitude, this.latitude, this.name, this.price, this.distance, 
    this.travelTime);

  static SearchResult fromMap(Map map) {
    return new SearchResult(
      map['Parking']['ParkingAddress'], map['HasShuttle'], map['ParkingAlmostFull'], 
      map['Parking']['PublicId'], map['Parking']['Coordinates']['Longitude'], 
      map['Parking']['Coordinates']['Latitude'], map['Parking']['ParkingName'], 
      map['Price'], map['Distance'], map['TravelTime']);
  }

}