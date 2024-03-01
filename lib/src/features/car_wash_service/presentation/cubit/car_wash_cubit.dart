import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarWashServiceCubit extends Cubit<CarWashServiceStates> {
  CarWashServiceCubit() : super(ServiceInitial());
  static CarWashServiceCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int tabbedOffer = 0;
  List<String> offersList = [
    "all".tr(),
    "5",
    "4",
    "3",
    "2",
    "1",
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ServiceNavigationBarChanged(index));
  }

  changeTabbedOffer(int index) {
    tabbedOffer = index;
    emit(ServiceTabbedOfferChanged(index));
  }
}
class CarWashServiceStates {}

class ServiceInitial extends CarWashServiceStates {}

class ServiceLoading extends CarWashServiceStates {}

class ServiceLoaded extends CarWashServiceStates {}

class ServiceError extends CarWashServiceStates {
  final String message;
  ServiceError(this.message);
}

class ServiceNavigationBarChanged extends CarWashServiceStates {
  final int index;
  ServiceNavigationBarChanged(this.index);
}

class ServiceTabbedOfferChanged extends CarWashServiceStates {
  final int index;
  ServiceTabbedOfferChanged(this.index);
}
