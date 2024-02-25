import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/calls_screen.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/chats_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<Tab> tabs = [
    Tab(text: "chats".tr()),
    Tab(text: "calls".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ChatCubit>()),
        BlocProvider(create: (context) => sl<CallCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: Text(
            'inbox'.tr(),
            style: TextStyle(
              fontSize: R.F(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Icon(
              Icons.search,
              color: AppColors.black,
            ),
            SizedBox(
              width: R.sW(context, 15),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
                child: const MoreInfoIcon()),
            SizedBox(
              width: R.sW(context, 15),
            )
          ],
          bottom: TabBar(
            controller: controller,
            indicator: UnderlineTabIndicator(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              borderSide: BorderSide(
                width: R.sW(context, 4),
                color: AppColors.darkBlue,
              ),
              insets: EdgeInsets.symmetric(horizontal: R.sW(context, -45)),
            ),
            labelColor: AppColors.darkBlue,
            labelStyle: TextStyle(
              fontSize: R.F(context, 18),
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: AppColors.lightGrey,
            indicatorWeight: R.sW(context, 2),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.darkBlue,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, Routes.chat, arguments: {
              'name': "Custغ",
              'id': "5",
            });
          },
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: const <Widget>[
            ChatsScreen(),
            CallsScreen(),
          ],
        ),
      ),
    );
  }
}
