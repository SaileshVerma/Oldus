import 'package:flutter/material.dart';

class NgoList extends StatelessWidget {
  final String id;
  final String name;

  NgoList({this.id, this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed("/homedetailscreen", arguments: id);
            },
            title: Text(name),
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
              child: Text(name[0].toUpperCase()),
            )));
  }
}
