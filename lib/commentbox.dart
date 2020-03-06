import 'package:flutter/material.dart';
import 'services/storage.dart';

class Comment extends StatefulWidget {
  String name, time, description;
  Comment(String a, String b, String c) {
    name = a;
    time = b;
    description = c;
  }
  @override
  _CommentState createState() => _CommentState(name, time, description);
}

class _CommentState extends State<Comment> {
  String userName;
  String name, time, description;
  _CommentState(String a, String b, String c) {
    name = a;
    time = b;
    description = c;
  }
  @override
  void initState() {
    getUserName().then((value){
      
      setState(() {
        userName=value;
      });
    // TODO: implement initState
    super.initState();
  });}
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    
    return Container(
      child: Card(elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),color: Color(0xeeffffff),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment(0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: deviceWidth * 0.100,
                                width: deviceWidth * 0.100,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        image:
                                            new AssetImage('assets/demo.jfif'),
                                        fit: BoxFit.contain)),
                              ),
                              SizedBox(
                                width: deviceWidth * 0.050,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * 0.0050,
                                    ),
                                    Container(
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 12),
                          child: Container(
                              child: Text(
                            description,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          )),
                        )
                      ],
                    ),
                  ),
                  Divider()
                ],
              ),
            )),
      
    );
  }
}
