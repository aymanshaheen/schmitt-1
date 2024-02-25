import 'package:schmitt/src/core/entities/address.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required int id,
    required String name,
    required String address,
    required double locationLatitude,
    required double locationLongitude,
    required CityEntity city,
    required AreaEntity area,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          address: address,
          locationLatitude: locationLatitude,
          locationLongitude: locationLongitude,
          city: city,
          area: area,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      locationLatitude: json['location_latitude'],
      locationLongitude: json['location_longitude'],
      city: CityModel.fromJson(json['city']),
      area: AreaModel.fromJson(json['area']),
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}

class CityModel extends CityEntity {
  const CityModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class AreaModel extends AreaEntity {
  const AreaModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      name: json['name'],
    );
  }
}