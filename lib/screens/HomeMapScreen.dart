import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:oldies/providerr/ngos.dart';
import 'package:provider/provider.dart';

class HomeMapScreen extends StatefulWidget {
  static const routname = "/homemapscreen";
  @override
  _HomeMapScreenState createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final data = Provider.of<NGOs>(context).items.firstWhere((i) => id == i.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
      ),
      body: FlutterMap(
        options: MapOptions(
            center: latLng.LatLng(data.latitude, data.longitude), zoom: 15.0),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/sailesh150/ckghx50w21u4w19mowiz4shnv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FpbGVzaDE1MCIsImEiOiJja2dkYmU2aGMwaGI2MnFvN3JmdjVwY2Q3In0.hKCVREGWZY7BM6knyJPFsA",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoic2FpbGVzaDE1MCIsImEiOiJja2dkYmU2aGMwaGI2MnFvN3JmdjVwY2Q3In0.hKCVREGWZY7BM6knyJPFsA',
              'id': 'mapbox.satellite',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: new latLng.LatLng(data.latitude, data.longitude),
                builder: (ctx) => Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 45,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) => Container(
                                color: Colors.grey[200],
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Color.fromRGBO(54, 169, 186, 1.0),
                                      height: 80,
                                      width: double.infinity,
                                      child: Center(
                                          child: Text(
                                        data.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data.location,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.call,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data.number,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_city,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data.city,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
