import 'package:flutter/material.dart';

class ReplyProvider extends ChangeNotifier{
  String _userName = "";
  String _postId="";
  String _userAvatar="";
  String _userId="";
  String _documentId="";
  bool _autoFocus=false;

  void updateUserName({String userName}){
    _userName = userName;
    notifyListeners();
  }
  String getUserName(){
    return _userName;
  }


  void updatePostId({String postId}){
    _postId = postId;
    notifyListeners();
  }
  String getPostId(){
    return _postId;
  }

  void updateUserAvatar({String userAvatar}){
    _userAvatar = userAvatar;
    notifyListeners();
  }
  String getUserAvatar(){
    return _userAvatar;
  }

  void updateUserId({String userId}){
    _userId = userId;
    notifyListeners();
  }
  String getUserId(){
    return _userId;
  }

  void updateDocumentId({String documentId}){
    _documentId = documentId;
    notifyListeners();
  }
  String getDocumentId(){
    return _documentId;
  }

  void updateAutoFocus({bool setAutoFocus}){
    _autoFocus = setAutoFocus;
    notifyListeners();
  }
  bool getAutoFocus(){
    return _autoFocus;
  }
}