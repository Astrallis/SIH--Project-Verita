import 'detailtab.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'services/storage.dart';
import 'commentbox.dart';
import 'detailtab.dart';
class Detailer extends StatefulWidget {
  String name, abt,file;
  Detailer(String a, String b,String c) {
    name = a;
    abt = b;
    file=c;
  }
  @override
  _DetailerState createState() => _DetailerState(name,abt,file);
}

class _DetailerState extends State<Detailer> {
  String name, abt,file;
  
  _DetailerState(String a, String b,String c) {
    name = a;
    abt = b;
    file= c;
  }
  String userName;

  List<String>  _commentName = ['John Downy', 'Robert Doe'],_commentDetail = ['Great place!! Must Visit.', 'Same answer no difference'],_commentTime = ['1 day ago', '6 hours ago'];
  @override
  void initState() {
   
  
     getUserName().then((value){
      
      setState(() {
        userName=value;
      });
    // TODO: implement initState
   
  });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var controller1 = TextEditingController();
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
                              body: Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 350,
                                        decoration: BoxDecoration(
                                          image: new DecorationImage(
                                            image: file==""?ExactAssetImage(
                                                'assets/GoaChurch.jpg'):ExactAssetImage(file),
                                            fit: BoxFit.cover,
                                          ),
                                          
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                                                                  child: Align(alignment: Alignment(-1,-1),child: Padding(
                                            padding: const EdgeInsets.only(left:10.0,top:25),
                                            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 40,),
                                          )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: Colors.white,
                                        
                                          child: ClipRRect(
                                            // make sure we apply clip it properly
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 100, sigmaY: 100),
                                              child: Container(
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        DetailsPage(name, abt,file),
                                        // _buildCommentBox(
                                        //     deviceWidth,
                                        //     deviceHeight,
                                        //     'John Doe',
                                        //     '1 day ago',
                                        //     'Great place!! Must Visit.'),
                                        Card(
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          child:Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Center(
                                                      child: Text(
                                                        "REVIEWS:",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                         
                                            
                                          
                                        ),
                                        Container(
                                              height: deviceHeight/3.2,
                                              child: ListView.builder(
                                                  itemCount:
                                                      _commentName.length,
                                                  itemBuilder:
                                                      (BuildContext ctxt,
                                                          int index) {
                                                            int a=index;
                                                    return Comment(
                                                        _commentName[a],
                                                        _commentTime[a],
                                                        _commentDetail[a]);
                                                  }),
                                            )
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0, 1),
                                    child: Card(
                                      elevation: 30,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      child: Container(
                                        height: 90,
                                        width: deviceWidth,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left:15.0),
                                              child: Text("Leave a Comment",
                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: deviceWidth * 0.65,
                                                  child: TextFormField(
                                                    controller: controller1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FocusScope.of(context).requestFocus(new FocusNode());
                                                      _commentName.add(userName);
                                                      _commentDetail.add(controller1.text);
                                                      _commentTime.add("Just now");
                                                    });
                                                  },
                                                  child: Card(
                                                    elevation: 3,
                                                    color: Colors.blue,
                                                    clipBehavior: Clip.antiAlias,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Container(
                                                      width: deviceWidth * 0.2,
                                                      height: 30,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.send,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "submit",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
  }
}