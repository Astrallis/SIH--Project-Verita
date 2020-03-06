import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
 
import 'package:firebase_auth/firebase_auth.dart';
 
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'services/storage.dart';
import 'package:flare_flutter/flare_actor.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  String userName="";

  @override
  void initState() {
    getUserName().then((value){
      
      setState(() {
        userName=value;
        print(userName);
      });
    });
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context) => new SignUp(),
        '/homepage': (BuildContext context) => new MyHome()
      },
    );
  }
}




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String userName="";


  


Future<Timer> loadData() async {
  return new Timer(Duration(seconds: 7), onDoneLoading);
}

onDoneLoading() async {
  Navigator.pushReplacement(context, FadeRoute(page: userName==null?LoginPage():userName==""?LoginPage(): MyHome()));
  
}

  @override
  void initState() {
    loadData();
    getUserName().then((value){
      
      setState(() {
        userName=value;
        print(userName);
      });
    });
    
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,
body: Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
color: Color(0x88009Aff),
child: 
  FlareActor("assets/verita2.flr", alignment:Alignment.topCenter, fit:BoxFit.fitWidth, animation:"Notifications"),

),
    );
  }
}


class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        );
}