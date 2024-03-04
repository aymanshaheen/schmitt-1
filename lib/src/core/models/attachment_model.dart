import 'package:schmitt/src/core/entities/attachments.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class AttachmentModel extends AttachmentsEntity {
  const AttachmentModel({
    required List<ImageData> start,
    required List<ImageData> complete,
  }) : super(
          start: start,
          complete: complete,
        );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
        start: (json['starting_media'] as List?)
                ?.map((i) => ImageModel.fromJson(i as Map<String, dynamic>))
                .toList() ??
            [],
       complete: (json['completed_media'] as List?)
                ?.map((i) => ImageModel.fromJson(i as Map<String, dynamic>))
                .toList() ??
            [],);
  }
}