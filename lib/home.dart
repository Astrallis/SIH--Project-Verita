import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:verita/carddet.dart';
import 'package:verita/lava.dart';
import 'package:verita/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:ui';


class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      
      // Set the TabBar view as the body of the Scaffold
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        // Add tabs as widgets
        children: <Widget>[HomePage(), ImageInput(), Places() ,About()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.explore),
            ),
            Tab(
              icon: Icon(Icons.place),
            ),
            Tab(
              icon: Icon(Icons.people),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }

}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position position;


  String userName="";
   getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    print(position.latitude);
    setState(() {
      this.position=position;

    });
    return position;
  }
  
  @override
  void initState() {
    getLocation();
  
    getUserName().then((value){
      
      setState(() {
        userName=value;
      });
    });
    
    // TODO: implement initState
    super.initState();
  }
   

  // var provider = new StaticMapProvider('your_api_key');
 
//   var _mapView = new MapView();


// //Add a method to call to show the map.
// void showMap() {
//     _mapView.show(new MapOptions(showUserLocation: true));
// }
 
  @override
  Widget build(BuildContext context) {
    return position==null?Scaffold(backgroundColor: Colors.blue,body: Center(child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Reaching you",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        Container(height: 200,width: 200,child: FlareActor("assets/runner.flr", animation:"Search location"))
      ],
    )),):Scaffold(
      backgroundColor: Colors.blue,
          body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: FlutterMap(
              options: new MapOptions(
                center: new LatLng((position.latitude+15.5009)/2,(position.longitude+73.9116)/2),
                zoom: 4.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/karmaryo/ck5j1xnfi03dn1int1adnicpf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2FybWFyeW8iLCJhIjoiY2s1ajF1bWxmMDJibzNsbzZ2ZnY4djl6MCJ9.yhu_5xEGN7F9eFOIWv4JrA",
                  additionalOptions: {
                    'accessToken': '<pk.eyJ1Ijoia2FybWFyeW8iLCJhIjoiY2s1ajF1bWxmMDJibzNsbzZ2ZnY4djl6MCJ9.yhu_5xEGN7F9eFOIWv4JrA',
                    'id': 'mapbox.mapbox-traffic-v1',
                  },
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(position.latitude,position.longitude),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.center_focus_strong),
                      ),
                    ),
                     Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(15.5009, 73.9116),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                    ),
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(15.5039, 73.9122),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                    ),
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(15.4926, 73.7732),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                    ),
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(15.5056, 73.9150),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                    ),
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(15.4987, 73.8293),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.location_on,color: Colors.red,),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Align(alignment: Alignment(0,1),
                    child: Card(clipBehavior:Clip.antiAlias,
                    color: Color(0xccffffff),
            shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(height: MediaQuery.of(context).size.height*0.5,
                                  child: CardList(position.longitude,position.latitude),
                                  ),
            ),
          )
        ],
      ),
    );
  }
    
    // Scaffold(
    //   appBar: AppBar(
        
    //   ),
    //   drawer: Drawer(),
    //     body: Center(child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[

    //         Text("Logged In as $userName"),
    //         RaisedButton(onPressed: (){
    //           getLocation();
    //         },),
    //         RaisedButton(child: Text("Explore"),onPressed: (){
    //           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ImageInput()));
    //         },),
    //         RaisedButton(
    //           child: Text("Log Out"),
    //           onPressed: (){
    //            FirebaseAuth.instance.signOut().then((value) {
    //              setUserName("");
    //                   Navigator
    //                       .of(context)
    //                       .pushReplacementNamed('/landingpage');
    //                 }).catchError((e) {
    //                   print(e);
    //                 });
                    
                  
    //         },)
    //       ],
    //     ),),

    // );
  

}
class Drawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,      
      child: Center(child: RaisedButton(child: Text("Off"),onPressed: (){
       Navigator.of(context).pop();
      },),),
    );
  }
}



class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: <Widget>[
          Text("About"),
           RaisedButton(
              child: Text("Log Out"),
              onPressed: (){
               FirebaseAuth.instance.signOut().then((value) {
                 setUserName("");
                      Navigator
                          .of(context)
                          .pushReplacementNamed('/landingpage');
                    }).catchError((e) {
                      print(e);
                    });
                    
                  
            },)
        ],
       
      ),),
    );
  }
}

class Places extends StatefulWidget {
  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  Position position;
  @override
   getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    print(position.latitude);
    setState(() {
      this.position=position;
    });
    return position;
  }
  @override
 void initState() {
    getLocation();// TODO: implement initState
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        position==null?Scaffold(backgroundColor: Colors.blue,body: Center(child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Almost There !!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        Container(height: 200,width: 200,child: FlareActor("assets/runner.flr", animation:"Search location"))
      ],
    )),):
        Scaffold(
          body:Padding(
            padding: EdgeInsets.only(top:60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(left:30,right: 30),
                child: Text("Here you go !!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right: 30,top: 20,bottom:20),
                child: Text("We have sorted some Places for you. Located on the Western Ghats of Konkan, Goa is known as the smallest and the fourth smallest populated state of India. Goa is bounded by Maharashtra to its north, eastern and southern boundaries were formed by Karnataka, while the western coast is formed by Arabian Sea."),
              ),
              Expanded(
                          child: Container(
                                          child: CardList(position.longitude,position.latitude),
                                          ),
              ),
            ],),
          )
          
        ),

        
      ],
    );
  }
}