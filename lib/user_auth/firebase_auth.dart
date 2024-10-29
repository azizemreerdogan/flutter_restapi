import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';

class AuthService {
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context}) async{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
        
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => EventPage() ));
        
        
      }on FirebaseAuthException catch(e){
          debugPrint('There is an error');
      }
    }
    
    Future<void> signOut() async{
      await FirebaseAuth.instance.signOut();
    }
    
    
}