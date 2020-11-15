import 'package:flutter/material.dart';
import 'package:oldies/providerr/ngos.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:oldies/widgets/ngo_lists.dart';
import 'package:provider/provider.dart';

class NGOListScreen extends StatelessWidget {
  final String mail;
  NGOListScreen(this.mail);
  static const routname = "/ngolistscreen";
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments as String;
    final productdta = Provider.of<NGOs>(context).items;
    final slist = productdta.where((l) => l.city == arg).toList();
    bool _empty() {
      if (slist.isEmpty) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(arg,
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        actions: (mail != null && mail.contains('organiser'))
            ? <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/addngo", arguments: arg);
                    })
              ]
            : [],
      ),
      drawer: AppDrawer(),
      body: _empty()
          ? Center(
              child: Text("nothing to display here "),
            )
          : ListView.builder(
              itemCount: slist.length,
              itemBuilder: (ctx, i) => Column(
                    children: <Widget>[
                      NgoList(
                        id: slist[i].id,
                        name: slist[i].name,
                      ),
                      Divider(),
                    ],
                  )),
    );
  }
}
