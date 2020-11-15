import 'package:flutter/material.dart';

class CityGrid extends StatelessWidget {
  final String city;
  final Color color;

  CityGrid(this.city, this.color);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/ngolistscreen', arguments: city);
        },
        child: Card(
          elevation: 8,
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Image.asset("assets/i2.png", fit: BoxFit.fill)),
                Text(
                  city,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
