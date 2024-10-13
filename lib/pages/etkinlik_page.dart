import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_detay_page.dart';
import 'package:flutter_restapi/services/etkinlik_api.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EtkinlikPageState();
}




class _EtkinlikPageState extends State<EventPage> {
  List<Event> events = [];
  
  @override
  void initState(){
    super.initState();
    fetchEvents(); //asking the user info from the api
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İzmir Kültür Sanat Etkinlikleri',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          //final eventId = events[index].id;
          final eventName = events[index].name;
          return ListTile(
            title: Text(eventName),
            leading:ConstrainedBox(constraints: BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child:  CircleAvatar(child: Image.network(events[index].smallPoster, fit: BoxFit.cover),),
             ),
           
            
            onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder:(context) =>EtkinlikDetayPage(detailedEvent: events[index]),));
            },);
        },),
      
    );
  }
  
  
 
  
  
    Future<void> fetchEvents() async{
    final response = await EtkinlikApi.fetchEvents();
    setState(() {
      events = response;
   });
  }
  
  
}