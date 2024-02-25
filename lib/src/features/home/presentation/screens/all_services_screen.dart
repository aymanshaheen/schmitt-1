import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  bool isSearching = false;
  List<dynamic> searchResult = [];
  List<String> services = [
    'housekeeping',
    'plumbing',
    'electrician',
    'carpentry',
    'painting',
    'gardening',
    'pest_control',
    'ac_repair',
    'cleaning',
    'movers',
  ];
  TextEditingController searchController = TextEditingController();
  void addDataToFilteredList({required String input}) {
    setState(() {
      searchResult = services
          .where((element) => element.toLowerCase().startsWith(input))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isSearching
            ? searchBar(
                leadingOnPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                title: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'search'.tr(),
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      addDataToFilteredList(input: value);
                    });
                  },
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context: context,
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchController.clear();
                  });
                })
            : profileAppBar(
                title: 'our_services'.tr(),
                context: context,
                isAction: false,
                isTrilling: true,
                trillingIcon: Icons.search,
                onTrillingPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                }),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return ServiceItem(
                  title: searchResult.isEmpty
                      ? services[index]
                      : searchResult[index]);
              // return Container(
              //   margin: EdgeInsets.symmetric(
              //     vertical: R.sH(context, 5),
              //     horizontal: R.sW(context, 15),
              //   ),
              //   decoration: BoxDecoration(
              //     color: AppColors.white,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Text(
              //     searchResult.isEmpty ? services[index] : searchResult[index],
              //     style: TextStyle(
              //       color: AppColors.homeBlackColor,
              //       fontSize: R.F(context, 16),
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   width: R.sW(context, 300),
              //   height: R.sH(context, 100),
              // );
            },
            itemCount:
                searchResult.isEmpty ? services.length : searchResult.length));
  }
}

PreferredSizeWidget searchBar({
  required BuildContext context,
  Function()? onPressed,
  required Widget? title,
  required Function() leadingOnPressed,
}) {
  return AppBar(
    // leading: IconButton(
    //   icon: Icon(
    //     Icons.arrow_back_ios,
    //     color: AppColors.black,
    //   ),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // ),
    centerTitle: false,
    leadingWidth: R.sW(context, 15),
    title: title,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: leadingOnPressed,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
            onTap: onPressed,
            child: Icon(Icons.clear, color: AppColors.black, size: 30)),
      ),
    ],
    backgroundColor: AppColors.white,
    elevation: 0,
  );
}
