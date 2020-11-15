import 'package:flutter/cupertino.dart';

import 'package:oldies/models/volunteer.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Volunteers with ChangeNotifier {
  List<Volunteer> _vitems = [];

  List<Volunteer> get vitems {
    return _vitems;
  }

  final String authToken;
  final String usermail;
  Volunteers(this.authToken, this._vitems, this.usermail);

  Future<void> addwork(Volunteer vol) async {
    final url =
        'https://oldus-821b7.firebaseio.com/volunteers.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          "purpose": vol.purpose,
          "date": vol.date,
          "desc": vol.desc,
          "location": vol.location,
          "time": vol.time,
          "pno": vol.pno,
          "nid": vol.nid,
        }));

    final newdata = Volunteer(
        id: json.decode(response.body)['name'],
        nid: vol.nid,
        purpose: vol.purpose,
        location: vol.location,
        time: vol.time,
        desc: vol.desc,
        date: vol.date,
        pno: vol.pno);

    _vitems.add(newdata);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url =
        'https://oldus-821b7.firebaseio.com/volunteers.json?auth=$authToken';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Volunteer> loadedrequest = [];

    extractedData.forEach((key, val) {
      loadedrequest.add(Volunteer(
        id: key,
        purpose: val['purpose'],
        date: val['date'],
        nid: val['nid'],
        desc: val['desc'],
        location: val["location"],
        pno: val["pno"],
        time: val["time"],
      ));
    });

    _vitems = loadedrequest;
    notifyListeners();
  }

  Future<void> deleteProds(String idd) async {
    final url =
        'https://oldus-821b7.firebaseio.com/donate/$idd.json?auth=$authToken';
    _vitems.removeWhere((prod) => prod.id == idd);

    await http.delete(url);
    notifyListeners();
  }
}
