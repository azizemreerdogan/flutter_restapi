import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/pages/sign_in_page.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  
  

  String? getAccountId(){
    User? user = _authInstance.currentUser;
    debugPrint(user?.uid);
    return user?.uid;
    
  }
  
  
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context}) async{
      try{
        await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
        
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => EventPage() ));
        
        
      }on FirebaseAuthException catch(e){
          debugPrint('There is an error');
      }
    }
    
    Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context}) async{
      try{
        UserCredential userCredential = await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
        final userId = userCredential.user!.uid;
        
        await Future.delayed(Duration(seconds: 1));
        Provider.of<EventsProvider>(context,listen: false).fetchWishlist(userId);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => EventPage() ));
        
        
      }on FirebaseAuthException catch(e){
          debugPrint('There is an error');
      }
    }
    
    Future<void> signOut(BuildContext context, EventsProvider eventsProvider) async{
      await FirebaseAuth.instance.signOut();
      //EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
      eventsProvider.clearWishList();
      Navigator.of(context).pushReplacementNamed('/signin');
    }
    
    
}