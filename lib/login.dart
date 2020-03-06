import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verita/services/storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:verita/signup.dart';
import 'home.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _passw;
  GoogleSignIn googleAuth = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0x88009Aff),
              child: FlareActor("assets/verita2.flr",
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  animation: "stop"),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 500,
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            color: Colors.white,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration:
                                          InputDecoration(hintText: "Email"),
                                      onChanged: (value) {
                                        setState(() {
                                          _email = value;
                                        });
                                      },
                                    ),
                                    TextField(
                                      decoration:
                                          InputDecoration(hintText: "Password"),
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _passw = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ButtonTheme(
                                      minWidth: 150,
                                      height: 40,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                       
                                          _email=_email.trim();
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: _email,
                                                  password: _passw)
                                              .then((AuthResult _auth) {
                                            final FirebaseUser user =
                                                _auth.user;
                                            setUserName(user.email);
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(builder:  (context)=> MyHome()));
                                          }).catchError((e) {
                                            print(e);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "First time here?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ButtonTheme(
                              minWidth: 150,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignUp()));
                                },
                              ),
                            ),
                          ],
                        ),
                        // RaisedButton(child: Center(child: Text("Sign in Via Google",style: TextStyle(color: Colors.white),)),
                        // color: Colors.red,
                        // onPressed: () {
                        //     },
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
