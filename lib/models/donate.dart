import 'package:flutter/cupertino.dart';

class Donate {
  final String did;
  final String dname;
  final String ditem;

  final String phno;
  final String msg;
  String imageurl;
  final String daddress;
  final String nid;
  Donate({
    @required this.did,
    @required this.dname,
    @required this.ditem,
    @required this.daddress,
    @required this.imageurl,
    @required this.msg,
    @required this.nid,
    @required this.phno,
  });
}
