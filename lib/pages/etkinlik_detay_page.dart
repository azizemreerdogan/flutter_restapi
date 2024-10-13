import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';

class EtkinlikDetayPage extends StatelessWidget {
  final Event detailedEvent;
  //final Event copyEvent = Event.fromEvent();
  const EtkinlikDetayPage({super.key, required this.detailedEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Etkinlikler'),),
      body: SingleChildScrollView(
        child: Column(children:
         [Text(detailedEvent.name,style: TextStyle(fontSize: 25),),Image.network(detailedEvent.picture)],
         ),),);
  }
}