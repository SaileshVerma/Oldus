import 'package:flutter/cupertino.dart';

class Volunteer {
  final String nid;
  final String time;
  final String purpose;
  final String location;
  final String id;
  final String desc;
  final String date;
  final String pno;

  Volunteer({
    @required this.id,
    @required this.nid,
    @required this.purpose,
    @required this.location,
    @required this.time,
    @required this.desc,
    @required this.date,
    @required this.pno,
  });
}
