import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/convert_index_to_str_assets.dart';
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
                          style: ThemeText.textStyle,
                        ),
                        subtitle: Text('${player[index].money}'),
                      )),
            ),
            SizedBox(
              width: double.infinity,
              height: 30.h,
              child: RaisedButton(
                onPressed: turnDone,
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
