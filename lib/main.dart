import 'package:flutter/material.dart';
import 'package:oldies/providerr/auth.dart';
import 'package:oldies/providerr/cities.dart';
import 'package:oldies/providerr/donator.dart';
import 'package:oldies/providerr/jobs.dart';
import 'package:oldies/providerr/ngos.dart';
import 'package:oldies/providerr/volunteers.dart';
import 'package:oldies/screens/AddDonater.dart';
import 'package:oldies/screens/AddJobs.dart';
import 'package:oldies/screens/AddNgo.dart';
import 'package:oldies/screens/AddVolunteer.dart';
import 'package:oldies/screens/AuthScreen.dart';
import 'package:oldies/screens/DonateDetailScreen.dart';
import 'package:oldies/screens/DonateScreen.dart';
import 'package:oldies/screens/HomeDetailScreen.dart';
import 'package:oldies/screens/HomeMapScreen.dart';
import 'package:oldies/screens/JobScreen.dart';
import 'package:oldies/screens/MainScreen.dart';

import 'package:oldies/screens/NGOListScreen.dart';

import 'package:oldies/screens/OrganiserAuthScreen.dart';
import 'package:oldies/screens/VolunteerDetailScreen.dart';
import 'package:oldies/screens/VolunteerScreen.dart';
import 'package:provider/provider.dart';

//    backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final mail = ModalRoute.of(context).settings.arguments as String;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Cities(),
        ),
        ChangeNotifierProxyProvider<Auth, NGOs>(
          create: (_) => NGOs("", [], ""),
          update: (ctx, auth, prevprods) {
            return NGOs(auth.token, prevprods == null ? [] : prevprods.items,
                auth.usermail);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Volunteers>(
          create: (_) => Volunteers("", [], ""),
          update: (ctx, auth, prevprods) {
            return Volunteers(auth.token,
                prevprods == null ? [] : prevprods.vitems, auth.usermail);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Jobs>(
          create: (_) => Jobs("", [], ""),
          update: (ctx, auth, prevprods) {
            return Jobs(auth.token, prevprods == null ? [] : prevprods.jitem,
                auth.usermail);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Donator>(
          create: (_) => Donator("", [], ""),
          update: (ctx, auth, prevprods) {
            return Donator(auth.token, prevprods == null ? [] : prevprods.dlist,
                auth.usermail);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? MainScreen() : AuthScreen(),
            routes: {
              MainScreen.routname: (ctx) => MainScreen(),
              NGOListScreen.routname: (ctx) => NGOListScreen(auth.usermail),
              Register.routname: (ctx) => Register(),
              HomedetailScreen.routname: (ctx) => HomedetailScreen(),
              HomeMapScreen.routname: (ctx) => HomeMapScreen(),
              VolunteerScreen.routname: (ctx) => VolunteerScreen(auth.usermail),
              VolunteerDetailScreen.routname: (ctx) => VolunteerDetailScreen(),
              AddVolunteerScreen.routname: (ctx) => AddVolunteerScreen(),
              JobScreen.routname: (ctx) => JobScreen(auth.usermail),
              AddJob.routname: (ctx) => AddJob(),
              DonateScreen.routname: (ctx) => DonateScreen(auth.usermail),
              DonateDetailScreen.routname: (ctx) => DonateDetailScreen(),
              AddDonater.routname: (ctx) => AddDonater(),
              OrganiserAuthScreen.routname: (ctx) => OrganiserAuthScreen(),
              AuthScreen.routname: (ctx) => AuthScreen(),
            }),
      ),
    );
  }
}
