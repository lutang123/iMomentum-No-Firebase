import 'package:flutter/material.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';
import 'package:iMomentum/screens/iMeditate/utils/utils.dart';

class CustomizedBottomSheet extends StatelessWidget {
  CustomizedBottomSheet({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: (size.height / 5) * 2,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
//        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark(context) ? darkSurface : lightSurface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }
}
