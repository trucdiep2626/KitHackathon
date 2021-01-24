import 'dart:async';

import 'package:bau_cua/bloc/game_bloc/game_bloc.dart';
import 'package:bau_cua/bloc/game_bloc/game_event.dart';
import 'package:bau_cua/bloc/game_bloc/game_state.dart';
import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/theme/theme_color.dart';
import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/injection.dart';
import 'package:bau_cua/ui/widget/button_place_bet.dart';
import 'package:bau_cua/ui/widget/dialog/create_user_dialog.dart';
import 'package:bau_cua/ui/widget/dialog/game_confirm_dialog.dart';
import 'package:bau_cua/ui/widget/dialog/turn_complete_dialog.dart';
import 'package:bau_cua/ui/widget/game_icon_button.dart';
import 'package:bau_cua/ui/widget/show_result_widget.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTimerController _controller = new CustomTimerController();
    return Scaffold(
      backgroundColor: ThemColor.primaryColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child:
                  BlocConsumer<GameBloc, GameState>(listener: (context, state) {
                if (state is GameNoDataState) {
                  showDialog(
                      context: context,
                      builder: (_) => CreateUserDialog(createUser: (userName) {
                            BlocProvider.of<GameBloc>(context)
                                .add(GameAddUserEvent(userName: userName));
                          }));
                } else if (state is GameCompleteState) {
                  showDialog(
                      context: context,
                      builder: (_) => TurnCompleteDialog(
                            result: state.result,
                            player: state.players,
                            turnDone: () {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameInitEvent());
                              Navigator.pop(context);
                            },
                          ));
                }
              }, builder: (context, state) {
                if (state is GameInitState) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: AppConstance.borderRadius,
                                  border: Border.all(color: Colors.white,width: 5.w),
                                ),
                                child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) => CreateUserDialog(
                                                  createUser: (userName) {
                                                BlocProvider.of<GameBloc>(context)
                                                    .add(GameAddUserEvent(
                                                        userName: userName));
                                              }));
                                    }),
                              ),
                              SizedBox(
                                width: 80.w,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 20.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                      color: Colors.yellow[400], width: 3.w),
                                ),
                                child: CustomTimer(
                                  controller: _controller,
                                  from: Duration(seconds: 20),
                                  to: Duration(seconds: 0),
                                  interval: Duration(seconds: 1),
                                  builder:
                                      (CustomTimerRemainingTime remaining) {
                                    return Text(
                                      "${remaining.seconds}",
                                      style: TextStyle(fontSize: 14.sp),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 20.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                    color: Colors.yellow[400], width: 3.w),
                              ),
                              child: Text(
                                // "${state.user.userName}",
                                "${state.user.userName}",
                                style: ThemeText.textStyle
                                    .copyWith(color: Colors.black),
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          _placeBet(state),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 20.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                    color: Colors.yellow[400], width: 3.w),
                              ),
                              child: Text(
                                "${state.user.money}",
                                style: ThemeText.textStyle
                                    .copyWith(color: Colors.black),
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          SizedBox(
                            height: 40.h,
                            width: 200.w,
                            child: RaisedButton(
                              color: ThemColor.secondColor,
                              onPressed: () {
                                BlocProvider.of<GameBloc>(context)
                                  ..add(GameConfirmEvent());
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: AppConstance.borderRadius,
                              ),
                              child: Text(
                                "Submit",
                                style: ThemeText.textStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is GameConfirmState) {
                  return GameConfirmDialog(
                    result: state.user.betList,
                    submit: () {
                      BlocProvider.of<GameBloc>(context)
                        ..add(GameSubmitEvent());
                    },
                  );
                } else
                  return SizedBox();
              }))),
    );
  }

  Widget _placeBet(GameInitState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.bau),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 0, money: value));
                            },
                          ));
                }),
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.cua),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 1, money: value));
                            },
                          ));
                }),
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.tom),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 2, money: value));
                            },
                          ));
                }),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.ca),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 3, money: value));
                            },
                          ));
                }),
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.nai),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 4, money: value));
                            },
                          ));
                }),
            GameIconButton(
                width: 100.w,
                height: 100.h,
                child: Image.asset(AppConstance.ga),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => ButtonPlaceBet(
                            selectBet: (value) {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameSelectEvent(
                                    user: state.user, index: 5, money: value));
                            },
                          ));
                }),
          ],
        ),
      ],
    );
  }
}
