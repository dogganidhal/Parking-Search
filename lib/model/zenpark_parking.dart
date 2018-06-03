
class ZenparkParking {

  final String publicId;
  final String descriptionHeader;
  final String id;
  final String name;
  final String address;

  final GeographicCoordinates coordinates;

  final List photos;
  final int accessTypes;
  final int vehicleTypes;
  
  final List<ParkingService> services;
  final List<ParkingCharacteristic> characteristics;

  ZenparkParking.fromAPIMap(Map map) : 
    publicId = map['PublicId'], descriptionHeader = map['DescriptionHeader'],
    coordinates = GeographicCoordinates.fromAPIMap(map['Coordinates']),
    accessTypes = map['AccessTypes'], vehicleTypes = map['VehicleTypes'],
    photos = map['Photos'], id = map['ParkingId'], name = map['ParkingName'],
    address = map['ParkingAddress'], 
    services = ParkingService.servicesFromAPIMap(map['Services']),
    characteristics = ParkingCharacteristic.characteristicsFromAPIMap(map['ParkingCharacteristics']);
  
}

class GeographicCoordinates {

  final double longitude;
  final double latitude;

  GeographicCoordinates.fromAPIMap(Map map) :
    longitude = map['Longitude'], latitude = map['Latitude'];

}

class ParkingService {

  final String name;
  final String information;
  final bool informationRequiredForReservation;
  final int type;
  final int requiredInformationType;
  final int charge;

  ParkingService.fromAPIMap(Map map) :
    name = map['Name'], requiredInformationType = map['RequiredInformationType'],
    type = map['Type'], informationRequiredForReservation = map['InformationRequiredForReservation'],
    charge = map['Charge'], information = map['Information'];

  static List<ParkingService> servicesFromAPIMap(List list) {
    List<ParkingService> services = [];
    for (final item in list) {
      services.add(new ParkingService.fromAPIMap(item));
    }
    return services;
  }

}

class ParkingCharacteristic {

  final int key;
  final dynamic value;

  ParkingCharacteristic.fromAPIMap(Map map) : key = map['Key'], value = map['Value'];

  static List<ParkingCharacteristic> characteristicsFromAPIMap(List list) {
    List<ParkingCharacteristic> characteristics = [];
    for (final item in list) {
      characteristics.add(new ParkingCharacteristic.fromAPIMap(item));
    }
    return characteristics;
  }

}