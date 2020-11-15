import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/ngos.dart';

class HomedetailScreen extends StatelessWidget {
  static const routname = "/homedetailscreen";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final data = Provider.of<NGOs>(context).items.firstWhere((i) => id == i.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.name,
        ),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 250,
                width: double.infinity,
                child: FadeInImage(
                  placeholder: AssetImage(
                    "assets/l2.jpg",
                  ),
                  image: NetworkImage(data.imageurl),
                  fit: BoxFit.fill,
                )
                // Image.network(
                // data.imageurl,
                // fit: BoxFit.fill,
                // ),
                ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/volunteerscreen", arguments: data.id);
                  },
                  child: Card(
                    color: Colors.blueGrey[100],
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                child: Image.asset("assets/vol1.png",
                                    fit: BoxFit.fill)),
                            Text(
                              "Volunteer",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/jobscreen", arguments: data.id);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    color: Colors.amberAccent[100],
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              child: Image.asset("assets/hire1.png",
                                  fit: BoxFit.fill),
                            ),
                            Text(
                              "Hire Grana",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/donatescreen", arguments: data.id);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    color: Colors.purple[100],
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                child: Image.asset("assets/donate1.png",
                                    fit: BoxFit.fill)),
                            Text(
                              "Donate",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

//***************************************************** */
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "About Us :",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.aboutus,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                width: double.infinity,
                //color: Colors.purple[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name :",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data.name,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Contact No. :",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data.number,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Address :",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data.location,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //
//
//
      //floating button contains the location details
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        child: Icon(
          Icons.location_on,
          size: 35.0,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed("/homemapscreen", arguments: id);
        },
      ),
    );
  }
}
