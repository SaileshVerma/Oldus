import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oldies/models/ngo.dart';
import 'package:http/http.dart' as http;

class NGOs with ChangeNotifier {
  List<NGO> _items = [];

  List<NGO> get items {
    return _items;
  }

  final String authToken;
  final String usermail;
  NGOs(this.authToken, this._items, this.usermail);

  Future<void> addrequest(NGO ngo) async {
    final url =
        'https://oldus-821b7.firebaseio.com/request.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          "name": ngo.name,
          "city": ngo.city,
          "number": ngo.number,
          "location": ngo.location,
          "aboutus": ngo.aboutus,
          "imageurl": ngo.imageurl,
          "latitude": ngo.latitude,
          "longitude": ngo.longitude,
        }));

    final newRequest = NGO(
        id: json.decode(response.body)['name'],
        name: ngo.name,
        city: ngo.city,
        number: ngo.number,
        location: ngo.location,
        aboutus: ngo.aboutus,
        imageurl: ngo.imageurl,
        latitude: ngo.latitude,
        longitude: ngo.longitude);

    _items.add(newRequest);

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url =
        'https://oldus-821b7.firebaseio.com/request.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      final List<NGO> loadedrequest = [];

      extractedData.forEach((key, val) {
        loadedrequest.add(NGO(
            id: key,
            name: val['name'],
            city: val['city'],
            number: val['number'],
            location: val['location'],
            aboutus: val['aboutus'],
            imageurl: val['imageurl'],
            latitude: val['latitude'],
            longitude: val['longitude']));
      });

      _items = loadedrequest;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProds(String idd) async {
    final url =
        'https://oldus-821b7.firebaseio.com/donate/$idd.json?auth=$authToken';
    _items.removeWhere((prod) => prod.id == idd);

    await http.delete(url);
    notifyListeners();
  }
}
