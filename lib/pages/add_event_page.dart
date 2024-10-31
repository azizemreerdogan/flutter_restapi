import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key,});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  
  final TextEditingController _etkinlikIsmi = TextEditingController();
  final TextEditingController _etkinlikZamani = TextEditingController();
  final TextEditingController _etkinlikMekani = TextEditingController();
  @override
  
  Widget build(BuildContext context) {
    final EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlik Ekle',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Text('Etkinlik ismi'),
          TextField(controller: _etkinlikIsmi,),
          Text('Etkinlik Mekani'),
          TextField(controller: _etkinlikMekani,),
          Text('Etkinlik Zamani'),
          TextField(controller: _etkinlikZamani),
          SizedBox(height: 25,),
          ElevatedButton(
            onPressed:(){
               Event newEvent = eventsProvider.eventCreator(_etkinlikIsmi.toString(),
               _etkinlikMekani.toString(),_etkinlikZamani.toString());
               eventsProvider.toggleEvent(newEvent);
               
               },
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
            child: Text('Etkinlik Ekle'),)
        ],
      ),
    );
  }
}