import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/etkinlik_detay_page.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/providers/bottom_nav_bar_provider.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the wishlist when the page is initialized
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      Provider.of<EventsProvider>(context, listen: false).fetchWishlist(user.uid);
    }
    
  }
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // Fetch the wishlist when the page is initialized
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
    Provider.of<EventsProvider>(context, listen: false).fetchWishlist(user.uid);}
  }

  @override
Widget build(BuildContext context) {
  BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
  
  return Consumer<EventsProvider>(
    builder: (context, eventsProvider, child) {
      List<Event> wishlistedEvents = eventsProvider.wishList;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Wishlist Page',
            style: TextStyle(fontSize: 25),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Etkinlik Page',),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Wishlist Page')],
        currentIndex: bottomNavBarProvider.currentIndex,
        onTap: (index) {
          bottomNavBarProvider.setCurrentIndex(index);
          if(index == _bottomNavigationBarPages.etkinliklericon.index){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage() ));
          }
        },),
        
        body: (wishlistedEvents.isEmpty)
            ? Center(child: Text('No Element Wishlisted'))
            : ListView.builder(
                itemCount: wishlistedEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(wishlistedEvents[index].name ?? ''),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(wishlistedEvents[index].smallPoster ?? ''),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EtkinlikDetayPage(detailedEvent: wishlistedEvents[index]),
                        ),
                      );
                    },
                  );
                },
              ),
      );
    },
  );
}}

enum _bottomNavigationBarPages {etkinliklericon, wishlisticon}