import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

class Locator extends StatefulWidget {
  final double lat;
  final double lon;
  Locator(this.lat, this.lon);

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options:
          MapOptions(center: latLng.LatLng(widget.lat, widget.lon), zoom: 13.0),
      layers: [
        new TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/sailesh150/ckghx50w21u4w19mowiz4shnv/tiles/256/{z}/{x}/{y}@2x?access_token=[mapboxToken]",
          additionalOptions: {
            'accessToken': '[accessToken]',
            'id': 'mapbox.satellite',
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: new latLng.LatLng(widget.lat, widget.lon),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
