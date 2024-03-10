import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/orders/domain/repositories/home_repository.dart';

class GetOrdersUseCase {

  GetOrdersUseCase({required this.repository});
  final OrderRepository repository;


  ResultFuture<OrderListEntity> call(String status) {
    return repository.getOrders(status);
  }
}

