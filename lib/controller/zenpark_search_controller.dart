import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parking_search/model/zenpark_search_result.dart';

class ZenparkParkingSearchController {

  static const ZenparkParkingSearchController shared = const ZenparkParkingSearchController();

  const ZenparkParkingSearchController();

  Future<List<SearchResult>> performSearch({
    String beginUTC, String endUTC, String address
  }) async {
    Completer<List<SearchResult>> completer = new Completer<List<SearchResult>>();

    const url = 'https://zenithmobileapi.azurewebsites.net/v1/search/reservation';
    final response = await http.post(url, body: json.encode({
      'BeginDateUtc': beginUTC,
      'EndDateUtc': endUTC,
      'location': {
        'Address': address
      },
      'VehicleTypes': 1
    }), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });

    final items = json.decode(response.body)['Items'];
    List<SearchResult> results = [];

    if (items.length > 0) {
      for (final item in items) {
        results.add(new SearchResult.fromAPIMap(item));
      }
    }

    completer.complete(results);

    return completer.future;
  }

}