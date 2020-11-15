import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function imagePickfn;
  ImageInput(this.imagePickfn);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
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
        Container(
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storeImage == null
              ? Center(
                  child: Text(
                    "no image selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                )
              : Image.file(
                  _storeImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        FlatButton.icon(
          icon: Icon(Icons.photo),
          label: Text(
            "Select An Image From Gallery",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: _selectPicture,
        ),
        Divider(),
      ],
    );
  }
}
