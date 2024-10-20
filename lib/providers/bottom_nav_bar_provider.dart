import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier{
  int _currentIndex = 0;
  
  void setCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}