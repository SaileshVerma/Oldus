import 'package:oldies/models/donate.dart';
import 'package:oldies/widgets/image_input.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:provider/provider.dart';
import 'package:oldies/providerr/donator.dart';

class AddDonater extends StatefulWidget {
  static const routname = "/adddonater";
  @override
  _AddDonaterState createState() => _AddDonaterState();
}

class _AddDonaterState extends State<AddDonater> {
  final _gkey = GlobalKey<FormState>();
  final frst = FocusNode();
  final sec = FocusNode();
  final thrd = FocusNode();
  final frth = FocusNode();
  var _isloading = false;
  File _userImage;
  @override
  void dispose() {
    frst.dispose();
    sec.dispose();
    thrd.dispose();
    frth.dispose();
    super.dispose();
  }

  var _editedRequest = Donate(
      did: DateTime.now().toString(),
      dname: "",
      ditem: "",
      daddress: "",
      imageurl: "",
      msg: "",
      nid: "",
      phno: "");

  void _pickedImage(File image) async {
    setState(() {
      _userImage = image; //for getting the image form the widgets
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child("donater_images")
        .child(DateTime.now().toString() + ".jpg");

    await ref.putFile(_userImage).onComplete;
    final url = await ref.getDownloadURL();

    setState(() {
      _editedRequest.imageurl = url;
    });
  }

  Future<void> _saveform() async {
    setState(() {
      _isloading = true;
    });
    _gkey.currentState.save();
    try {
      await Provider.of<Donator>(context, listen: false)
          .addrequest(_editedRequest);
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
    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final nid = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donate",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _saveform();
              })
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _gkey,
                  child: ListView(
                    children: <Widget>[
                      ImageInput(_pickedImage),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Donator Name",
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(frst);
                        },
                        onSaved: (val) {
                          _editedRequest = Donate(
                              did: _editedRequest.did,
                              dname: val,
                              ditem: _editedRequest.ditem,
                              daddress: _editedRequest.daddress,
                              imageurl: _editedRequest.imageurl,
                              msg: _editedRequest.msg,
                              nid: nid,
                              phno: _editedRequest.phno);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Item",
                        ),
                        focusNode: frst,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(sec);
                        },
                        onSaved: (val) {
                          _editedRequest = Donate(
                              did: _editedRequest.did,
                              dname: _editedRequest.dname,
                              ditem: val,
                              daddress: _editedRequest.daddress,
                              imageurl: _editedRequest.imageurl,
                              msg: _editedRequest.msg,
                              nid: nid,
                              phno: _editedRequest.phno);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Address",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: sec,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(thrd);
                        },
                        onSaved: (val) {
                          _editedRequest = Donate(
                              did: _editedRequest.did,
                              dname: _editedRequest.dname,
                              ditem: _editedRequest.ditem,
                              daddress: val,
                              imageurl: _editedRequest.imageurl,
                              msg: _editedRequest.msg,
                              nid: nid,
                              phno: _editedRequest.phno);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: thrd,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(frth);
                        },
                        onSaved: (val) {
                          _editedRequest = Donate(
                              did: _editedRequest.did,
                              dname: _editedRequest.dname,
                              ditem: _editedRequest.ditem,
                              daddress: _editedRequest.daddress,
                              imageurl: _editedRequest.imageurl,
                              msg: _editedRequest.msg,
                              nid: nid,
                              phno: val);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Any Messsage",
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: frth,
                        onSaved: (val) {
                          _editedRequest = Donate(
                              did: _editedRequest.did,
                              dname: _editedRequest.dname,
                              ditem: _editedRequest.ditem,
                              daddress: _editedRequest.daddress,
                              imageurl: _editedRequest.imageurl,
                              msg: val,
                              nid: nid,
                              phno: _editedRequest.phno);
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
