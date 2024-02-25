import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingStates> {
  BookingCubit() : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;


 
}
