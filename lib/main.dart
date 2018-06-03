import 'package:flutter/material.dart';
import 'package:zp_parking_search/view/zenpark_search_parkings.dart';

void main() => runApp(new ZenParkingSearchApp());

class ZenParkingSearchApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
    State<StatefulWidget> createState() {
      return new ZenparkSearchParkings();
    }
}