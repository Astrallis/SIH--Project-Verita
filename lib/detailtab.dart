import 'package:flutter/material.dart';
import 'dart:math';

class DetailsPage extends StatefulWidget {
  String title;
  String dsc;
  String file;
  DetailsPage(String a, String b,String c) {
    title = a;
    dsc = b;
    file=c;
  }
  @override
  _DetailsPageState createState() => _DetailsPageState(title, dsc,file);
}

class _DetailsPageState extends State<DetailsPage> {
  String title;
  String dsc;
  String file;
  int book = 0;
  _DetailsPageState(String a, String b,String c) {
    title = a;
    dsc = b;
    file=c;
  }
  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    int view = rng.nextInt(100);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: deviceWidth,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 70,
                      
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: file==""? ExactAssetImage(
                                                'assets/sample_place.png'):ExactAssetImage(file),
                                                fit: BoxFit.fill
                        ),
                      ),
                      
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Views: $view",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          book == 0
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      book = 1;
                                    });
                                  },
                                  child: Icon(
                                    Icons.bookmark_border,
                                    size: 37,
                                  ))
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      book = 0;
                                    });
                                  },
                                  child: Icon(
                                    Icons.bookmark,
                                    size: 37,
                                  ))
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: deviceHeight * 0.16,
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(child: Container(
                        height: deviceHeight * 0.1,
                        child: Text("$dsc"),
                      ),),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  elevation: 3,
                                  color: Colors.blue,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    width: deviceWidth * 0.2,
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.directions,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Set Route",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  color: Colors.blue,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    width: deviceWidth * 0.2,
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Call here",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  color: Colors.blue,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    width: deviceWidth * 0.2,
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.local_taxi,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Taxi ?",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
