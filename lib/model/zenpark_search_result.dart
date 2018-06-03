import 'package:meta/meta.dart';
import 'package:zp_parking_search/model/zenpark_parking.dart';

class SearchResult {

  final double price;
  final double basePrice;
  final bool hasShuttle;
  final bool almostFull;
  final String discountText;
  final int distance;
  final int travelTime;
  final ZenparkParking parking;

  SearchResult({
    @required this.price, this.basePrice, @required this.hasShuttle, 
    @required this.almostFull, this.discountText, @required this.distance, 
    @required this.travelTime, @required this.parking
  });

  SearchResult.fromAPIMap(Map map) : 
    price = map['Price'], basePrice = map['BasePrice'], 
    hasShuttle = map['HasShuttle'], almostFull = map['ParkingAlmostFull'],
    discountText = map['DiscountText'], travelTime = map['TravelTime'],
    distance = map['Distance'], 
    parking = ZenparkParking.fromAPIMap(map['Parking']);

}