import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/dotted_check_box.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/widgets/get_location_step.dart';
import 'package:schmitt/src/features/services/presentation/widgets/set_time_content.dart';

class StepContent extends StatefulWidget {
  final int step;

  const StepContent({super.key, required this.step});

  @override
  State<StepContent> createState() => _StepContentState();
}

class _StepContentState extends State<StepContent> {
  int? checkedHourIndex;

 
  @override
  void initState() {
    ServiceCubit.get(context).addresses=[];
    ServiceCubit.get(context).getAdresses(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          switch (widget.step) {
            1 => const LocationStep(),
            2 => const SetTimeContent(),
            3 => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'payment_method'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: R.sH(context, 20)),
                  SizedBox(
                    height: R.sH(context, 440),
                    child: ListView.builder(
                      itemCount: 4,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final hour = index;
                        final isChecked = index == checkedHourIndex;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: R.sH(context, 10),
                              horizontal: R.sW(context, 5)),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkedHourIndex = isChecked ? null : index;
                                });
                              },
                              child: Row(
                                children: [
                                  CustomPaint(
                                    size: Size(R.sW(context, 16), R.sW(context, 16)),
                                    painter:
                                        DottedCirclePainter(isChecked: isChecked),
                                  ),
                                  SizedBox(width: R.sW(context, 15)),
                                  Icon(Icons.payment_rounded,
                                      color: AppColors.darkBlue),
                                  SizedBox(width: R.sW(context, 5)),
                                  Text('$hour:00'),
                                ],
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
            _ => Text('Default content')
          },
        ],
      ),
    );
  }

 
}
