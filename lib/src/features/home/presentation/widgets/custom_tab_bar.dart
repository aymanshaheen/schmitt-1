import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomHomeTabController extends StatefulWidget {
  final List<String> imgList;

  const CustomHomeTabController({super.key, required this.imgList});

  @override
  _CustomTabControllerState createState() => _CustomTabControllerState();
}

class _CustomTabControllerState extends State<CustomHomeTabController> {
  late PageController _controller;
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1000,
    );
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round() % widget.imgList.length;
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_controller.page!.round() == widget.imgList.length - 1) {
        _controller.animateToPage(0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInToLinear);
      } else {
        _controller.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInToLinear);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Stack(
      children: [
        SizedBox(
          height: R.sH(context, 200),
          child: PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  SizedBox(
                    width: R.sW(context, R.W(context)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: R.sW(context, 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          widget.imgList[index % widget.imgList.length],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: R.sH(context, 35),
                      left:isArabic? R.sW(context, 265):R.sW(context, 45),
                    child: SizedBox(
                      child: Text(
                        '30%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: R.F(context, 35),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: R.sH(context, 85),
                      left:isArabic? R.sW(context, 180):R.sW(context, 45),
                      child: Text(
                        'Today’s Special!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: R.F(context, 20),
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Positioned(
                      left:isArabic? R.sW(context, 190):R.sW(context, 45),
                    top: R.sH(context, 120),
                    child: Text(
                      'Get discount for every\norder, only valid for today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: R.F(context, 12),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.20,
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: 10000,
          ),
        ),
        Positioned(
          bottom: R.sH(context, 20),
          right: R.sW(context, 135),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(widget.imgList.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: R.sW(context, 4)),
                height: R.sH(context, 8),
                width: currentPage == index
                    ? R.sW(context, 25)
                    : R.sW(context, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentPage == index
                      ? AppColors.darkBlue
                      : AppColors.grey1!,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
