import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/services/etkinlik_api.dart';

class EventsProvider extends ChangeNotifier{
  List<Event> eventsFetched = [];
  
  
  Future<void> fetchEvents() async{
    final response = await EtkinlikApi.fetchEvents();
    eventsFetched = response;
    debugPrint('fetchEvents called');
    notifyListeners();
  }
  
  
}