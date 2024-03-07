// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:schmitt/src/core/widgets/responsivity.dart';
// import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
// import 'package:schmitt/src/features/packages/presentation/widgets/packages_app_bar.dart';
//
// class PackagesScreen extends StatefulWidget {
//   const PackagesScreen({super.key});
//
//   @override
//   State<PackagesScreen> createState() => _PackagesScreenState();
// }
//
// class _PackagesScreenState extends State<PackagesScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PackageCubit(),
//       child:
//           BlocBuilder<PackageCubit, PackageStates>(builder: (context, state) {
//         return Scaffold(
//             appBar: packageAppBar(context: context, title: 'Packages'),
//             body: Padding(
//               padding: EdgeInsets.only(
//                 right: R.sW(context, 15),
//                 left: R.sW(context, 15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: const Center(
//                         child: Text(
//                           '',
//                       style: TextStyle(
//                         color: Color(0xFF1C4274),
//                         fontSize: 18,
//                         fontFamily: 'Urbanist',
//                         fontWeight: FontWeight.w700,
//                       ),
//                     )),
//                     width: R.sW(context, R.W(context) - 32),
//                     height: R.sH(context, 60),
//                     decoration: ShapeDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(-0.96, 0.28),
//                         end: Alignment(0.96, -0.28),
//                         colors: [Color(0xFFFACC15), Color(0xFFFFE57F)],
//                       ),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: R.sH(context, 20),
//                   ),
//                   Container(
//                     width: 348,
//                     height: 147,
//                     decoration: ShapeDecoration(
//                       image: DecorationImage(
//                         image:
//                             NetworkImage("https://via.placeholder.com/348x147"),
//                         fit: BoxFit.fill,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: R.sH(context, 20),
//                   ),
//                   Text(
//                     'Description:'.tr(),
//                     style: TextStyle(
//                       color: Color(0xFF1C4274),
//                       fontSize: 16,
//                       fontFamily: 'Urbanist',
//                       fontWeight: FontWeight.w700,
//                     ),
//                   )
//                 ],
//               ),
//             ));
//       }),
//     );
//   }
// }
