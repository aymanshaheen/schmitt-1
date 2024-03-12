import 'package:schmitt/src/core/models/attachment_model.dart';
import 'package:schmitt/src/core/models/order_model.dart';

abstract class OrderDataSource {
  Future<OrderListModel> getOrders(String status);
  Future<void> updateOrder(String date, String addressId, int orderId);
  Future<String> cancleOrder(int orderId);
  Future<AttachmentModel> getAttachments(int orderId);
}
