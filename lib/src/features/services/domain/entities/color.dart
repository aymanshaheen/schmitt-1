import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/data/model/company_model.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

class ColorEntity extends Equatable {
  final List<ColorData>? data;
  final Meta? meta;

  const ColorEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class ColorData extends Equatable {
  final int? id;
  final String? name;
  final Media? media;
  final String? createdAt;
  final String? createdAtFormatted;

  const ColorData({
    this.id,
    this.name,
    this.media,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [id, name, media, createdAt, createdAtFormatted];
}

class ColorModel extends ColorEntity {
  const ColorModel({
    List<ColorData>? data,
    Meta? meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      data: (json['data'] as List?)
          ?.map((i) => ColorDataModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ColorDataModel extends ColorData {
  const ColorDataModel({
    int? id,
    String? name,
    Media? media,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          media: media,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory ColorDataModel.fromJson(Map<String, dynamic> json) {
    return ColorDataModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      media: json['media'] != null
          ? MediaModel.fromJson(json['media'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }
}
