import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_event.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_state.dart';


class OnboardingBloc extends Bloc<OnboardingEvents, OnboardingStates> {
  OnboardingBloc() : super(OnboardingStates()) {
    on<OnboardingEvents>((event, emit) {
      return emit(OnboardingStates(pageIndex: state.pageIndex));
    });
  }
}