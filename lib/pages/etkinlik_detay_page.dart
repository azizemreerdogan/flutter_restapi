import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:flutter_restapi/pages/sign_in_page.dart';
import 'package:flutter_restapi/providers/events_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EtkinlikDetayPage extends StatefulWidget {
  final Event detailedEvent;
  const EtkinlikDetayPage({super.key, required this.detailedEvent});
  
  
  
  @override
  State<EtkinlikDetayPage> createState() => _EtkinlikDetayPageState();
}

class _EtkinlikDetayPageState extends State<EtkinlikDetayPage> {
  

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    bool isWishlisted = eventsProvider.isWishlisted(widget.detailedEvent);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlikler'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                widget.detailedEvent.name,
                style: const TextStyle(fontSize: 25),
              ),
              Image.network(widget.detailedEvent.picture),
              SizedBox(height: 15,),
              Text(widget.detailedEvent.startDate),
              SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  eventsProvider.toggleWishlist(widget.detailedEvent);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 60),
                  backgroundColor: isWishlisted ? Colors.red : Colors.green,
                ),
                child: Text(
                  isWishlisted ? 'İstek Listesinden Çıkar' : 'İstek Listesine Ekle',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(height: 20,),
              Text("Bu etkinliği ${widget.detailedEvent.wishlistedCount} kişi wishliste ekledi")
            ],
          ),
        ),
      ),
    );
  }
}
