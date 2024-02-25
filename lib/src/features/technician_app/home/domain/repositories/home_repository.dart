import 'dart:io';

import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';

abstract class TechRepository {
  ResultFuture<OrderEntity> getOrders(String status);

  ResultFuture<OrderEntity> markAsStart(File image, String id);
  ResultFuture<OrderEntity> markAsComplete(File image, String id);
  ResultFuture<OrderEntity> markAsProgress( String id);

}
