import 'package:schmitt/src/core/entities/meta.dart';

class MetaModel extends Meta {
  const MetaModel({
    int? currentPage,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
  }) : super(
          currentPage: currentPage ?? 0,
          from: from ?? 0,
          lastPage: lastPage ?? 0,
          perPage: perPage ?? 0,
          to: to ?? 0,
          total: total ?? 0,
        );

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] as int? ?? 0,
      from: json['from'] as int? ?? 0,
      lastPage: json['last_page'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
      to: json['to'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }
}