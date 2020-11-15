import "package:flutter/material.dart";

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(54, 169, 186, 1.0),
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Welcome To Oldus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
              )),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/mainscreen');
              }),
          Divider(),
          // ListTile(
          //     leading: Icon(Icons.exit_to_app),
          //     title: Text('LogOut'),
          //     onTap: () {
          //       Provider.of<Auth>(context, listen: false).logOut();
          //       Navigator.of(context).pop();
          //     }),
          // Divider(),
          // ListTile(
          //   title: FlatButton.icon(
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //         Provider.of<Auth>(context, listen: false).logOut();
          //       },
          //       icon: Icon(Icons.exit_to_app),
          //       label: Text("LogOut")),
          // ),
        ],
      ),
    );
  }
}
