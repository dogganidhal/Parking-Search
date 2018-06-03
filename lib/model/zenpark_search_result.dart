import 'package:parking_search/model/zenpark_parking.dart';

class SearchResult {

  final double price;
  final double basePrice;
  final bool hasShuttle;
  final bool almostFull;
  final String discountText;
  final int distance;
  final int travelTime;
  final ZenparkParking parking;

  SearchResult.fromAPIMap(Map map) : 
    price = map['Price'], basePrice = map['BasePrice'], 
    hasShuttle = map['HasShuttle'], almostFull = map['ParkingAlmostFull'],
    discountText = map['DiscountText'], travelTime = map['TravelTime'],
    distance = map['Distance'], 
    parking = ZenparkParking.fromAPIMap(map['Parking']);

}