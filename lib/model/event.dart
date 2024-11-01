class Event{
  final int?  id;
  final String? name;
  final String? genre;
  final String? smallPoster;
  final String? picture;
  final String? details;
  final String? eventUrl;
  final String? startDate;
  final String? finishDate;
  final String? eventPlace;
  int wishlistedCount = 0;
  //final String? ticketSaleLink;
  bool? isFree;
  
  
  Event({
    this.id,
    this.name,
    this.genre,
    this.smallPoster,
    this.picture,
    this.details,
    this.eventUrl,
    this.startDate,
    this.finishDate,
    this.eventPlace,
    this.isFree,
    this.wishlistedCount = 0

  });
  
  factory Event.fromJson(Map<String, dynamic> e){
    return Event(
        id: e['Id'],
        genre: e['Tur'],
        name: e['Adi'],
        startDate: e['EtkinlikBaslamaTarihi'],
        picture: e['Resim'],
        details: e['KisaAciklama'],
        eventPlace: e['EtkinlikMerkezi'],
        eventUrl: e['EtkinlikUrl'],
        finishDate: e['EtkinlikBitisTarihi'],
        isFree: e['UcretsizMi'],
        smallPoster: e['KucukAfis'],
        wishlistedCount: e['wishlistedCount'] ?? 0,
        
      );
  }
  
    // Converts Event instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Adi': name,
      'Tur': genre,
      'Resim': picture,
      'KisaAciklama': details,
      'EtkinlikUrl': eventUrl,
      'EtkinlikBaslamaTarihi': startDate,
      'EtkinlikBitisTarihi': finishDate,
      'EtkinlikMerkezi': eventPlace,
      'KucukAfis': smallPoster,
      'UcretsizMi': isFree,
      'wishlistedCount': wishlistedCount,
    };
  }
}

  
