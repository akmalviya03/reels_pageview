import 'package:flutter/material.dart';

class ReplyProvider extends ChangeNotifier{
  String _userName = "";
  String _parentDocumentId="";
  bool _autoFocus=false;

  void updateUserNameAndParentDocumentId({String userName,String parentDocumentId}){
    _userName = userName;
    _parentDocumentId = parentDocumentId;
    notifyListeners();
  }
  String getUserName(){
    return _userName;
  }

  String getParentDocumentId(){
    return _parentDocumentId;
  }

  void updateAutoFocus({bool setAutoFocus}){
    _autoFocus = setAutoFocus;
    notifyListeners();
  }
  bool getAutoFocus(){
    return _autoFocus;
  }
}