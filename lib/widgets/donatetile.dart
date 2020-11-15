import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/donator.dart';

class DonateTile extends StatelessWidget {
  final String did;
  DonateTile(this.did);
  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<Donator>(context, listen: false).dlist;
    final data = itemslist.firstWhere((i) => i.did == did);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 70,
                        width: 80,
                        child: FadeInImage(
                          placeholder: AssetImage(
                            "assets/l2.jpg",
                          ),
                          image: NetworkImage(data.imageurl),
                          fit: BoxFit.cover,
                        )
                        // Image.network(
                        // data.imageurl,
                        // fit: BoxFit.cover,

                        ),
                    SizedBox(
                      width: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            data.ditem,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            data.msg,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.blue,
                              ),
                              Text(
                                data.daddress,
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Donated by " + data.dname,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed("/donatedetailscreen", arguments: did);
                      },
                      child: Text(
                        "Details",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
