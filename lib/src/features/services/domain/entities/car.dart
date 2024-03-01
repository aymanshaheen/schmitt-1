import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class CarEntity extends Equatable {
  final List<CarDataEntity>? data;
  final Meta? meta;

  const CarEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class CarDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? plate;
  final String? createdAt;
  final String? createdAtFormatted;

  const CarDataEntity({
    this.id,
    this.name,
    this.plate,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        plate,
        createdAt,
        createdAtFormatted,
      ];
}