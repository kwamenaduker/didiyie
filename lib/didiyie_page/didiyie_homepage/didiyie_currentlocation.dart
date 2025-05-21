import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_chooseflow.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieCurrentLocation extends StatefulWidget {
  const didiyieCurrentLocation({Key? key}) : super(key: key);

  @override
  State<didiyieCurrentLocation> createState() => _didiyieCurrentLocationState();
}

class _didiyieCurrentLocationState extends State<didiyieCurrentLocation> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  List<String> gridname = ["Gram Bistro","Bin 71","Sushi Bar"];
  List<String> griddesc = ["790 8th Ave, New York","792 8th Ave, New York","794 8th Ave, New York"];
  int selectindex = 0;


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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
          child: Column(
            children: [
              Text("Share your location\nwith us to order",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 22),),
              SizedBox(height: height/36,),
              Text("Please enter your location or allow access\nto your location to find all restaurants that\nare near you ",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
              SizedBox(height: height/26,),
              ListView.builder(
                itemCount: gridname.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: didiyieColor.transparent,
                    highlightColor: didiyieColor.transparent,
                    onTap: () {
                      setState(() {
                        selectindex = index;
                      });
                    },
                    child:  Container(
                      width: width / 1,
                      margin: EdgeInsets.only(bottom: height/36),
                      decoration: BoxDecoration(
                          color: didiyieColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: didiyieColor.greyy, blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 36, vertical: height / 46),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width/36),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(gridname[index].toString(),style: mulishsemiBold.copyWith(fontSize: 16, color: didiyieColor.black),),
                                  SizedBox(height: height/100,),
                                  Text(griddesc[index].toString(),style: mulishmedium.copyWith(fontSize: 14, color:didiyieColor.lightappcolor),)
                                ],
                              ),
                            ),
                            const Spacer(),
                            Image.asset(selectindex == index ?
                            didiyiePngimage.radiobtnfill : didiyiePngimage.radiobtn,
                              height: height / 36,fit: BoxFit.fitHeight,
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height/26,),
              InkWell(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const didiyieChooseFlow();
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
      ),

    );
  }
}
