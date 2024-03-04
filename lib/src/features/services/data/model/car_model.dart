import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/features/services/data/model/company_model.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

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

class CarsShowModel extends CarShowEntity {
  const CarsShowModel({
    CarDataEntity? data,
  }) : super(
          data: data,
        );

  factory CarsShowModel.fromJson(Map<String, dynamic> json) {
    return CarsShowModel(
      data: json['data'] != null
          ? CarDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CarDataModel extends CarDataEntity {
  const CarDataModel({
    int? id,
    String? name,
    String? plate,
    Company? company,
    Car? car,
    ColorData? color,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          plate: plate,
          company: company,
          car: car,
          color: color,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory CarDataModel.fromJson(Map<String, dynamic> json) {
    return CarDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      plate: json['plate'] as String?,
      company: json['company'] != null
          ? CompanyDataModel.fromJson(json['company'] as Map<String, dynamic>)
          : null,
      car: json['car_model'] != null
          ? CarModel.fromJson(json['car_model'] as Map<String, dynamic>)
          : null,
      color: json['color'] != null
          ? ColorDataModel.fromJson(json['color'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }
}
