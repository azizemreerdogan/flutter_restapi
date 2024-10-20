import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_detay_page.dart';
import 'package:flutter_restapi/pages/wishlist_page.dart';
import 'package:flutter_restapi/providers/bottom_nav_bar_provider.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';


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
    
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);
    eventsProvider.fetchEvents(); // Fetch the events without rebuilding the widget
    
  }
  
  @override
  Widget build(BuildContext context) {
    //eventsProvider reinitiated because cannot reach the first its in initState()
    BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    events = eventsProvider.eventsFetched;
    return Scaffold(
      appBar: AppBar(
        title: Text('İzmir Kültür Sanat Etkinlikleri',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Etkinlik Page'),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Wishlist Page')],
        currentIndex: _bottomNavigationBarPages.etkinliklericon.index,
        onTap: (index) {
          bottomNavBarProvider.setCurrentIndex(index);
          if(index == _bottomNavigationBarPages.wishlisticon.index){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WishListPage() ));
          }
        },),
        
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
}

enum _bottomNavigationBarPages {etkinliklericon, wishlisticon}

