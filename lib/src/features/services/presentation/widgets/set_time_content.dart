import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/dotted_check_box.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';

class SetTimeContent extends StatefulWidget {
  const SetTimeContent({super.key});

  @override
  State<SetTimeContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<SetTimeContent> {
  void onContainerTap(int index) {
    setState(() {
      ServiceCubit.get(context)
          .setSelectedDate(DateTime.now().add(Duration(days: index)), index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceStates>(builder: (context, state) {
      final selectedIndex = ServiceCubit.get(context).selectedIndex;

      return Column(
        children: [
          SizedBox(
            height: R.sH(context, 50),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final formattedDate = DateFormat('MM/d/yyyy').format(date);
                return GestureDetector(
                  onTap: () => onContainerTap(index),
                  child: Container(
                    margin: EdgeInsets.all(R.sW(context, 5)),
                    padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 10),
                        vertical: R.sH(context, 5)),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkBlue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: index == selectedIndex
                          ? AppColors.darkBlue
                          : AppColors.white,
                    ),
                    child: Center(
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          color: index == selectedIndex
                              ? Colors.white
                              : AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          getHourOrder(),
        ],
      );
    });
  }

  Widget getHourOrder() {
    switch (ServiceCubit.get(context).selectedIndex) {
      default:
        return SizedBox(
          height: R.sH(context, 440),
          child: ListView.builder(
            itemCount: 24,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final hour = index;
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: R.sH(context, 12), horizontal: R.sW(context, 5)),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ServiceCubit.get(context).selectedHour = index;
                        ServiceCubit.get(context).setSelectedHour(hour);
                      });
                    },
                    child: Row(
                      children: [
                        CustomPaint(
                          size: Size(R.sW(context, 18), R.sW(context, 18)),
                          painter: DottedCirclePainter(
                              isChecked: index ==
                                  ServiceCubit.get(context).selectedHour),
                        ),
                        SizedBox(width: R.sW(context, 15)),
                        Text('$hour:00',
                            style: TextStyle(
                              fontSize: R.sW(context, 18),
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    )),
              );
            },
          ),
        );
    }
  }
}
