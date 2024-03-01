import 'package:equatable/equatable.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';

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



