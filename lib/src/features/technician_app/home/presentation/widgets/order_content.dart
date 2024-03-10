import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/expandeble_map.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/header_exbanded.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/main_header.dart';

class OrderContent extends StatefulWidget {
  final Order order;
  final bool isEdit;
  final bool isUser;

  const OrderContent({
    super.key,
    required this.order,
    required this.isEdit,
    required this.isUser,
  });

  @override
  _OrderContentState createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isUser
            ? Navigator.pushNamed(context, Routes.orderDetailsScreen,
                arguments: widget.order)
            : Navigator.pushNamed(context, Routes.techOrderService,
                arguments: widget.order);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: R.sH(context, 5),
          horizontal: R.sW(context, 5),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(R.sW(context, 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                firstChild: HeaderExpanded(
                  order: widget.order,
                  isEdit: widget.isEdit,
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
                secondChild: MainHeader(
                  order: widget.order,
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              SizedBox(
                height: R.sH(context, 5),
              ),
              Center(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  firstChild: Container(),
                  secondChild: ExpandebleMap(
                    order: widget.order,
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
              isExpanded
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.black,
                          size: R.sW(context, 22),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
