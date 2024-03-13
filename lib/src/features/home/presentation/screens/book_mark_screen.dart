import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/favourite_bookmark_item.dart';
import 'package:schmitt/src/features/home/presentation/widgets/offers_home_listview_item.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  late AnimationController _controller;
  int num = 0;

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).tabbedOffer = 0;
    HomeCubit.get(context).getBookMark(AppStrings.allId);
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void deleteBookmark(int index) {
    var item = HomeCubit.get(context).bookmarks![index];
    HomeCubit.get(context).deleteBookMark(item.id.toString());
    item = HomeCubit.get(context).bookmarks!.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: 1.0,
          child: FavouriteItem(
            bookMark: item,
            onDelete: () => deleteBookmark(index),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Function> functionList = [
      () => HomeCubit.get(context).getBookMark(AppStrings.allId),
      () => HomeCubit.get(context).getBookMark(AppStrings.houseId),
      () => HomeCubit.get(context).getBookMark(AppStrings.carId),
      () => HomeCubit.get(context).getBookMark(AppStrings.babyId),
    ];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        HomeCubit.get(context).tabbedOffer = 0;
        HomeCubit.get(context)
            .getServices(1, AppStrings.allId);
        final navigator = Navigator.of(context);
        navigator.pop();
      },
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: R.sW(context, 15),
            automaticallyImplyLeading: false,
            title: Text(
              'bookmarks'.tr(),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.white,
            elevation: 0,
           
            actions: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
                  child: const MoreInfoIcon()),
              SizedBox(
                width: R.sW(context, 15),
              )
            ],
          ),
          body: BlocListener<HomeCubit, HomeStates>(
            listener: (context, state) {},
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 15),
                        vertical: R.sH(context, 10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: R.sH(context, 40),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return OffersItem(
                                    title: HomeCubit.get(context)
                                        .offersList[index],
                                    onTap: () {
                                      HomeCubit.get(context)
                                          .changeTabbedOffer(index);
                                      HomeCubit.get(context).bookmarks = [];
                                      functionList[index]();
                                      num = index;
                                    });
                              }),
                        ),
                        SizedBox(
                          height: R.sH(context, 10),
                        ),
                        if (state is GetFavouriteLoding)
                          Container(
                            padding: EdgeInsets.all(R.sW(context, 20)),
                            height: R.H(context) - R.sH(context, 200),
                            child: Center(
                              child: CircularIndicator(
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                        if (HomeCubit.get(context).bookmarks!.isNotEmpty &&
                            state is! GetFavouriteLoding)
                          Expanded(
                            child: AnimatedList(
                              key: _listKey,
                              initialItemCount:
                                  HomeCubit.get(context).bookmarks!.length,
                              itemBuilder: (context, index, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.service,
                                        arguments: HomeCubit.get(context)
                                            .services[index]),
                                    child: FavouriteItem(
                                      bookMark: HomeCubit.get(context)
                                          .bookmarks![index],
                                      onDelete: () => deleteBookmark(index),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        if (state is GetFavouriteError &&
                            HomeCubit.get(context).bookmarks!.isEmpty)
                          Container(
                            padding: EdgeInsets.all(R.sW(context, 20)),
                            height: R.H(context) - R.sH(context, 200),
                            child: const Center(
                              child: Text('No bookmarks'),
                            ),
                          ),
                        if (HomeCubit.get(context).bookmarks!.isEmpty &&
                            state is DeleteFavouriteLoaded)
                          Container(
                            padding: EdgeInsets.all(R.sW(context, 20)),
                            height: R.H(context) - R.sH(context, 200),
                            child: const Center(
                              child: Text('No bookmarks'),
                            ),
                          ),
                      ],
                    ));
              },
            ),
          )),
    );
  }
}
