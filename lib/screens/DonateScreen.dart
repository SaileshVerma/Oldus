import 'package:flutter/material.dart';
import 'package:oldies/providerr/donator.dart';
import 'package:oldies/widgets/donatetile.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:provider/provider.dart';

class DonateScreen extends StatefulWidget {
  static const routname = "/donatescreen";
  final String mail;
  DonateScreen(this.mail);
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Donator>(context).fetchAndSetData().then((_) {
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
    final nid = ModalRoute.of(context).settings.arguments as String;
    final jlist = Provider.of<Donator>(context, listen: false).dlist;
    final jdata = jlist.where((i) => i.nid == nid).toList();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
          title: Text("Donate Now"),
          actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed("/adddonater", arguments: nid);
                      })
                ]
          ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: jdata.length,
              itemBuilder: (ctx, i) => DonateTile(
                jdata[i].did,
              ),
            ),
    );
  }
}
