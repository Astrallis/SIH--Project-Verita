import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'detailer.dart';

import 'package:verita/services/storage.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File imageFile;
int _isLoading=0;
int _noimage=0;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      imageFile = image;
    });
  }

  String url = 'https://powerful-crag-48261.herokuapp.com/api';

  Future<String> makeRequest(File _imageFile) async {
    String fileName = _imageFile.path.split('/').last;
    Response response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "image":
          await MultipartFile.fromFile(_imageFile.path, filename: fileName),
    });
    response = await dio.post(url, data: formData);
    responseCode = response.data['status'];
    abt = response.data['info'].toString();
    name = response.data['title'].toString();

// print(response.data.toString());
  }

  int responseCode;
  String name;
  String abt;
   List<String> _commentName, _commentDetail, _commentTime;
  
  @override
  void initState() {
    _commentName = ['John Downy', 'Robert Doe'];
    _commentDetail = ['Great place!! Must Visit.', 'Same answer no difference'];
    _commentTime = ['1 day ago', '6 hours ago'];
    // TODO: implement initState
    super.initState();
  }

//   submitForm() async {
//   final response = await http.post(
//     "https://powerful-crag-48261.herokuapp.com/api",

//     body: {
//       'image': imageFile != null ? 'data:image/png;base64,' +
//           base64Encode(imageFile.readAsBytesSync()) : '',
//     },
//   );

//   final responseJson = json.decode(response.body);

//   print(responseJson);
// }

  // Widget _buildCommentBox(deviceWidth, deviceHeight, name, time, description) {

  @override
  Widget build(BuildContext context) {
  
    return Stack(
      children: <Widget>[
        Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(left:20,right: 30),
              child: Text("Here we do the magic !!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
          Padding(
              padding: const EdgeInsets.only(left:20,right: 30,top:10),
              child: Text("Please choose a photo",style: TextStyle(fontSize: 19,),),
          ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        getImage(true);
                      },
                      child: Card(shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),color: Colors.blue,child: Container(height:50,width: 170,child: Center(child: Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.camera,color:Colors.white),
                                                SizedBox(width: 10,),
                                                Text("Camera",style:TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            )))),
                    ),
                    SizedBox(width: 50,),
                    GestureDetector(
                      onTap: () {
                        getImage(false);
                      },
                      child: Card(shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),color: Colors.blue,child: Container(height:50,width: 170,child: Center(child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.photo_album,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Text("Gallery",style:TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            )))),
                    ),
                    // RaisedButton(
                    //   child: Icon(Icons.camera),
                      
                    // ),
                    // RaisedButton(
                    //   child: Icon(Icons.picture_in_picture),
                    //   onPressed: () {
                    //     getImage(false);
                    //   },
                    // )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,left:20),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 400,
                  color: Colors.black,
                  child: imageFile == null
                      ? Container()
                      : Image.file(
                          imageFile,
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width -40,
                        ),
                ),
              ),
              SizedBox(height: 30),
              Container(width: MediaQuery.of(context).size.width,
                child: Center(
                  child: GestureDetector(
                    child: Card(shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),color: Colors.blue,child: Container(height:50,width: 200,child: Center(child: Text("Go Verita !!",style:TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))))),
                    onTap: () {
                      setState(() {
                        imageFile != null? _isLoading=1:_noimage=1;
                      });
                      imageFile != null
                          ? makeRequest(imageFile).then((String a) {
                            setState(() {
                              _isLoading=0;
                            });
                            if(responseCode!=1)
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Scaffold(body: Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Uh Oh, No details found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      
                                      Container(child: FlareActor("assets/cross.flr",animation:"Error"),height: 200,width: 200,),
                                      
                                      RaisedButton(color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                        child: Text("Try Again",style: TextStyle(color: Colors.white),),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      )
                                  ],),),)));
                            }
                            else
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Detailer(name,abt,"")));
                            })
                          : null;
                    },
                  ),
                ),
              )
          ],
        ),
            )),
        _isLoading==0?Container():Scaffold(
          backgroundColor: Color(0xaa000000),
          body:Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hold up !! we are doing something",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height:20),
              CircularProgressIndicator()
            ],
          ),)
        ),
        _noimage==0?Container():Scaffold(
      backgroundColor: Color(0xaa000000),
      body: Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Please select an Image first",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.white),),
                                      
                                      Container(child: FlareActor("assets/cross.flr",animation:"Error"),height: 200,width: 200,),
                                    
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.red,
                                        child: Text("Try Again",style: TextStyle(color: Colors.white)),
                                        onPressed: (){
                                          setState(() {
                                            _noimage=0;
                                          });
                                        },
                                      )
                                  ],),),)
      ],
    );
  }
}



//details page

//comments

