import 'package:bau_cua/common/app_constace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GameIconButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Function onPressed;

  const GameIconButton({Key key, this.width, this.height, this.onPressed, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConstance.borderRadius,
      ),
      child: SizedBox(
        width: width ?? 50.w,
        height: height?? 50.w,
        child: IconButton(icon: child, onPressed: onPressed,color: Colors.redAccent,),
      ),
    );
  }
}