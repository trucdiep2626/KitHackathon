import 'package:bau_cua/common/app_constace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowResultWidget extends StatelessWidget {
  final String name;
  final double width;
  final double height;

  const ShowResultWidget({Key key, this.name,this.height,this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Container(
     width:width?? 90.w,
     height:height?? 90.h,
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: AppConstance.borderRadius
     ),
     child: Image.asset(name),
   );
  }

}