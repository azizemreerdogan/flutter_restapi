import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/services/etkinlik_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_restapi/user_auth/firebase_auth.dart';


class EventsProvider extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Event> eventsFetched = [];
  List<Event> wishList = [];
  String ?userId;
  
  EventsProvider({required this.userId});
  
  Future<void> toggleEvent(Event newEvent) async{
    
    if(!eventsFetched.any((element) => element.id == newEvent.id,)){
      eventsFetched.add(newEvent);
      
    }else{
      debugPrint('Event is still there');
    }
  }
  
  Future<void> addEventsToFirestore() async{
    try {
    for (var event in eventsFetched) {
      final eventDocRef = _firestore.collection('all_events').doc(event.id.toString());

      // Only add the event if it doesn't already exist in Firestore
      final docSnapshot = await eventDocRef.get();
      if (!docSnapshot.exists) {
        await eventDocRef.set(event.toMap());
        debugPrint('Event ${event.name} added to Firestore.');
      } else {
        debugPrint('Event ${event.name} already exists.');
      }
    }
  } catch (e) {
    debugPrint('Error saving events: $e');
  }

  }
  
  Future<void> fetchEvents() async{
    final response = await EtkinlikApi.fetchEvents();
    eventsFetched = response;
    debugPrint('fetchEvents called');
    
    
    
    notifyListeners();
  }
  
   Future<void> fetchWishlist(String userId) async {
    debugPrint('Fetching wishlist...');
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .get();

      debugPrint('Documents found: ${snapshot.docs.length}'); // Print the number of documents found
      
      wishList.clear();
      
      for(var doc in snapshot.docs){
        final eventId =await doc.data()['eventId'];
        final eventDoc =await _firestore.collection('all_users').doc(eventId.toString()).get();
        
        if(eventDoc.exists){
          wishList.add(Event.fromJson(eventDoc.data()!));
        }
      }
      

      notifyListeners(); // Notify listeners of changes
    } catch (e) {
      debugPrint('Error fetching wishlist: $e'); // Log any errors
    }
  }

  
  Future<void> toggleWishlist(Event event) async{
    final docRef = _firestore.collection('users').doc(userId)
    .collection('wishlist').doc(event.id.toString());
    debugPrint('toggleWishlist called');
    if(wishList.any((e) => e.id == event.id)){
      await docRef.update({'wishlistedCount': FieldValue.increment(-1)});
      await docRef.delete();
      wishList.removeWhere((e) =>e.id == event.id);
      
    }else if(!wishList.any((e) => e.id == event.id)){
      await docRef.set({'eventId': event.id});
      await docRef.update({'wishlistedCount': FieldValue.increment(1)});
      wishList.add(event);
      
    }
    notifyListeners();
    
  }
  
  bool isWishlisted(Event event){
    
    for (var element in wishList) {
      if(element.id == event.id){
        return true;
      }
    }
    
    return false;
  }
  
  void clearWishList(){
    wishList.clear();
    notifyListeners();
  }
  
  Event eventCreator(String etkinlikIsmi, String etkinlikMekani,
   String etkinlikZamani){
    Random rnd = Random();
    Event newEvent = Event(id: rnd.nextInt(7000) + 6000, name: etkinlikIsmi,
     eventPlace: etkinlikMekani, startDate: etkinlikZamani); 
    return newEvent;
  }
  
  
}