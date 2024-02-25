import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
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

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getBookMark();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
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
    var item = HomeCubit.get(context).bookmarks[index];
    HomeCubit.get(context).deleteBookMark('1');
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(1, 0),
        ).animate(animation),
        child: FavouriteItem(
          bookMark: item,
          onDelete: () => deleteBookmark(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: R.sW(context, 15),
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
              margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
              child: const MoreInfoIcon()),
          SizedBox(
            width: R.sW(context, 15),
          )
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is DeleteFavouriteLoaded) {
            buildSnakBar(
                context: context,
                message: state.message,
                color: AppColors.green);
          }
        },
        builder: (context, state) {
          if (state is GetFavouriteLoding) {
            return Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            );
          } else if (state is GetFavouriteLoaded) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 15), vertical: R.sH(context, 10)),
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
                              title: HomeCubit.get(context).offersList[index],
                              onTap: () {
                                HomeCubit.get(context).changeTabbedOffer(index);
                              });
                        }),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Expanded(
                      child: AnimatedList(
                    key: _listKey,
                    initialItemCount: HomeCubit.get(context).bookmarks.length,
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FavouriteItem(
                          bookMark: HomeCubit.get(context).bookmarks[index],
                          onDelete: () => deleteBookmark(index),
                        ),
                      );
                    },
                  )),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('There is no favourite item'),
            );
          }
        },
      ),
    );
  }
}
