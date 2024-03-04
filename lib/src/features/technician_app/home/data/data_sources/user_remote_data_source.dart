import 'dart:io';

import 'package:schmitt/src/core/models/order_model.dart';


abstract class TechRemoteDataSource {
  Future<OrderListModel> getOrders(String status);

  Future<OrderModel> markAsStart(File image,String id);
  Future<OrderModel> markAsComplete(File image,String id);
  Future<OrderModel> markAsProgress(String id);

}
