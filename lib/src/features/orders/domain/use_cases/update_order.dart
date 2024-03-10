import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/orders/domain/repositories/home_repository.dart';

class UpdateOrdersUseCase {

  UpdateOrdersUseCase({required this.repository});
  final OrderRepository repository;


  ResultFuture<void> call(String date, String addressId, int orderId) {
    return repository.updateOrder(date, addressId, orderId);
  }
}

