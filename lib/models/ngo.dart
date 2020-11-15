import 'package:flutter/material.dart';

class NGO with ChangeNotifier {
  final String id;
  String city;
  final String name;
  final String number;
  final String aboutus;
  final String location;
  String imageurl;
  double latitude;
  double longitude;

  NGO({
    @required this.id,
    @required this.name,
    @required this.city,
    @required this.number,
    @required this.location,
    @required this.aboutus,
    @required this.imageurl,
    @required this.latitude,
    @required this.longitude,
  });
}
