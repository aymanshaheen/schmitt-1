import 'dart:io';

import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';

abstract class TechRepository {
  ResultFuture<OrderListEntity> getOrders(String status);

  ResultFuture<OrderEntity> markAsStart(List<File>  image, String id);
  ResultFuture<OrderEntity> markAsComplete(List<File>  image, String id);
  ResultFuture<OrderEntity> markAsProgress( String id);

}
