import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class CompanyEntity extends Equatable {
  final List<Company>? data;
  final Meta? meta;

  const CompanyEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class Company extends Equatable {
  final int? id;
  final String? name;
  final Media? media;
  final String? createdAt;
  final String? createdAtFormatted;

  const Company({
    this.id,
    this.name,
    this.media,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [id, name, media, createdAt, createdAtFormatted];
}

class Media extends Equatable {
  final int? id;
  final String? url;
  final String? preview;
  final String? name;
  final String? fileName;
  final String? type;
  final String? mimeType;
  final int? size;
  final String? humanReadableSize;
  final String? status;
  final int? progress;

  const Media({
    this.id,
    this.url,
    this.preview,
    this.name,
    this.fileName,
    this.type,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.status,
    this.progress,
  });

  @override
  List<Object?> get props => [
        id,
        url,
        preview,
        name,
        fileName,
        type,
        mimeType,
        size,
        humanReadableSize,
        status,
        progress,
      ];
}
