import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_detay_page.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/providers/bottom_nav_bar_provider.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    List<Event> wishlistedEvents = eventsProvider.wishList;
    BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Etkinlik Page'),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Wishlist Page')],
        currentIndex: _bottomNavigationBarPages.wishlisticon.index,
        onTap: (index) {
          bottomNavBarProvider.setCurrentIndex(index);
          if(index == _bottomNavigationBarPages.wishlisticon.index){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WishListPage() ));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage()));
          }
        },),
      body: (wishlistedEvents.isEmpty)
      ? Center(child: Text('No Element Wishlisted'),)
      :
       ListView.builder(
        itemCount: wishlistedEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(wishlistedEvents[index].name),
            leading:ConstrainedBox(constraints: BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child:  CircleAvatar(child: Image.network(wishlistedEvents[index].smallPoster, fit: BoxFit.cover),),
             ),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder:(context) => EtkinlikDetayPage(detailedEvent: wishlistedEvents[index])));},
          );
        },
        
      ),
    );
  }
}

enum _bottomNavigationBarPages {etkinliklericon, wishlisticon}
