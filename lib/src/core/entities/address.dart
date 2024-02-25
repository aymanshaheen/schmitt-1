import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final double locationLatitude;
  final double locationLongitude;
  final CityEntity city;
  final AreaEntity area;
  final String createdAt;
  final String createdAtFormatted;

  const AddressEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.city,
    required this.area,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        locationLatitude,
        locationLongitude,
        city,
        area,
        createdAt,
        createdAtFormatted
      ];
}
class CityEntity extends Equatable {
  final int id;
  final String name;

 const CityEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class AreaEntity extends Equatable {
  final int id;
  final String name;

 const AreaEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}