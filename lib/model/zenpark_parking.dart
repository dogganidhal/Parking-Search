

class ZenparkParking {

  final String publicId;
  final String descriptionHeader;
  final String id;
  final String name;
  final String address;

  final GeographicCoordinates coordinates;

  final List<String> photos;
  final List<ParkingAccessType> accessTypes;
  final List<VehicleType> vehicleTypes;
  final List<ParkingService> services;

  final Map<ParkingCharacteristic, Object> characteristics;

  ZenparkParking(
    this.publicId, this.id, this.descriptionHeader, this.name, this.address,
    this.coordinates, this.photos, this.accessTypes, this.vehicleTypes, 
    this.services, this.characteristics
  );
  
}

class GeographicCoordinates {

  final double longitude;
  final double latitude;

  GeographicCoordinates(this.longitude, this.latitude);

}

class ParkingService {

  final String name;
  final String information;
  final bool informationRequiredForReservation;
  final ParkingServiceInfoType type;
  final ParkingRequiredInformationType requiredInformationType;
  final ParkingServiceInfoCharge charge;

  ParkingService(
    this.name, this.information, this.informationRequiredForReservation, 
    this.type, this.requiredInformationType, this.charge
  );

}

class ParkingServiceInfoCharge {
  static const FREE = 1;
  static const FREE_UNDER_CONDITIONS = 2;
  static const PAID = 3;
}

class ParkingServiceInfoType {
  static const SHUTTLE = 0;
  static const VALET = 1;
}

class ParkingRequiredInformationType {
  static const TRAVEL = 0;
}

class ParkingAccessType {

  static const ZENPASS = 1;
  static const APPLICATION = 2;
  static const KEYPAD = 4;
  static const TICKET = 8;
  static const RECEPTIONNIST = 16;

}

class VehicleType {

  static const MOTO = 1;
  static const SMALL = 2;
  static const MEDIUM = 4;
  static const LARGE = 8;
  static const TALL = 16;
  static const VERY_TALL = 32;

}

class ParkingCharacteristic {

  static const GUARDED = 1;
  static const INDOOR = 2;
  static const LIGHTED = 4;
  static const MAXIMAL_HEIGHT = 8;
  static const UNDERGROUD = 16;
  static const VIDEO_SURVEILLANCE = 32;
  static const VALET = 64;
  static const PEDESTRIAN_FRIENDLY = 128;

}
