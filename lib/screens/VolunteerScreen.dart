import 'package:flutter/material.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:oldies/widgets/volunteer_tile.dart';
// import 'package:oldies/providerr/ngos.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/volunteers.dart';

class VolunteerScreen extends StatefulWidget {
  static const routname = "/volunteerscreen";
  final String mail;
  VolunteerScreen(this.mail);

  @override
  _VolunteerScreenState createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Volunteers>(context).fetchAndSetData().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //nid is the ngo data ID  : >
    final nid = ModalRoute.of(context).settings.arguments as String;
    final item = Provider.of<Volunteers>(context).vitems;
    final voldata = item.where((i) => i.nid == nid).toList();
    return Scaffold(
      appBar: AppBar(
        actions: widget.mail.contains("organiser")
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/addvolunteerscreen", arguments: nid);
                    })
              ]
            : [],
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        title: Text("Volunteer",
            style: TextStyle(
              fontSize: 22,
            )),
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: voldata.length,
              itemBuilder: (context, i) => VolunteerTile(
                vid: voldata[i].id,
              ),
            ),
    );
  }
}
