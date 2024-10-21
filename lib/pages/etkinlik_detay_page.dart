import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

class EtkinlikDetayPage extends StatelessWidget {
  final Event detailedEvent;
  const EtkinlikDetayPage({super.key, required this.detailedEvent});

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Etkinlikler'),),
      body: SingleChildScrollView(
        child: Column(children:
         [Text(detailedEvent.name,style: TextStyle(fontSize: 25),),
         Image.network(detailedEvent.picture),
         SizedBox(height: 45,),
         ElevatedButton(onPressed: () {eventsProvider.toggleWishlist(detailedEvent);},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(300, 80),
            backgroundColor:eventsProvider.isWishlisted(detailedEvent)
            ? Colors.red
            : Colors.green,
            disabledIconColor: Colors.blue,
            
            ),
          child: Text('İstek Listesine Ekle',
            style: TextStyle(fontSize: 18),))
         ],
         
         ),),);
  }
}