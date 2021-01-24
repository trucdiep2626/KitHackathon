import 'dart:math';
import 'package:bau_cua/bloc/game_bloc/game_event.dart';
import 'package:bau_cua/bloc/game_bloc/game_state.dart';
import 'package:bau_cua/model/bet.dart';
import 'package:bau_cua/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  List<int> result;
  List<int> countAppear;
  List<User> players;
  int indexUser;
  int timeSelect;

  GameBloc(
      {this.result,
      this.countAppear,
      this.players,
      this.indexUser,
      this.timeSelect});

  @override
  GameState get initialState => GameLoadingState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameAddUserEvent) {
      yield* _mapGameAddUserEventToState(event);
    } else if (event is GameInitEvent) {
      yield* _mapGameInitStateToState();
    } else if (event is GameSelectEvent) {
      yield* _mapGameSelectEventToState(event);
    } else if (event is GameSubmitEvent || timeSelect == 0) {
      yield* _mapGameSubmitEventToState(event);
    } else if (event is GameConfirmEvent) {
      yield GameConfirmState(user: players[indexUser]);
    }
  }

  ///Tạo người chơi khi vừa bắt đầu game
  Stream<GameState> _mapGameAddUserEventToState(GameAddUserEvent event) async* {
    yield GameLoadingState();
    players.add(
        User(userName: event.userName, money: 50000, betList: List<Bet>()));
    print('player : $players');
    indexUser = 0;
    yield GameInitState(time: timeSelect, user: players[indexUser]);
  }

  ///1 Người chơi cược xong
  Stream<GameState> _mapGameSubmitEventToState(GameSubmitEvent event) async* {
    yield GameLoadingState();
    if (players[indexUser].betList.isEmpty ||
        players[indexUser].betList.length == 0)
      yield GameInitState(time: timeSelect, user: players[indexUser]);
    else if (indexUser == players.length - 1) {
      randomResult();
      print('List result : $result');
      getCountAppear();
      updateMoney();
      resetListSelect();
      updateCountAppear();
      deleteUser();
      indexUser = 0;
      if (players.isEmpty || players.length == 0 || players == null) {
        print('player null');
        yield GameNoDataState();
      } else {
        print('player not null');
        yield GameCompleteState(players: players, result: result);
      }
    } else {
      indexUser++;
      yield GameInitState(time: timeSelect, user: players[indexUser]);
    }
  }

  ///Người chơi cược
  Stream<GameState> _mapGameSelectEventToState(GameSelectEvent event) async* {
    yield GameLoadingState();
    if (event.money <= 50000 && getMoneyBet() + event.money <= 50000) {
      betTurn(event.index, event.money);
    }
    yield GameInitState(time: timeSelect, user: players[indexUser]);
  }

  Stream<GameState> _mapGameInitStateToState() async* {
    yield GameLoadingState();
    if (players.isEmpty || players.length == 0) {
      yield GameNoDataState();
    } else
      yield GameInitState(time: timeSelect, user: players[indexUser]);
  }

  /// Lượt cược
  void betTurn(int indexSelect, int betMoney) {
    players[indexUser].betList.add(Bet(index: indexSelect, money: betMoney));
  }

  ///Tổng số tiền cược đang có
  int getMoneyBet() {
    print('get money bet');
    int money = 0;
    players[indexUser].betList.forEach((element) {
      money += element.money;
    });
    return money;
  }

  /// Xóa người chơi đã hết tiền
  void deleteUser() {
    print('delete user');
    players.removeWhere((element) => element.money == 0);
    print('delete user complete');
  }

  ///Reset list select
  void resetListSelect() {
    for (int i = 0; i < players.length; i++) {
      players[i].betList = List<Bet>();
    }
  }

  ///Random
  void randomResult() {
    for (int i = 0; i < result.length; i++) result[i] = next(0, 5);
  }

  Random _random = Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  /// Đếm số lần xuất hiện của một con
  void getCountAppear() {
    print('get count appear');
    for (int i = 0; i < countAppear.length; i++) {
      for (int j = 0; j < result.length; j++) {
        if (i == result[j]) countAppear[i]++;
      }
    }
  }

  ///Cập nhật lại tiền của người chơi
  void updateMoney() {
    print('update money');
    print('players size ${players.length}');
    for (int i = 0; i < players.length; i++) {
      print('player $i');
      print('user name : ${players[i].userName}');
      print('money : ${players[i].money}');
      print('get money : ${players[i].updateMoney(countAppear)}');
      User user = User(
          userName: players[i].userName,
          money: (players[i].updateMoney(countAppear) < 0)
              ? 0
              : players[i].updateMoney(countAppear));
      print('new user : ${user.userName} ${user.money}');
      players[i] = user;
    }
    print('update money complete');
  }

  ///Đưa danh sách số lần xuất hiện về giá trị ban đầu
  void updateCountAppear() {
    print('update count appear');
    countAppear.clear();
    countAppear = [0, 0, 0, 0, 0, 0];
  }
}
