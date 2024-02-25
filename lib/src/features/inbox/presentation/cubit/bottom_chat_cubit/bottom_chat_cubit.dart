import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_chat_state.dart';

class BottomChatCubit extends Cubit<BottomChatState> {
  BottomChatCubit() : super(BottomChatInitial());

  static BottomChatCubit get(context) => BlocProvider.of(context);

  bool isShownSendButton = false;
  bool isRecording = false;


  void onTextFieldValChanged(String val) {
    if (val.trim().isNotEmpty) {
      isShownSendButton = true;
      emit(IsShowSendButtonTrueState());
    } else {
      isShownSendButton = false;
      emit(IsShowSendButtonFalseState());
    }
  }
}
