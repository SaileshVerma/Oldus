import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldies/models/city.dart';

class Cities with ChangeNotifier {
  List<City> _citylist = [
    City(
      city: "Delhi",
      color: Colors.amber,
    ),
    City(city: "Banglore", color: Colors.pink[100]),
    City(city: "Rajasthan", color: Colors.lime),
    City(city: "Chennai", color: Colors.blue[200]),
    City(city: "Gujarat", color: Colors.amberAccent),
    City(city: "International", color: Colors.green[400]),
    City(city: "Other", color: Colors.deepOrangeAccent)
  ];

  List<City> get citylist {
    return _citylist;
  }
}
