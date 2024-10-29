import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/services/etkinlik_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventsProvider extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Event> eventsFetched = [];
  List<Event> wishList = [];
  
  Future<void> fetchEvents() async{
    final response = await EtkinlikApi.fetchEvents();
    eventsFetched = response;
    debugPrint('fetchEvents called');
    notifyListeners();
  }
  
   Future<void> fetchWishlist(String userId) async {
    debugPrint('Fetching wishlist...');
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('wishlist')
          .get();

      debugPrint('Documents found: ${snapshot.docs.length}'); // Print the number of documents found
      if (snapshot.docs.isNotEmpty) {
        wishList = snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList();
      } else {
        wishList = []; // Set to empty if no documents found
      }

      notifyListeners(); // Notify listeners of changes
    } catch (e) {
      debugPrint('Error fetching wishlist: $e'); // Log any errors
    }
  }

  
  Future<void> toggleWishlist(Event event) async{
    debugPrint('toggleWishlist called');
    if(wishList.any((e) => e.id == event.id)){
      await _firestore.collection('wishlist').doc(event.id.toString()).delete();
      await _firestore.collection('wishlist').doc(event.id.toString()).update({'wishlistedCount': FieldValue.increment(-1)});
      wishList.removeWhere((e) =>e.id == event.id);
    }else{
      await _firestore.collection('wishlist').doc(event.id.toString()).set(event.toMap());
      await _firestore.collection('wishlist').doc(event.id.toString()).update({'wishlistedCount': FieldValue.increment(1)});
      wishList.add(event);
      
    }
    notifyListeners();
    
  }
  
  bool isWishlisted(Event event){
    return wishList.any((element) => element.id == event.id);
  }
  
  
}