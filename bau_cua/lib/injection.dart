import 'package:bau_cua/bloc/game_bloc/game_bloc.dart';
import 'package:bau_cua/model/game_model.dart';
import 'package:bau_cua/model/user.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void configureDependency() {
  getIt.registerFactory<List<User>>(() => List<User>());
  getIt.registerFactory(() => GameModel());
  getIt.registerFactory<GameBloc>(() => GameBloc(
      result: List(3),
      indexUser: -1,
      timeSelect: 20,
      countAppear: [0, 0, 0, 0, 0, 0],players: List<User>()));
}
