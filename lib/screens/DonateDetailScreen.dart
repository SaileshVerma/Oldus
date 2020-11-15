import 'package:flutter/material.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/donator.dart';

class DonateDetailScreen extends StatelessWidget {
  static const routname = "/donatedetailscreen";
  @override
  Widget build(BuildContext context) {
    final did = ModalRoute.of(context).settings.arguments as String;
    final dlistdata = Provider.of<Donator>(context, listen: false).dlist;
    final data = dlistdata.firstWhere((i) => i.did == did);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.delete),
        //       onPressed: () {
        //         Provider.of<Donator>(context, listen: false)
        //             .deleteProds(data.did);
        //         Navigator.of(context).pop();
        //       })
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: FadeInImage(
                  placeholder: AssetImage(
                    "assets/l2.jpg",
                  ),
                  image: NetworkImage(data.imageurl),
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              "Item :",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              data.ditem,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Person Name :",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              data.dname,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Donater Address :",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              data.daddress,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Contact Number :",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              data.phno,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
