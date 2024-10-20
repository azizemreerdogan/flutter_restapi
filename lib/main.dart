import 'package:flutter/material.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/providers/bottom_nav_bar_provider.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
    );
  }
}


