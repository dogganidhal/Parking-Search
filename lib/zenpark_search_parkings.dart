import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

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
  );
  
  @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Search Parkings'),
            backgroundColor: Colors.pink,
          ),
          body: _isLoading ? new CircularProgressIndicator() 
                          : new Form(
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
                      context: context
                    ).then((startDate) {
                      showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context
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
                      context: context
                    ).then((endDate) {
                      showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context
                      ).then((endTime) {
                        _populateEndDateTime(endDate, endTime);
                      });
                    });
                  },
                ),
                new Container(
                  child: new MaterialButton(
                    child: new Text('Search'),
                    color: Colors.pink,
                    textColor: Colors.white,
                    height: 48.0,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;                    
                      });
                      _searchParkings();
                    },
                  ),
                  margin: const EdgeInsets.only(top: 16.0),
                )
              ],
            ),
          )
        ),
      );
    }

  void _searchParkings() async {
    print('looking for parkings ...');
    var url = 'https://dev.zenpark.com/api/v2/account/signin';
    var response = await http.post(url, body: {'username': 'nidhal', 'password': 'A68f73n96@'});
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      final token = map['result'];
      print('token: $token');
      url = 'https://dev.zenpark.com/api/v2/parkings/list';
      response = await http.get(url, headers: {'Zenpark-Authtoken': token});
      map = json.decode(response.body);
      print('parkings: $map');
    } else {
      print('$response.statusCode: Can\'t get token');
    }
    setState(() {
      _isLoading = false;   
    });
  }

  void _populateStartDateTime(DateTime date, TimeOfDay time) {
    DateTime preciseDate = DateTime(date.year, date.month, date.day, time.hour, time.minute); 
    print('time is: ' + preciseDate.toString());
    _startDateTextField.controller.text = preciseDate.toString();
  }

  void _populateEndDateTime(DateTime date, TimeOfDay time) {
    DateTime preciseDate = DateTime(date.year, date.month, date.day, time.hour, time.minute); 
    print('time is: ' + preciseDate.toString());
    _endDateTextField.controller.text = preciseDate.toString();
  }

  void displayParkings(mapObject) {

  }

  _Coordinates getCurrentLocation() {
    // ACCES TOKEN: pk.eyJ1IjoibmlkaGFsenAiLCJhIjoiY2podDR6MnZqMDk4cDNrbnZidWIwdmx6eCJ9.44ydpUyBpElkm2xUmgDG8w
    return new _Coordinates(0.0, 0.0);
  }

}

class _Coordinates {
  final double longitude;
  final double latitude;    
  _Coordinates(this.latitude, this.longitude);
}