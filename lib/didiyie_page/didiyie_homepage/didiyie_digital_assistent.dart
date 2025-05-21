import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_recommendationhistory.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieDigitalAssistent extends StatefulWidget {
  const didiyieDigitalAssistent({Key? key}) : super(key: key);

  @override
  State<didiyieDigitalAssistent> createState() => _didiyieDigitalAssistentState();
}

class _didiyieDigitalAssistentState extends State<didiyieDigitalAssistent> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: Column(
        children: [
          Image.asset(didiyiePngimage.da1,width: width/1,fit: BoxFit.fitWidth,),
          SizedBox(height: height/36,),
          Text("Hello! 👋\nI’m your virtual assistant.",textAlign: TextAlign.center,style: dmmedium.copyWith(fontSize: 22),),
          SizedBox(height: height/56,),
          Text("In order to find the best suited choices for\nyou, please answer the next few questions.",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.appcolor),),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 36),
            child: InkWell(
              onTap: () {
                /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieGetStarted();
                },));*/
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
                    "Take_me_to_the_menu".tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.appcolor),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 36, vertical: height / 56),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieRecommendationHistory();
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
                    "Great_lets_start".tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height/36,)

        ],
      ),

    );
  }
}
