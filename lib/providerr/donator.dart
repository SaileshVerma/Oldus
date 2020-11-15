import 'package:flutter/cupertino.dart';
import 'package:oldies/models/donate.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Donator with ChangeNotifier {
  List<Donate> _dlist = [
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "jignesh",

    //     ///date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Manglesh",
    //     // date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Jagga",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Tomu",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
  ];

  List<Donate> get dlist {
    return _dlist;
  }

  final String authToken;
  final String usermail;
  Donator(this.authToken, this._dlist, this.usermail);
  Future<void> addrequest(Donate dd) async {
    final url =
        'https://oldus-821b7.firebaseio.com/donate.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          "name": dd.dname,
          "daddress": dd.daddress,
          "number": dd.phno,
          "nid": dd.nid,
          "message": dd.msg,
          "imageurl": dd.imageurl,
          "ditem": dd.ditem,
        }));

    final newRequest = Donate(
      did: json.decode(response.body)['name'],
      dname: dd.dname,
      daddress: dd.daddress,
      phno: dd.phno,
      nid: dd.nid,
      msg: dd.msg,
      ditem: dd.ditem,
      imageurl: dd.imageurl,
    );

    _dlist.add(newRequest);

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url =
        'https://oldus-821b7.firebaseio.com/donate.json?auth=$authToken';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Donate> loadedrequest = [];

    extractedData.forEach((key, val) {
      loadedrequest.add(Donate(
        did: key,
        imageurl: val['imageurl'],
        daddress: val['daddress'],
        ditem: val['ditem'],
        dname: val['name'],
        msg: val['message'],
        nid: val['nid'],
        phno: val['number'],
      ));
    });

    _dlist = loadedrequest;
    notifyListeners();
  }

  Future<void> deleteProds(String idd) async {
    final url =
        'https://oldus-821b7.firebaseio.com/donate/$idd.json?auth=$authToken';
    _dlist.removeWhere((prod) => prod.did == idd);

    await http.delete(url);
    notifyListeners();
  }
}
