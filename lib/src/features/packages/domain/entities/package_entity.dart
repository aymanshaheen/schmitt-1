import 'package:equatable/equatable.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class PackagesEntity extends Equatable {
  final List<PackageDataEntity> data;

  const PackagesEntity({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class PackageEntity extends Equatable {
  final PackageDataEntity data;

  const PackageEntity({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class PackageDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? washesCount;
  final int? days;
  final int? price;
  final bool? hasDiscount;
  final int? discountPrice;
  final String? createdAt;
  final String? createdAtFormatted;
  final Authorize? authorize;

  const PackageDataEntity({
    this.id,
    this.name,
    this.description,
    this.washesCount,
    this.days,
    this.price,
    this.hasDiscount,
    this.discountPrice,
    this.createdAt,
    this.authorize,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        washesCount,
        days,
        price,
        hasDiscount,
        discountPrice,
        createdAt,
        authorize,
        createdAtFormatted
      ];
}
