import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_currentlocation.dart';
import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieShareLocation extends StatefulWidget {
  const didiyieShareLocation({Key? key}) : super(key: key);

  @override
  State<didiyieShareLocation> createState() => _didiyieShareLocationState();
}

class _didiyieShareLocationState extends State<didiyieShareLocation> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: didiyieColor.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(didiyiePngimage.menuicon,height: height/36,fit: BoxFit.fitHeight,),
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          children: [
            SizedBox(height: height/10,),
            Image.asset(didiyiePngimage.locationicon,height: height/9,fit: BoxFit.fitHeight,),
            SizedBox(height: height/30,),
            Text("Share your location\nwith us to order",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 22),),
            SizedBox(height: height/36,),
            Text("Please enter your location or allow access\nto your location to find all restaurants that\nare near you ",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
            const Spacer(),
            InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const didiyieCurrentLocation();
              },));
              },
              child: Container(
                height: height / 16,
                width: width / 1,
                decoration: BoxDecoration(
                  color: didiyieColor.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Entera_new_location".tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.appcolor),
                  ),
                ),
              ),
            ),
            SizedBox(height: height/96,),
            InkWell(
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieCurrentLocation();
                },));
              },
              child: Container(
                height: height / 13,
                width: width / 1,
                decoration: BoxDecoration(
                  color: didiyieColor.appcolor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Continue".tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.white),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
