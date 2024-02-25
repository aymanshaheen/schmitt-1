import 'package:flutter/cupertino.dart';

class CircularIndicator extends StatelessWidget {
 final Color color;
  const CircularIndicator({
    super.key, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 15,
        color: color,
      ),
    );
  }
}
