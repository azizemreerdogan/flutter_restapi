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
    Provider.of<EventsProvider>(context, listen: false).fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    // Using Consumer to rebuild the UI when wishList changes
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        List<Event> wishlistedEvents = eventsProvider.wishList;
        BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Wishlist Page',
              style: TextStyle(fontSize: 25),
            ),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Etkinlik Page',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Wishlist Page',
              ),
            ],
            currentIndex: bottomNavBarProvider.currentIndex,
            onTap: (index) {
              bottomNavBarProvider.setCurrentIndex(index);
              if (index == _bottomNavigationBarPages.wishlisticon.index) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const WishListPage()));
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventPage()));
              }
            },
          ),
          body: (wishlistedEvents.isEmpty)
              ? Center(child: Text('No Element Wishlisted'))
              : ListView.builder(
                  itemCount: wishlistedEvents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(wishlistedEvents[index].name),
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child: CircleAvatar(
                          child: Image.network(
                            wishlistedEvents[index].smallPoster,
                            fit: BoxFit.cover,
                          ),
                        ),
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
  }
}

enum _bottomNavigationBarPages { etkinliklericon, wishlisticon }
