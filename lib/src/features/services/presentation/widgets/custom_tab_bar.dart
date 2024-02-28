import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class CustomTabController extends StatefulWidget {
  final Service service;

  const CustomTabController({super.key, required this.service});

  @override
  _CustomTabControllerState createState() => _CustomTabControllerState();
}

class _CustomTabControllerState extends State<CustomTabController> {
  late PageController _controller;
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1000,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.service.images.length > 1) {
        _controller.addListener(() {
          if (_controller.page != null) {
            setState(() {
              currentPage =
                  _controller.page!.round() % widget.service.images.length;
            });
          }
        });

        _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
          if (_controller.page != null) {
            if (_controller.page!.round() == widget.service.images.length - 1) {
              _controller.animateToPage(0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInToLinear);
            } else {
              _controller.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInToLinear);
            }
          }
        });
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
          value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          child: SizedBox(
            height: R.sH(context, 350),
            child: PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                  imageUrl: widget
                      .service.images[index % widget.service.images.length].url,
                  fit: BoxFit.cover,
                  
                  placeholder: (context, url) => CircularIndicator(
                    color: AppColors.darkBlue,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: R.sH(context, 20),
          right: R.sW(context, 150),
          child: widget.service.images.length > 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(widget.service.images.length,
                      (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin:
                          EdgeInsets.symmetric(horizontal: R.sW(context, 4)),
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
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
