import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget Function(BuildContext) builder;

  FadeRoute({required this.builder})
      : super(
         pageBuilder: (context, animation, anotherAnimation) =>
              builder(context),
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastEaseInToSlowEaseOut,
              parent: animation,
              reverseCurve: Curves.easeInOutCubic,
            );
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: builder(context),
              ),
            );
          },
        );
}