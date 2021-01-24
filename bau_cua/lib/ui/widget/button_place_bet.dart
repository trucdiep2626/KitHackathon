import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/ui/widget/game_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonPlaceBet extends StatelessWidget {
  final Function(int) selectBet;

  const ButtonPlaceBet({Key key,@required this.selectBet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GameIconButton(
                  width: 60.w,
                  child: Text(
                    "5000đ",
                    style: ThemeText.textStyle,
                  ),
                  onPressed:(){
                    selectBet(5000);
                    Navigator.pop(context);
                  }),
              GameIconButton(
                  width: 60.w,
                  child: Text(
                    "10000đ",
                    style: ThemeText.textStyle,
                  ),
                  onPressed:(){
                    selectBet(10000);
                    Navigator.pop(context);
                  }),
              GameIconButton(
                  width: 60.w,
                  child: Text(
                    "20000đ",
                    style: ThemeText.textStyle,
                  ),
                  onPressed:(){
                    selectBet(20000);
                    Navigator.pop(context);
                  }),
              GameIconButton(
                  width: 60.w,
                  child: Text(
                    "50000đ",
                    style: ThemeText.textStyle,
                  ),
                  onPressed:(){
                    selectBet(50000);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
    );
  }
}