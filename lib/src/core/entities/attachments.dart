import 'package:equatable/equatable.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';


class AttachmentsEntity extends Equatable {
  final List<ImageData>? start;
  final List<ImageData>? complete;

  const AttachmentsEntity({this.start, this.complete});

  @override
  List<Object?> get props => [start, complete];
}
