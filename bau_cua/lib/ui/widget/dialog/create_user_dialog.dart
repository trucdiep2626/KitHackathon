import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/theme/theme_color.dart';
import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/ui/widget/home_screen_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateUserDialog extends StatelessWidget {
  final Function(String) createUser;
  final TextEditingController userEditingController;

  const CreateUserDialog(
      {Key key, @required this.createUser, this.userEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 200.h, horizontal: 20.w),
        child: Dialog(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppConstance.borderRadius,
                border: Border.all(color: Colors.white, width: 3.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value){
                        userName = value;
                      },
                      controller: userEditingController,
                      decoration: InputDecoration(
                        labelText: 'User name',
                        labelStyle: ThemeText.textStyle.copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(height: 35.h,
                        width: double.infinity,
                        child: RaisedButton(onPressed: () {
                          createUser(userName);
                          Navigator.pop(context);
                        },
                          color: ThemColor.primaryColor,
                          child: Text(HomeScreenConstance.createAccount,
                            style: ThemeText.textStyle,),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppConstance.borderRadius,
                          ),))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}