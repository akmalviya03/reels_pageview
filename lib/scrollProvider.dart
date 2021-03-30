import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier{

  bool scrollable = true;
  void updateScrollable({bool scrollValue}){
    scrollable = scrollValue;
    notifyListeners();
  }
}