import 'package:schmitt/src/core/entities/meta.dart';

class MetaModel extends Meta {
  const MetaModel({
    required int currentPage,
    required int from,
    required int lastPage,
    required int perPage,
    required int to,
    required int total,
  }) : super(
          currentPage: currentPage,
          from: from,
          lastPage: lastPage,
          perPage: perPage,
          to: to,
          total: total,
        );

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}
