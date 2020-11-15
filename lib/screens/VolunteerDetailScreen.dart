import 'package:flutter/material.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/volunteers.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerDetailScreen extends StatelessWidget {
  static const routname = "/volunteerdetailscreen";

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vid = ModalRoute.of(context).settings.arguments as String;
    final vlist = Provider.of<Volunteers>(context, listen: false).vitems;
    final data = vlist.firstWhere((i) => i.id == vid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        title: Text(
          data.purpose,
          style: TextStyle(fontSize: 22),
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Purpose:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              data.purpose,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Work Description:",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data.desc,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Location:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              data.location,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Timing:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              data.time,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
          onPressed: () {
            customLaunch('sms:' + data.pno);
          },
          label: Text(
            "I accept This Work ",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
    );
  }
}
