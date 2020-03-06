import 'package:flutter/material.dart';
import 'detailer.dart';
import 'dart:math';

class CardList extends StatefulWidget {
   double longitude,latitude;

  CardList(double a,double b)
  {
    longitude=a;latitude=b;
  }
  
  @override
  _CardListState createState() => _CardListState(longitude,latitude);
}

class _CardListState extends State<CardList> {


  
  List<String> name=["Basilica of Bom Jesus","Se Cathedral","St. Cajetan Church","Our lady of Immaculate","Aguada Fort"];

  List<String> asset=["assets/basilica.jpg","assets/se_cathed.jpg","assets/st_cajetan.jpg","assets/Lady.jpg","assets/aguada.jpg"];

  List<String> abt=["The Basilica of Bom Jesus church is one of a kind in India and is known for its exemplary baroque architecture. Built-in the year 1594 and consecrated in 1605, the building of this church coincides with the beginning of Christianity in India",
  "One of the most ancient and celebrated religious buildings of Goa, this magnificent 16th-century monument, constructed by the Roman Catholics under the Portuguese rule, is the largest church in Asia",
  "This church was built by Italian Monks of the Order of Theatines in 1665. It’s crowned with a huge hemispherical dome, on the pattern of the Roman Basilica of St. Peter.",
  "True to its name, the façade of this church is painted an immaculate, sparkling white. To the untrained eye, this might even belie the actual age and antiquity of this church.",
  "Built in 1612 as a protection from Dutch and Marathas, it was the most prized and crucial fort for the Portuguese and covers the entire peninsula at the southwestern tip of Bardez."];

  List<double> lat=[15.5009,15.5039,15.4926,15.5056,15.4987];

  List<double> lon=[ 73.9116,73.9122,73.7732,73.9150,73.8293];

  List<double> dis=[];
  double longitude,latitude;

  _CardListState(double a,double b)
  {
    longitude=a;latitude=b;
  }
  
  double find_dist(double lat1,double lon1,double lat2,double lon2) {
    	double p=0.017453292519943295;
    	double x=0.5-cos((lat2-lat1)*p)/2+cos(lat1*p)*cos(lat2*p)*(1-cos((lon2-lon1)*p))/2;
    	double dist=12742*asin(sqrt(x));
      print(dist);
    	return double.parse(dist.toStringAsFixed(2));
    }
  
  void sort(){
    for(int i=0;i<dis.length;i++)
    {
      for(int j=0;j<dis.length-1;j++)
      {
        if(dis[j]>dis[j+1])
        {
          double t=dis[j];
          dis[j]=dis[j+1];
          dis[j+1]=t;
          t=lon[j];
          lon[j]=lon[j+1];
          lon[j+1]=t;
          t=lat[j];
          lat[j]=lat[j+1];
          lat[j+1]=t;
          String s=name[j];
          name[j]=name[j+1];
          name[j+1]=s;
          s=asset[j];
          asset[j]=asset[j+1];
          asset[j+1]=s;
          s=abt[j];
          abt[j]=abt[j+1];
          abt[j+1]=s;
        }
      }
    }
  }

  @override
  void initState() {
    for(int i=0;i<lat.length;i++){
      dis.add(find_dist(lat[i],lon[i],latitude,longitude));
    }
    sort();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context,index){
          double distance=dis[index];
          return Padding(
            
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: GestureDetector(
              onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Detailer(name[index],abt[index],asset[index])));
              },
                          child: Card(
                shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          height:80,width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          image: DecorationImage(fit: BoxFit.cover,
                            image: ExactAssetImage(asset[index])
                          )
                        ),),
                        SizedBox(width: 20,),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(name[index],style:TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize:20)),
                              SizedBox(height: 10,),
                              Text("You are $distance km's away")
                            ],
                          ),
                        )
                      ],),
                  )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}