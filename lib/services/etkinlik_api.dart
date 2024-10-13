import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/event.dart';
import 'package:http/http.dart' as http;

class EtkinlikApi {
  static Future<List<Event>> fetchEvents() async{
    debugPrint('Users fetched');
    const url = 'https://openapi.izmir.bel.tr/api/ibb/kultursanat/etkinlikler';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final eventResults = json as List<dynamic>;
    //.map(e) is used for traversing the eventResults list and transforming its
    //values into new objects of the Event class.
    final transformed = eventResults.map((e) {
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
        ticketSaleLink: e['BiletSatisLinki']
      );
    }).toList();
    
    return transformed;
  }
}