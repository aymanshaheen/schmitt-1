import 'package:flutter/material.dart';

import '../../../../core/widgets/responsivity.dart';

class DropDownCarWash extends StatefulWidget {
  String dropDownHint;
  String selectedItem;
  List<String> dropDownItems;
  String dropDownTitle;
  DropDownCarWash(
      {super.key,
        required this.selectedItem,
        required this.dropDownItems,
        required this.dropDownTitle,
        required this.dropDownHint});


  @override
  State<DropDownCarWash> createState() => _DropDownCarWashState();
}

class _DropDownCarWashState extends State<DropDownCarWash> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: R.sH(context, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: R.sH(
                  context,
                  15,
                ),
                left: R.sW(context, 15)),
            child: Text(
              widget.dropDownTitle,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: R.sW(context, 15),
                right: R.sW(context, 15),
                top: R.sH(context, 10)),
            child: Container(
              height: R.sH(context, 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    right: R.sW(context, 10), left: R.sW(context, 10)),
                child: Center(
                  child: DropdownButton(
                    iconSize: 30,
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(10),
                    hint: Text(
                      widget.dropDownHint ,
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: widget.selectedItem,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                    isExpanded: true,
                    items: widget.dropDownItems.map((value) {
                      return DropdownMenuItem(
                        value: value  ,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selectedItem = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
