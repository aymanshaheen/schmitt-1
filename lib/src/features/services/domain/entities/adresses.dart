import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class AddressEntity extends Equatable {
  final List<Address> data;
  final Meta meta;

  const AddressEntity({required this.data, required this.meta});

  @override
  List<Object> get props => [data, meta];
}

class Address extends Equatable {
  final int id;
  final String name;
  final String address;
  final double locationLatitude;
  final double locationLongitude;
  final String? city;
  final String? area;
  final String createdAt;
  final String createdAtFormatted;

  const Address({
    required this.id,
    required this.name,
    required this.address,
    required this.locationLatitude,
    required this.locationLongitude,
    this.city,
    this.area,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props =>
      [id, name, address, locationLatitude, locationLongitude, city, area, createdAt, createdAtFormatted];
}

class City extends Equatable {
  final int id;
  final String name;

  const City({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class Area extends Equatable {
  final int id;
  final String name;

  const Area({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}