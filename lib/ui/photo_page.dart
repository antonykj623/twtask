import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twtask/constants/Constants.dart';
import 'package:twtask/designs/ResponsiveInfo.dart';
import 'package:twtask/ui/select_card.dart';

import '../data/photos.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {


  List<Hits>hitsdata=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotosDataFromServer();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,

        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        title: Text("Home",style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 13:15),),
        centerTitle: false,




      ),

      body:

      Stack(

        children: [

          (hitsdata.length>0)?    Align(
            alignment: FractionalOffset.topCenter,

            child: GridView.count(
                crossAxisCount: (ResponsiveInfo.isPortrait(context)? (ResponsiveInfo.isMobile(context) ?2:3 ) : (ResponsiveInfo.isMobile(context) ?3:4 ) )  ,
                crossAxisSpacing: (ResponsiveInfo.isPortrait(context)? (ResponsiveInfo.isMobile(context) ?4:6 ) : (ResponsiveInfo.isMobile(context) ?5:7 ) ),
                mainAxisSpacing: (ResponsiveInfo.isPortrait(context)? (ResponsiveInfo.isMobile(context) ?8:10 ) : (ResponsiveInfo.isMobile(context) ?10:13 ) ),
                children: List.generate(hitsdata.length, (index) {
                  return Center(
                    child: SelectCard(hitsdata[index]),
                  );
                }
                )
            ))

           : Align(

            alignment: FractionalOffset.center,

            child: CircularProgressIndicator(),
          )

        ],
      ) ,


    );
  }


  getPhotosDataFromServer()async
  {
    var url = Uri.parse(AppConstants.weburl);

   var response=await http.get(url);

   if(response!=null) {
     if (response.statusCode == 200) {
       print(response.body);
       if (response.body!=null)
         {

           Photos photos= Photos.fromJson(jsonDecode(response.body));

           setState(() {
             hitsdata.addAll(photos.hits!);

           });


         }
     }
   }
  }
}
