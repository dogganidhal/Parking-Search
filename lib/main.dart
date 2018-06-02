import 'package:flutter/material.dart';
import 'zenpark_search_parkings.dart';

void main() => runApp(new HelloWorldApp());

class HelloWorldApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
    State<StatefulWidget> createState() {
      return new ZenparkSearchParkings();
    }
}