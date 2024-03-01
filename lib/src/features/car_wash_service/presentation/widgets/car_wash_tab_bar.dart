import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CarWashTabBar extends StatefulWidget {
  final List<String> imgList;

  CarWashTabBar({required this.imgList});

  @override
  _CarWashTabBarState createState() => _CarWashTabBarState();
}

class _CarWashTabBarState extends State<CarWashTabBar> {
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
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInToLinear);
      } else {
        _controller.nextPage(
            duration: const Duration(milliseconds: 500),
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
    return Stack(
      children: [
        AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          child: Container(
            height: R.sH(context, 350),
            child: PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  widget.imgList[index % widget.imgList.length],
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: R.sH(context, 20),
          right: R.sW(context, 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(widget.imgList.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: R.sW(context, 4)),
                height: R.sH(context, 8),
                width:
                    currentPage == index ? R.sW(context, 25) : R.sW(context, 8),
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
