import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/features/inbox/data/data_sources/call/call_data_source.dart';
import 'package:schmitt/src/features/inbox/data/data_sources/chat/remote/chat_remote_data_source.dart';
import 'package:schmitt/src/features/inbox/data/repositories/call_repository.dart';
import 'package:schmitt/src/features/inbox/data/repositories/chat_repository.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_chat_repository.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/call_stream_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/end_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/get_calls_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/make_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_chat_messages_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_contacts_chat_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_num_of_message_not_seen_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_file_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_text_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/set_chat_message_seen_usecase.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';

Future<void> initChat() async {
  //Future Cubit/Bloc
  sl.registerFactory<CallCubit>(() => CallCubit(
        makeCallUseCase: sl.call(),
        endCallUseCase: sl.call(),
        getContactsChatUseCase: sl.call(),
        callStreamUseCase: sl.call(),
      ));
  sl.registerFactory<ChatCubit>(() => ChatCubit(
        sendTextMessageUseCase: sl.call(),
        getContactsChatUseCase: sl.call(),
        getChatMessagesUseCase: sl.call(),
        setChatMessageSeenUseCase: sl.call(),
        getNumberOfMessageNotSeenUseCase: sl.call(),
        sendFileMessageUseCase: sl<SendFileMessageUseCase>(),
      ));
  sl.registerFactory<BottomChatCubit>(() => BottomChatCubit());

  //UseCases

  sl.registerLazySingleton<CallStreamUseCase>(
      () => CallStreamUseCase(sl.call()));
  sl.registerLazySingleton<EndCallUseCase>(() => EndCallUseCase(sl.call()));
  sl.registerLazySingleton<MakeCallUseCase>(() => MakeCallUseCase(sl.call()));
  sl.registerLazySingleton<GetChatMessagesUseCase>(
      () => GetChatMessagesUseCase(sl.call()));
  sl.registerLazySingleton<GetContactsChatUseCase>(
      () => GetContactsChatUseCase(sl.call()));
  sl.registerLazySingleton<GetNumberOfMessageNotSeenUseCase>(
      () => GetNumberOfMessageNotSeenUseCase(sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(sl.call()));
  sl.registerLazySingleton<SetChatMessageSeenUseCase>(
      () => SetChatMessageSeenUseCase(sl.call()));
  sl.registerLazySingleton<SendFileMessageUseCase>(
      () => SendFileMessageUseCase(sl.call()));
  sl.registerLazySingleton<GetCallsUseCase>(() => GetCallsUseCase(sl.call()));

  //Repository
  sl.registerLazySingleton<BaseCallRepository>(() => CallRepository(sl.call()));
  sl.registerLazySingleton<BaseChatRepository>(() => ChatRepository(sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<CallDataSource>(() => CallDataSource(
        firestore: sl.call(),
      ));
  sl.registerLazySingleton<BaseChatRemoteDataSource>(() => ChatRemoteDataSource(
        firestore: sl.call(),
        dio: sl.call(),
        firebaseStorage: sl.call(),
        auth: sl.call(),
      ));
}
