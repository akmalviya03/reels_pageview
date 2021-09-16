import 'package:flutter/material.dart';

class ReplyProvider extends ChangeNotifier{
  String _userName = "";
  bool _autoFocus=false;
  void updateUserName({String userName}){
    _userName = userName;
    notifyListeners();
  }
  String getUserName(){
    return _userName;
  }

  void updateAutoFocus({bool setAutoFocus}){
    _autoFocus = setAutoFocus;
    notifyListeners();
  }
  bool getAutoFocus(){
    return _autoFocus;
  }
}