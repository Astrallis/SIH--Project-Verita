import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verita/services/storage.dart';

class UserManagement{
      storeNewUser( user,context){
        Firestore.instance.collection("/users").add({ "email": user.user.email, "password": user.user.password, "uid":user.user.uid}).then((value){
              
              Navigator.pushReplacementNamed(context, "/homepage");
        }).catchError((e){print(e);});
      }
}