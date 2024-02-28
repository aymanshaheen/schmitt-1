import 'package:schmitt/src/features/home/domain/entities/slides.dart';

class SliderModel extends SliderEntity {
  const SliderModel({
    required List<Slide> data,
  }) : super(
          data: data,
        );

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      data: (json['data'] as List)
          .map((i) => SliderDataModel.fromJson(i))
          .toList(),
    );
  }
}

class SliderDataModel extends Slide {
  const SliderDataModel({
    required int id,
    required String title,
    required String link,
    required String color,
    required String type,
    required Media media,
  }) : super(
          id: id,
          title: title,
          link: link,
          color: color,
          type: type,
          media: media,
        );

  factory SliderDataModel.fromJson(Map<String, dynamic> json) {
    return SliderDataModel(
      id: json['id'],
      title: json['title'],
      link: json['link'],
      color: json['color'],
      type: json['type'],
      media: MediaModel.fromJson(json['media']),
    );
  }
}

class MediaModel extends Media {
  const MediaModel({
    required int id,
    required String url,
    required String preview,
    required String name,
    required String fileName,
    required String type,
    required String mimeType,
    required int size,
    required String humanReadableSize,
    required Details details,
    required String status,
    required int progress,
  }) : super(
          id: id,
          url: url,
          preview: preview,
          name: name,
          fileName: fileName,
          type: type,
          mimeType: mimeType,
          size: size,
          humanReadableSize: humanReadableSize,
          details: details,
          status: status,
          progress: progress,
        );

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      url: json['url'],
      preview: json['preview'],
      name: json['name'],
      fileName: json['file_name'],
      type: json['type'],
      mimeType: json['mime_type'],
      size: json['size'],
      humanReadableSize: json['human_readable_size'],
      details: DetailsModel.fromJson(json['details']),
      status: json['status'],
      progress: json['progress'],
    );
  }
}

class DetailsModel extends Details {
  const DetailsModel({
    required int width,
    required int height,
    required int ratio,
  }) : super(
          width: width,
          height: height,
          ratio: ratio,
        );

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      width: json['width'],
      height: json['height'],
      ratio: json['ratio'],
    );
  }
}

