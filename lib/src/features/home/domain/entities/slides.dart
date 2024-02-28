import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final List<Slide> data;

  const SliderEntity({required this.data});

  @override
  List<Object> get props => [data];
}

class Slide extends Equatable {
  final int id;
  final String title;
  final String link;
  final String color;
  final String type;
  final Media media;

  const Slide({
    required this.id,
    required this.title,
    required this.link,
    required this.color,
    required this.type,
    required this.media,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        link,
        color,
        type,
        media,
      ];
}

class Media extends Equatable {
  final int id;
  final String url;
  final String preview;
  final String name;
  final String fileName;
  final String type;
  final String mimeType;
  final int size;
  final String humanReadableSize;
  final Details details;
  final String status;
  final int progress;

  const Media({
    required this.id,
    required this.url,
    required this.preview,
    required this.name,
    required this.fileName,
    required this.type,
    required this.mimeType,
    required this.size,
    required this.humanReadableSize,
    required this.details,
    required this.status,
    required this.progress,
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
        details,
        status,
        progress,
      ];
}

class Details extends Equatable {
  final int width;
  final int height;
  final int ratio;

  const Details({
    required this.width,
    required this.height,
    required this.ratio,
  });

  @override
  List<Object?> get props => [width, height, ratio];
}



