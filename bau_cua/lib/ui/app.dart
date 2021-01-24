import 'package:bau_cua/bloc/game_bloc/game_bloc.dart';
import 'package:bau_cua/bloc/game_bloc/game_event.dart';
import 'package:bau_cua/injection.dart';
import 'package:bau_cua/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return ScreenUtilInit(
     designSize: Size(360, 690),
     allowFontScaling: false,
     child: MaterialApp(
       home: BlocProvider<GameBloc>(
         create:(_) => getIt<GameBloc>()..add(GameInitEvent()),
         child: HomeScreen(),

       ),
     ),
   );
  }
}