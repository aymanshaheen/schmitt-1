import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/bottom_field/bottom_chat_with_icon.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/call_pickup_screen.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/chat_appbar.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_list.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/bottom_chat_cubit/bottom_chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String id;
  const ChatScreen({super.key, required this.name, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CallCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BottomChatCubit>(),
        ),
      ],
      child: CallPickupScreen(
        receiverId: widget.id,
        scaffold: Scaffold(
          appBar: ChatAppBar(name: widget.name, receiverId: widget.id),
          body: Column(
            children: [
              MessageListWidget(receiverId: widget.id),
              BottomChatWithIcon(receiverId: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}
