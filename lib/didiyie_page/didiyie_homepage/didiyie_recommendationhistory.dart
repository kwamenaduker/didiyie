import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_virtualassistant.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieRecommendationHistory extends StatefulWidget {
  const didiyieRecommendationHistory({Key? key}) : super(key: key);

  @override
  State<didiyieRecommendationHistory> createState() => _didiyieRecommendationHistoryState();
}

class _didiyieRecommendationHistoryState extends State<didiyieRecommendationHistory> {
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
        centerTitle: true,
        leading: InkWell(
          highlightColor: didiyieColor.transparent,
          splashColor: didiyieColor.transparent,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: height/26,
                width: height/26,
                decoration: BoxDecoration(
                    color: didiyieColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: didiyieColor.greyy, blurRadius: 3)
                    ]  ),
                child: const Icon(Icons.arrow_back,color: didiyieColor.black,size: 20,)

            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(didiyiePngimage.menuicon,height: height/36,fit: BoxFit.fitHeight,),
          )
        ],

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          children: [
            Text("It seems like we already know \neach other 🤝",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 22),),
            SizedBox(height: height/36,),
            Text("You can use the recommendations\nconfigured during your last visit to our\nrestaurant or you can have new ones ",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color:didiyieColor.lightappcolor),),
            SizedBox(height: height/26,),
            Container(
                width: width/1,
                decoration: BoxDecoration(
                    color: didiyieColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: didiyieColor.greyy, blurRadius: 3)
                    ]  ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/30),
                  child: Row(
                    children: [
                      Text("New recommendation",style: mulishsemiBold.copyWith(fontSize: 16,),),
                      const Spacer(),
                      const Icon(Icons.arrow_forward,color: didiyieColor.yellow,size: 20,),
                    ],
                  ),
                )

            ),
            SizedBox(height: height/36,),
            Container(
                width: width/1,
                decoration: BoxDecoration(
                    color: didiyieColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: didiyieColor.greyy, blurRadius: 3)
                    ]  ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/36),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your last recommendation",style: mulishsemiBold.copyWith(fontSize: 16,),),
                          SizedBox(height: height/56,),
                          Row(
                            children:  [
                              const Icon(Icons.calendar_month_outlined,size: 22,color: didiyieColor.orange,),
                              SizedBox(width: width/46,),
                              Text("02/12/2020",style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward,color: didiyieColor.yellow,size: 20,),
                    ],
                  ),
                )

            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieVirtualAssistant();
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
                    "Next".tr,
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
