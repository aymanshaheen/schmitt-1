import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/orders/domain/repositories/home_repository.dart';

class CancleOrdersUseCase {

 CancleOrdersUseCase({required this.repository});
  final OrderRepository repository;


  ResultFuture<String> call(int orderId) {
    return repository.cancleOrder(orderId);
  }
}

