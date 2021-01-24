import 'dart:async';
import 'package:bau_cua/bloc/game_bloc/game_bloc.dart';
import 'package:bau_cua/bloc/game_bloc/game_event.dart';
import 'package:bau_cua/bloc/game_bloc/game_state.dart';
import 'package:bau_cua/common/app_constace.dart';
import 'package:bau_cua/common/theme/theme_color.dart';
import 'package:bau_cua/common/theme/theme_text.dart';
import 'package:bau_cua/ui/widget/button_place_bet.dart';
import 'package:bau_cua/ui/widget/dialog/create_user_dialog.dart';
import 'package:bau_cua/ui/widget/dialog/game_confirm_dialog.dart';
import 'package:bau_cua/ui/widget/dialog/turn_complete_dialog.dart';
import 'package:bau_cua/ui/widget/game_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';

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
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ThemColor.primaryColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child:
                  BlocConsumer<GameBloc, GameState>(listener: (context, state) {
                if (state is GameNoDataState) {
                  pauseTimer();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => CreateUserDialog(createUser: (userName) {
                            BlocProvider.of<GameBloc>(context)
                                .add(GameAddUserEvent(userName: userName));
                          }));
                } else if (state is GameCompleteState) {
                  pauseTimer();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => TurnCompleteDialog(
                            result: state.result,
                            player: state.players,
                            turnDone: () {
                              BlocProvider.of<GameBloc>(context)
                                ..add(GameInitEvent());
                              Navigator.pop(context);
                            },
                          )).then((value){
                            if (value == null){
                              BlocProvider.of<GameBloc>(context)..add(GameInitEvent());
                            }
                  });
                }else if (state is GameLoadingState) _start = 20;
                else if (state is GameInitState)  startTimer(30);;
              }, builder: (context, state) {
                if (state is GameInitState) {
                  return Column(
                    children: [
                      Visibility(
                        visible: visible,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: AppConstance.borderRadius,
                                    border: Border.all(color: Colors.white,width: 5.w),
                                  ),
                                  child: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        pauseTimer();
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
                                  child: Text('$_start',style: ThemeText.textStyle,),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Container(
                                alignment: Alignment.center,
                                height: 30.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                      color: Colors.yellow[400], width: 3.w),
                                ),
                                child: Text(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                        width: 200.w,
                        child: RaisedButton(
                          color: ThemColor.primaryColor,
                          onPressed: () {
                            pauseTimer();
                            visible = true;
                            BlocProvider.of<GameBloc>(context)
                              ..add(GameConfirmEvent());
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.amber,width: 5.w),
                            borderRadius: AppConstance.borderRadius,
                          ),
                          child: Text(
                            "Submit",
                            style: ThemeText.textStyle,
                          ),
                        ),
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

  // Timer _timer;
  // int _start = 30;
  bool visible = true;
  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           timer.cancel();
  //           visible = false;
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //         });
  //       }
  //     },
  //   );
  // }
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
  Timer _timer;
  int _start = 0;
  bool _vibrationActive = false;

  void startTimer(int timerDuration) {
    if (_timer != null) {
      _timer.cancel();
      cancelVibrate();
    }
    setState(() {
      _start = timerDuration;
    });
    const oneSec = const Duration(seconds: 1);
    print('test');
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            visible = false;
            timer.cancel();
            print('alarm');
            vibrate();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void cancelVibrate() {
    _vibrationActive = false;
    Vibration.cancel();
  }

  void vibrate() async {
    _vibrationActive = true;
    if (await Vibration.hasVibrator()) {
      while (_vibrationActive) {
        Vibration.vibrate(duration: 1000);
        await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  void pauseTimer() {
    if (_timer != null) _timer.cancel();
  }

  void unPauseTimer() => startTimer(_start);
}
