import 'package:bau_cua/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GameEvent extends Equatable {
}
class GameInitEvent extends GameEvent {

  GameInitEvent();
  @override
  List<Object> get props => [];
}
class GameSelectEvent extends GameEvent {
  final User user;
  final int index;
  final int money;


  GameSelectEvent({@required this.user,@required this.index,@required this.money});
  @override
  List<Object> get props => [];
}
class GameSubmitEvent extends GameEvent {

  @override
  List<Object> get props => [];
}
class GameConfirmEvent extends GameEvent {
  @override
  List<Object> get props => [];

}
class GameAddUserEvent extends GameEvent {
  final String userName;

  GameAddUserEvent({@required this.userName});
  @override
  List<Object> get props =>[];

}