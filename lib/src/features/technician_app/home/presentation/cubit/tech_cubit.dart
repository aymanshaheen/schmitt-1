import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/get_orders.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_complete.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_progress.dart';
import 'package:schmitt/src/features/technician_app/home/domain/use_cases/mark_start.dart';
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

  Future<void> getOrders(String status) async {
    emit(OrderLoading());

    final result = await getOrdersUseCase.call(status);

    result.fold(
      (failure) {
        emit(OrderFailure(
          message: failure.message,
        ));
      },
      (user) => emit(OrderSuccess(user)),
    );
  }

  Future<void> markAsStart(File image, String id) async {
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

  Future<void> markAsComplete(File image, String id) async {
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
