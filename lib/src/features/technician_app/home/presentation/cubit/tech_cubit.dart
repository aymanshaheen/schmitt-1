import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/get_orders.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_complete.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_progress.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_start.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/home_layout.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/order_settings_screen.dart';
part 'tech_state.dart';

class TechCubit extends Cubit<TechState> {
  final GetOrdersUseCase getOrdersUseCase;
  final MarkAsStartUseCase markAsStartUseCase;
  final MarkAsProgressUseCase markAsProgressUseCase;
  final MarkAsCompleteUseCase markAsCompleteUseCase;
  TechCubit({
    required this.getOrdersUseCase,
    required this.markAsStartUseCase,
    required this.markAsProgressUseCase,
    required this.markAsCompleteUseCase,
  }) : super(TechInitial());
  static TechCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const HomeTechLayoutScreen(),
    const OrderSettingScreen(),
  ];
  int currentIndex = 0;

  List<Order> orders = [];
  List<Order> todayOrders = [];
  List<Order> upcomingOrders = [];
  Future<void> getOrders(String status) async {
    emit(OrderLoading());

    final result = await getOrdersUseCase.call(status);

    result.fold(
      (failure) {
        emit(OrderFailure(
          message: failure.message,
        ));
      },
      (user) {
        orders.clear();
        todayOrders.clear();
        upcomingOrders.clear();
        orders = user.data!;
        DateTime today = DateTime.now();
        DateTime tomorrow = today.add(const Duration(days: 1));
        DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
        today = DateTime(today.year, today.month, today.day);
        tomorrow = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
        dayAfterTomorrow = DateTime(dayAfterTomorrow.year,
            dayAfterTomorrow.month, dayAfterTomorrow.day);
        for (Order order in orders) {
          DateTime orderStartDate = DateTime.parse(order.startAt!);
          orderStartDate = DateTime(
              orderStartDate.year, orderStartDate.month, orderStartDate.day);
          if (orderStartDate.isAtSameMomentAs(today) ||
              orderStartDate.isAtSameMomentAs(tomorrow) ||
              orderStartDate.isAtSameMomentAs(dayAfterTomorrow)) {
            todayOrders.add(order);
          } else {
            upcomingOrders.add(order);
          }
        }
        emit(OrderSuccess(user.data!));
      },
    );
  }

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

  Future<void> markAsStart(List<File> image, String id) async {
    emit(MarkLoading());

    final result = await markAsStartUseCase.call(image, id);

    result.fold(
      (failure) {
        emit(MarkFailure(
          message: failure.message,
        ));
      },
      (user) => emit(MarkSuccess(user)),
    );
  }

  Future<void> markAsComplete(List<File> image, String id) async {
    emit(MarkLoading());

    final result = await markAsCompleteUseCase.call(image, id);

    result.fold(
      (failure) {
        emit(MarkFailure(
          message: failure.message,
        ));
      },
      (user) => emit(MarkSuccess(user)),
    );
  }

  Future<void> markAsProgress(String id) async {
    emit(MarkLoading());

    final result = await markAsProgressUseCase.call(id);

    result.fold(
      (failure) {
        emit(MarkFailure(
          message: failure.message,
        ));
      },
      (user) => emit(MarkSuccess(user)),
    );
  }
}
