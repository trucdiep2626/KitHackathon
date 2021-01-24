import 'package:bau_cua/model/bet.dart';

class User {
  String userName;
  int money;
  List<Bet> betList;

  User({this.userName, this.money,this.betList});

  int updateMoney(List result){
    print('up date money');
    for( int i = 0 ; i < betList.length; i++){
      print('${result[betList[i].index]}');
      if (result[betList[i].index] != 0){
        money += betList[i].money * result[betList[i].index];
      }else {
        money -= betList[i].money;
      }
    }
    betList.clear();
    print('update money succes');
    return money;
  }
}