import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class AllServicesScreen extends StatefulWidget {
  final List<Service> services;
  const AllServicesScreen({super.key, required this.services});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          padding: EdgeInsets.all(R.sW(context, 20)),
          child: widget.services != []
              ? const NoDataAvailable(
                  text: 'no_servcies_with_this_name',
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) {
                    return ServiceItem(services: widget.services[index]);
                  },
                ),
        ));
  }
}
