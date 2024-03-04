import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/bottom_sheet_custom.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';

class AddressItem extends StatefulWidget {
  final Address services;
  const AddressItem({super.key, required this.services});

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: R.sH(context, 5),
        horizontal: R.sW(context, 15),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(R.sW(context, 15)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: R.sH(context, 5),
                  ),
                  Text(
                    widget.services.name!,
                    style: TextStyle(
                      color: AppColors.homeBlackColor,
                      fontSize: R.F(context, 14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Text(
                    widget.services.address!,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: R.F(context, 12),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: R.sH(context, 15),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            AppConstants.currentAddress = widget.services;
                            AppConstants.selectEdit = widget.services.id!;
                            Navigator.pushNamed(context, Routes.location,
                                arguments: true);
                          },
                          child: SvgPicture.asset(AppImage.edit,
                              fit: BoxFit.cover,
                              width: R.sW(context, 25),
                              height: R.sH(context, 25)),
                        ),
                        SizedBox(
                          width: R.sW(context, 15),
                        ),
                        InkWell(
                          onTap: () {
                            AppConstants.selectEdit = widget.services.id!;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const DeleteCarBottomSheet(
                                  isCar: false,
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                            size: R.sW(context, 25),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
