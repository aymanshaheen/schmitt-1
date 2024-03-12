import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/cancle_orders.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/get_attachments.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/get_orders.dart';
import 'package:schmitt/src/features/orders/domain/use_cases/update_order.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_state.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class BookingCubit extends Cubit<BookingStates> {
  final GetOrdersUseCase getOrdersUseCase;
  final CancleOrdersUseCase cancleOrdersUseCase;
  final UpdateOrdersUseCase updateOrdersUseCase;
  final GetAttachmentsUseCase getAttachmentsUseCase;
  BookingCubit({
    required this.getOrdersUseCase,
    required this.cancleOrdersUseCase,
    required this.getAttachmentsUseCase,
    required this.updateOrdersUseCase,
  }) : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);
  List<Order> myOrders = [];

  Future<void> getMyOrders(String status) async {
    emit(OrderLoading());

    final result = await getOrdersUseCase.call(status);

    result.fold(
      (failure) {
        emit(OrderFailure(
          message: failure.message,
        ));
      },
      (user) {
        myOrders.clear();
        myOrders = user.data!;
        emit(OrderSuccess(user.data!));
      },
    );
  }

  List<Order> recentOrder = [];

  Future<void> getRecentOrders(String status) async {
    emit(OrderLoading());

    final result = await getOrdersUseCase.call(status);

    result.fold(
      (failure) {
        emit(OrderFailure(
          message: failure.message,
        ));
      },
      (user) {
        recentOrder += user.data!;
        emit(OrderSuccess(user.data!));
      },
    );
  }

  Future<void> updateOrder(String date, String addressId, int orderId) async {
    emit(UpdateOrderLoading());
    final result = await updateOrdersUseCase.call(date, addressId, orderId);
    result.fold(
      (failure) {
        emit(UpdateOrderFailure(
          message: failure.message,
        ));
      },
      (user) {
        emit(UpdateOrderSuccess());
      },
    );
  }

  Future<void> cancleOrder(int orderId) async {
    emit(CancleOrderLoading());
    final result = await cancleOrdersUseCase.call(orderId);
    result.fold(
      (failure) {
        emit(CancleOrderFailure(
          message: failure.message,
        ));
      },
      (user) {
        emit(CancleOrderSuccess());
      },
    );
  }

  List<ImageData> starting = [];
  List<ImageData> completed = [];
  Future<void> getAttachments(int orderId) async {
    emit(AttachmentLoading());
    final result = await getAttachmentsUseCase.call(orderId);
    result.fold(
      (failure) {
        emit(AttachmentFailure(
          message: failure.message,
        ));
      },
      (user) {
        starting.clear();
        completed.clear();
        starting = user.start!;
        completed = user.complete!;
        emit(AttachmentSuccess());
      },
    );
  }
}
