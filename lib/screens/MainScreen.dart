import 'package:flutter/material.dart';
import 'package:oldies/widgets/city_grid_view.dart';
import 'package:oldies/widgets/decolist.dart';
import 'package:oldies/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/ngos.dart';

class MainScreen extends StatefulWidget {
  static const routname = "/mainscreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isinit = true;
  var _isloading = false;
  void showErrDialaog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An error occur"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });
      try {
        Provider.of<NGOs>(context).fetchAndSetData().then((_) {
          setState(() {
            _isloading = false;
          });
        });
      } catch (error) {
        showErrDialaog("An Error Occured Please Try Again");
      }
    }
    _isinit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Oldus",
            style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              // direction: Axis.vertical,
              children: <Widget>[
                DecoListView(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Major Popular Cities ",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child:
                        Image.asset("assets/bannerUSE.png", fit: BoxFit.fill),
                  ),
                ),
                CityGridView(),
              ],
            ),
    );
  }
}
