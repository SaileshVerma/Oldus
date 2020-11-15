import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  final Function imagePickfn;
  ProfilePic(this.imagePickfn);
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File _storeImage;
  final picker = ImagePicker();

  Future<void> _selectPicture() async {
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _storeImage = File(imageFile.path);
    });
    widget.imagePickfn(_storeImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage: FileImage(
            _storeImage,
          ),
        ),
        FlatButton.icon(
          icon: Icon(Icons.photo),
          label: Text(
            "Select An Image From Gallery",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onPressed: _selectPicture,
        ),
        Divider(),
      ],
    );
  }
}
