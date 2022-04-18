import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:Zenith/model/search.dart';

class PlayersViewModel {
   static List<SearchData>? players;

  static Future loadLocalSearch() async {
    try {
      players = [];
      String jsonString = await rootBundle.loadString('assets/json/search.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['search'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        players!.add(new SearchData.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}