import 'package:bau_cua/common/app_constace.dart';

String convertIntToStrAss(int index){
  switch(index){
    case 0 : return AppConstance.bau;break;
    case 1 : return AppConstance.cua;break;
    case 2 : return AppConstance.tom;break;
    case 3 : return AppConstance.ca;break;
    case 4 : return AppConstance.nai;break;
    case 5 : return AppConstance.ga;break;
    default : return null;break;
  }
}