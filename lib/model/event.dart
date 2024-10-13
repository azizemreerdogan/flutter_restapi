class Event{
  int? id;
  late String name;
  String? genre;
  late String smallPoster;
  late String picture;
  String? details;
  String? eventUrl;
  String? startDate;
  String? finishDate;
  String? eventPlace;
  String? ticketSaleLink;
  bool? isFree;
  
  
  Event({
    required this.id,
    required this.name,
    required this.genre,
    required this.smallPoster,
    required this.picture,
    required this.details,
    required this.eventUrl,
    required this.startDate,
    required this.finishDate,
    required this.eventPlace,
    required this.ticketSaleLink,
    required this.isFree,
  });
  
  Event.fromEvent(Event e){
    Event(details: e.details, eventPlace: e.eventPlace, eventUrl: e.eventUrl,finishDate: e.finishDate,genre: e.genre,id: e.id,isFree: e.isFree, name: e.name,picture: e.picture,
    smallPoster: e.smallPoster,startDate: e.startDate, ticketSaleLink: e.ticketSaleLink,);
  }
}