import 'package:flutter/material.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/providers/bottom_nav_bar_provider.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Your generated firebase_options.dart file
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Using your firebase_options
  );
  
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create:(context) => EventsProvider()),
    ChangeNotifierProvider(create: (context) => BottomNavBarProvider())
  ],
  child: MainApp(),)
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EventPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


