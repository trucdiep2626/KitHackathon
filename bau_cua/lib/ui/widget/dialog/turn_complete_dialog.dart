import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/convert_index_to_str_assets.dart';
import 'package:bau_cua/common/theme/theme_color.dart';
import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/model/user.dart';
import 'package:bau_cua/ui/widget/show_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TurnCompleteDialog extends StatelessWidget {
  final List<int> result;
  final List<User> player;
  final Function turnDone;

  const TurnCompleteDialog({Key key, this.result, this.turnDone, this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 100.h,
              width: 500.w,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                    color: Colors.yellow[400], width: 3.w),
              ),
              child: Text('Result',style: ThemeText.textStyle.copyWith(fontSize: 40),),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowResultWidget(
                  width: 90.w,
                  height: 90.h,
                  name: convertIntToStrAss(result[0]),
                ),
                ShowResultWidget(
                  width: 90.w,
                  height: 90.h,
                  name: convertIntToStrAss(result[1]),
                ),
                ShowResultWidget(
                  width: 90.w,
                  height: 90.h,
                  name: convertIntToStrAss(result[2]),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: player.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(
                          '${player[index].userName}',
                          style: ThemeText.textStyle.copyWith(color: Colors.black),
                        ),
                        subtitle: Text('${player[index].money}'),
                      )),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: RaisedButton(
                onPressed: turnDone,
                color: ThemColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: AppConstance.borderRadius,
                ),
                child: Text(
                  "Done",
                  style: ThemeText.textStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
