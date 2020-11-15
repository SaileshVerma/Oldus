import 'package:flutter/material.dart';

class DecoGrid extends StatelessWidget {
  final String imgpath;
  final String quote;
  final Color col;
  DecoGrid({this.imgpath, this.quote, this.col});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [col.withOpacity(0.6), col],
              begin: Alignment.centerLeft,
              end: Alignment(1.0, 1.0),
            )),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imgpath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  quote,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
