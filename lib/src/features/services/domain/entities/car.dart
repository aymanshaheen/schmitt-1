import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

class CarEntity extends Equatable {
  final List<CarDataEntity>? data;
  final Meta? meta;

  const CarEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class CarShowEntity extends Equatable {
  final CarDataEntity? data;

  const CarShowEntity({
    this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}

class CarDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? plate;
  final Company? company;
  final Car? car;
  final ColorData? color;
  final String? createdAt;
  final String? createdAtFormatted;

  const CarDataEntity({
    this.id,
    this.name,
    this.plate,
    this.car,
    this.color,
    this.company,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        plate,
        company,
        car,
        color,
        createdAt,
        createdAtFormatted,
      ];
}
