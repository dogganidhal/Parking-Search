import 'model/zenpark_parking.dart';

class ZenparkSearchResult extends Object {
  
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

  ZenparkSearchResult(
    this.address, this.hasShuttle, this.almostFull, this.publicId, 
    this.longitude, this.latitude, this.name, this.price, this.distance, 
    this.travelTime);

  static ZenparkSearchResult fromMap(Map map) {
    return new ZenparkSearchResult(
      map['Parking']['ParkingAddress'], map['HasShuttle'], map['ParkingAlmostFull'], 
      map['Parking']['PublicId'], map['Parking']['Coordinates']['Longitude'], 
      map['Parking']['Coordinates']['Latitude'], map['Parking']['ParkingName'], 
      map['Price'], map['Distance'], map['TravelTime']);
  }

}

/* This should be the right object */

class SearchResult {

  final double price;
  final double basePrice;
  final bool hasShuttle;
  final bool almostFull;
  final String discountText;
  final int distance;
  final int travelTime;
  final ZenparkParking parking;

  SearchResult(
    this.price, this.basePrice, this.hasShuttle, this.almostFull, 
    this.discountText, this.distance, this.travelTime, this.parking
  );

}