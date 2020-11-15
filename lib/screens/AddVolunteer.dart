import 'package:flutter/material.dart';
import 'package:oldies/models/volunteer.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/volunteers.dart';
//  final String time;
//   final String purpose;
//   final String location;

//   final String desc;
//   final String date;
//   final String pno;
class AddVolunteerScreen extends StatefulWidget {
  static const routname = "/addvolunteerscreen";
  @override
  _AddVolunteerScreenState createState() => _AddVolunteerScreenState();
}

class _AddVolunteerScreenState extends State<AddVolunteerScreen> {
  final _gkey = GlobalKey<FormState>();

  final _focus = FocusNode();

  final _sec = FocusNode();

  final _thrd = FocusNode();

  final _frth = FocusNode();

  final _fiv = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    _sec.dispose();
    _thrd.dispose();
    _frth.dispose();
    _fiv.dispose();
    super.dispose();
  }

  var _editedrequest = Volunteer(
      id: DateTime.now().toString(),
      nid: "",
      purpose: "",
      location: "",
      time: "",
      desc: "",
      date: "",
      pno: "");

  Future<void> _saveform() async {
    _gkey.currentState.save();
    try {
      Provider.of<Volunteers>(context, listen: false).addwork(_editedrequest);
    } catch (error) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("!!Error"),
          content: Text("An error ocuured due to somme issue "),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ngoid = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Volunteer Work",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _saveform();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _gkey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Purpose",
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focus);
                  },
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: val,
                        location: _editedrequest.location,
                        time: _editedrequest.time,
                        desc: _editedrequest.desc,
                        date: _editedrequest.date,
                        pno: _editedrequest.pno);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Location",
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _focus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_sec);
                  },
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: _editedrequest.purpose,
                        location: val,
                        time: _editedrequest.time,
                        desc: _editedrequest.desc,
                        date: _editedrequest.date,
                        pno: _editedrequest.pno);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _sec,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_thrd);
                  },
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: _editedrequest.purpose,
                        location: _editedrequest.location,
                        time: _editedrequest.time,
                        desc: _editedrequest.desc,
                        date: _editedrequest.date,
                        pno: val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Timing",
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _thrd,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_frth);
                  },
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: _editedrequest.purpose,
                        location: _editedrequest.location,
                        time: val,
                        desc: _editedrequest.desc,
                        date: _editedrequest.date,
                        pno: _editedrequest.pno);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date(DD-MM-YYYY)",
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _frth,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_fiv);
                  },
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: _editedrequest.purpose,
                        location: _editedrequest.location,
                        time: _editedrequest.time,
                        desc: _editedrequest.desc,
                        date: val,
                        pno: _editedrequest.pno);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Work Description",
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  focusNode: _fiv,
                  onSaved: (val) {
                    _editedrequest = Volunteer(
                        id: _editedrequest.id,
                        nid: ngoid,
                        purpose: _editedrequest.purpose,
                        location: _editedrequest.location,
                        time: _editedrequest.time,
                        desc: val,
                        date: _editedrequest.date,
                        pno: _editedrequest.pno);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
