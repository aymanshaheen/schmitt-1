part of 'tech_cubit.dart';

abstract class TechState extends Equatable {
  const TechState();
}

class TechInitial extends TechState {
  @override
  List<Object> get props => [];
}

class TechNavigationBarChanged extends TechState {
  final int index;
  const TechNavigationBarChanged(this.index);
  @override
  List<Object> get props => [index];
}

class OrderLoading extends TechState {
  @override
  List<Object> get props => [];
}

class OrderSuccess extends TechState {
  const OrderSuccess(this.user);
  final List<Order>? user;
  @override
  List<Object> get props => [user!];
}

class OrderFailure extends TechState {
  final String message;

  const OrderFailure({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}

class MarkLoading extends TechState {
  @override
  List<Object> get props => [];
}

class MarkSuccess extends TechState {
  const MarkSuccess(this.user);
  final OrderEntity user;
  @override
  List<Object> get props => [user];
}

class MarkFailure extends TechState {
  final String message;

  const MarkFailure({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}
