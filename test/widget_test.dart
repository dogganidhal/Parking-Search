// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:zp_parking_search/controller/zenpark_search_controller.dart';

void main() {
  test('Search controller', () async {

    List results = await ZenparkParkingSearchController.shared.performSearch(
      beginUTC: '2018-06-10 10:00',
      endUTC: '2018-06-12 10:00',
      address: 'Paris Demo'
    );

    print(results);
    
  });
}
