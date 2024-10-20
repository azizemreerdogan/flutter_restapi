import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/services/etkinlik_api.dart';

class EventsProvider extends ChangeNotifier{
  List<Event> eventsFetched = [];
  List<Event> wishList = [];
  
  Future<void> fetchEvents() async{
    final response = await EtkinlikApi.fetchEvents();
    eventsFetched = response;
    debugPrint('fetchEvents called');
    notifyListeners();
  }
  
  void toggleWishlist(Event event){
    debugPrint('addToWishlist called');
    if(wishList.contains(event)){
      wishList.remove(event);
    }else{
      wishList.add(event);
    }
    notifyListeners();
    
  }
  
  bool isWishlisted(Event event){
    if(wishList.contains(event)){
      return true;
    }else{
      return false;
    }
  }
  
  
}