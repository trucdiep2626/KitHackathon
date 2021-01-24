import 'package:bau_cua/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GameState extends Equatable {
}
class GameInitState extends GameState{
  final int time;
  final User user;

  GameInitState({@required this.time,@required this.user});
  @override
  List<Object> get props => [time,user];
}

class GameLoadingState extends GameState {
  @override
  List<Object> get props => [];
}
class GameCompleteState extends GameState{
  final List<User> players;
  final List<int> result;

  GameCompleteState({@required this.players,@required this.result});
  @override
  List<Object> get props => [players];
}

class GameNoDataState extends GameState {
  @override
  List<Object> get props => [];

}
class GameConfirmState extends GameState {
  final User user;

  GameConfirmState({this.user});

  @override
  List<Object> get props => [];
}