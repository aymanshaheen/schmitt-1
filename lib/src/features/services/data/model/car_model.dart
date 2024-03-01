import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';

class CarsModel extends CarEntity {
  const CarsModel({
    List<CarDataEntity>? data,
    Meta? meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    return CarsModel(
      data: ((json['data'] as List?)
              ?.map((i) => CarDataModel.fromJson(i as Map<String, dynamic>))
              .toList()) ??
          [],
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CarDataModel extends CarDataEntity {
  const CarDataModel({
    int? id,
    String? name,
    String? plate,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          plate: plate,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory CarDataModel.fromJson(Map<String, dynamic> json) {
    return CarDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      plate: json['plate'] as String?,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }
}
