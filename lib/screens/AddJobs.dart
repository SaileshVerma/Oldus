import 'dart:io';
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import 'package:oldies/models/job.dart';
import 'package:oldies/widgets/profilepic.dart';
import 'package:provider/provider.dart';
import 'package:oldies/providerr/jobs.dart';

class AddJob extends StatefulWidget {
  static const routname = "/addjob";
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  File _userImage;
  final _gkey = GlobalKey<FormState>();
  final _focus = FocusNode();
  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  var _jobdata = Job(
      jid: DateTime.now().toString(),
      name: "",
      service: "",
      imageurl: "",
      nid: "");
  void _pickedImage(File image) async {
    setState(() {
      _userImage = image; //for getting the image form the widgets
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_image")
        .child(DateTime.now().toString() + ".jpg");

    await ref.putFile(_userImage).onComplete;
    final url = await ref.getDownloadURL();

    setState(() {
      _jobdata.imageurl = url;
    });
  }

  Future<void> _saveform() async {
    _gkey.currentState.save();
    try {
      await Provider.of<Jobs>(context, listen: false).addjob(_jobdata);
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
    final nid = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
        //make the form here for adding the hire me data .
        appBar: AppBar(
          title: Text(
            "ADD JOB",
            style: TextStyle(fontSize: 22),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _saveform();
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _gkey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProfilePic(_pickedImage),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name :"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus);
                    },
                    onSaved: (val) {
                      _jobdata = Job(
                          jid: _jobdata.jid,
                          name: val,
                          service: _jobdata.service,
                          imageurl: _jobdata.imageurl,
                          nid: nid);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Servies :"),
                    textInputAction: TextInputAction.done,
                    focusNode: _focus,
                    onSaved: (val) {
                      _jobdata = Job(
                          jid: _jobdata.jid,
                          name: _jobdata.name,
                          service: val,
                          imageurl: _jobdata.imageurl,
                          nid: nid);
                    },
                  ),
                ],
              )),
        ));
  }
}
