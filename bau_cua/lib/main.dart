import 'package:bau_cua/bloc/simple_bloc_delegate.dart';
import 'package:bau_cua/injection.dart';
import 'package:bau_cua/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  configureDependency();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(App()));
}

