import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

class CompanyModel extends CompanyEntity {
   CompanyModel({
    List<Company>? data,
    required Meta meta,
  }) : super(
          data: data ?? [],
          meta: meta ,
        );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      data: (json['data'] as List?)
          ?.map((i) => CompanyDataModel.fromJson(i as Map<String, dynamic>))
          .toList() ?? [],
      meta: 
           MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          ,
    );
  }
}

class CompanyDataModel extends Company {

  const CompanyDataModel({
    int? id,
    String? name,
    Media? media,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          media: media ,
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
        );

  factory CompanyDataModel.fromJson(Map<String, dynamic> json) {
    return CompanyDataModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      media: json['media'] != null
          ? MediaModel.fromJson(json['media'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String? ?? '',
      createdAtFormatted: json['created_at_formatted'] as String? ?? '',
    );
  }
}

class MediaModel extends Media {
  const MediaModel({
    int? id,
    String? url,
    String? preview,
    String? name,
    String? fileName,
    String? type,
    String? mimeType,
    int? size,
    String? humanReadableSize,
    String? status,
    int? progress,
  }) : super(

          id: id ?? 0,
          url: url ?? '',
          preview: preview ?? '',
          name: name ?? '',
          fileName: fileName ?? '',
          type: type ?? '',
          mimeType: mimeType ?? '',
          size: size ?? 0,
          humanReadableSize: humanReadableSize ?? '',
          status: status ?? '',
          progress: progress ?? 0,
        );

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] as int? ?? 0,
      url: json['url'] as String? ?? '',
      preview: json['preview'] as String? ?? '',
      name: json['name'] as String? ?? '',
      fileName: json['file_name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      mimeType: json['mime_type'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      humanReadableSize: json['human_readable_size'] as String? ?? '',
      status: json['status'] as String? ?? '',
      progress: json['progress'] as int? ?? 0,
    );
  }
}