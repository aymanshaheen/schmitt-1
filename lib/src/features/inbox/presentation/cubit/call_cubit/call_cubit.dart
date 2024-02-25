import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/call_stream_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/end_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/get_calls_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/make_call_usecase.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallStreamUseCase callStreamUseCase;
  final EndCallUseCase endCallUseCase;
  final MakeCallUseCase makeCallUseCase;
  final GetCallsUseCase getContactsChatUseCase;

  CallCubit({
    required this.callStreamUseCase,
    required this.endCallUseCase,
    required this.makeCallUseCase,
    required this.getContactsChatUseCase,
  }) : super(CallInitial());

  static CallCubit get(context) => BlocProvider.of(context);

  Stream<DocumentSnapshot> callStream({
    required String receiverId,
  }) =>
      callStreamUseCase(receiverId);

  Future<void> makeCall({
    required String receiverId,
    required String receiverName,
    required String receiverPic,
  }) async {
    emit(MakeCallLoadingState());
    final result = await makeCallUseCase(
      MakeCallParameters(
        receiverId: receiverId,
        receiverName: receiverName,
        receiverPic: receiverPic,
      ),
    );
    result.fold(
      (l) => emit(MakeCallErrorState()),
      (r) => emit(MakeCallSuccessState(call: r)),
    );
  }
  Stream<List<Call>> getCalls(Map<String, dynamic> map) {
    return getContactsChatUseCase(map);
  }

  Future<void> endCall({
    required String receiverId,
    required String callerId,
  }) async {
    emit(EndCallLoadingState());
    final result = await endCallUseCase(
      EndCallParameters(
        receiverId: receiverId,
        callerId: callerId,
      ),
    );
    result.fold(
      (l) => emit(EndCallErrorState()),
      (r) => emit(EndCallSuccessState()),
    );
  }
}
