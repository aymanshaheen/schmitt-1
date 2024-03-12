import 'package:schmitt/src/core/entities/attachments.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/orders/domain/repositories/home_repository.dart';

class GetAttachmentsUseCase {

 GetAttachmentsUseCase({required this.repository});
  final OrderRepository repository;


  ResultFuture<AttachmentsEntity> call(int orderId) {
    return repository.getAttachments(orderId);
  }
}

