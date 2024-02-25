import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CleaningItem extends StatefulWidget {
  final Widget trillingWidget;
  final double? widthBetween;
  const CleaningItem({
    super.key,
    required this.trillingWidget,
    this.widthBetween,
  });

  @override
  State<CleaningItem> createState() => _CleaningItemState();
}

class _CleaningItemState extends State<CleaningItem> {
  int cleanCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          width: R.sW(context, R.W(context) - 50),
          height: R.sH(context, 70),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0C04060F),
                blurRadius: 60,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: R.sW(context, 10)),
              child: Row(
                children: [
                  SizedBox(
                    width: R.sW(context, 15),
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: R.sW(context, 35),
                    height: R.sH(context, 35),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF1E7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            cleanCounter--;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: R.sW(context, 15),
                  ),
                  SizedBox(
                    child: Text(
                      cleanCounter.toString(),
                      style: TextStyle(
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: R.sW(context, 15),
                  ),
                  Container(
                    width: R.sW(context, 35),
                    height: R.sH(context, 35),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF1E7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cleanCounter++;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: R.sW(context, widget.widthBetween ?? 60),
                  ),
                  widget.trillingWidget,
                ],
              ),
            ),
          ),
        ));
  }
}
