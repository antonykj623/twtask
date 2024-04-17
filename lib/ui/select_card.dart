import 'package:flutter/material.dart';
import 'package:twtask/data/photos.dart';
import 'package:twtask/designs/ResponsiveInfo.dart';
import 'package:twtask/ui/full_screen_image_viewer.dart';

class SelectCard extends StatelessWidget {

  Hits hts;
   SelectCard(this.hts) ;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      
      child:  Card(

            child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Image.network(
                    hts.previewURL!,
                    errorBuilder: (context, error, stackTrace) {
                      print(error);
                      return Container();//do something
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? (loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!)
                              : null,
                        ),
                      );
                    },
                    width: double.infinity,
                    height: hts.previewHeight!.toDouble(),
                    fit: BoxFit.fill,



                  ),flex: 2,),

                  Expanded(child: Center(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

                          child: Icon(Icons.favorite,size: ResponsiveInfo.isMobile(context)?15:20,),
                        ),
                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

                          child: Text(hts.likes!.toString(),style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:15),),
                        ),

                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

                          child: Icon(Icons.remove_red_eye,size: ResponsiveInfo.isMobile(context)?15:20,),
                        ),
                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

                          child: Text(hts.views!.toString(),style: TextStyle(color: Colors.black,fontSize: ResponsiveInfo.isMobile(context)?13:15),),
                        )




                      ],
                    ),



                  ),flex: 1,),

                ]
            ),
            )
        )  ,




      
      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageViewer(hts.largeImageURL!),
          ),
        );
        
      },
    )
      
      
     ;
  }
}
