import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

Future<String> setUserName (name) async{
   SharedPreferences prf= await SharedPreferences.getInstance();
   prf.setString("userName", name);
}
Future<String> getUserName () async{
  SharedPreferences prf= await SharedPreferences.getInstance();
  String userName=prf.getString("userName");
  return userName;
}