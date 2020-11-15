import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/jobs.dart';

class JobTile extends StatelessWidget {
  final String jid;
  JobTile(this.jid);
  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<Jobs>(context, listen: false).jitem;
    final data = itemslist.firstWhere((i) => i.jid == jid);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      //maxRadius: 40,
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        data.imageurl,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Name :",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        data.name,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Service :",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        data.service,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
