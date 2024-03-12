
import 'package:schmitt/src/core/entities/attachments.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';

abstract class OrderRepository {
  ResultFuture<OrderListEntity> getOrders(String status);
  ResultFuture<void> updateOrder(String date, String addressId, int orderId);
  ResultFuture<String> cancleOrder(int id);
  ResultFuture<AttachmentsEntity> getAttachments(int id);

}
