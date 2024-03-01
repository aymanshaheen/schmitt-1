import 'package:schmitt/src/features/home/domain/entities/slides.dart';
import 'package:schmitt/src/features/services/data/model/company_model.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

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

