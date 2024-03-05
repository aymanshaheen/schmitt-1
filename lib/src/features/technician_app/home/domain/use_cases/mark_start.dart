import 'dart:io';

import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/technician_app/home/domain/repositories/home_repository.dart';

class MarkAsStartUseCase {

  MarkAsStartUseCase({required this.repository});
  final TechRepository repository;


  ResultFuture<OrderEntity> call(List<File>  image, String id) {
    return repository.markAsStart(image, id);
  }
}

