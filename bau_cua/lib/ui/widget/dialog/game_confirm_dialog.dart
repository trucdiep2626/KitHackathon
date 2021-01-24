import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/convert_index_to_str_assets.dart';
import 'package:bau_cua/common/theme/theme_color.dart';
import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/model/bet.dart';
import 'package:bau_cua/ui/widget/show_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameConfirmDialog extends StatelessWidget {
  final List<Bet> result;
  final Function submit;

  const GameConfirmDialog({Key key, this.result, this.submit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 100.h),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
                  child: ListView.builder(
                    itemCount: result.length,
                      itemBuilder: (context, index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShowResultWidget(
                                name: convertIntToStrAss(result[index].index),
                              ),
                              Icon(
                                Icons.attach_money_rounded,
                                color: ThemColor.secondColor,
                                size: 14.sp,
                              ),
                              Text(
                                '${result[index].money}',
                                style: ThemeText.textStyle,
                              ),
                            ],
                          )),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: RaisedButton(
                    onPressed: submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppConstance.borderRadius
                    ),
                    child: Text(
                      'Submit',
                      style: ThemeText.textStyle,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
