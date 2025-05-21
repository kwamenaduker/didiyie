import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_listofrecommendations.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieVirtualAssistant extends StatefulWidget {
  const didiyieVirtualAssistant({Key? key}) : super(key: key);

  @override
  State<didiyieVirtualAssistant> createState() => _didiyieVirtualAssistantState();
}

class _didiyieVirtualAssistantState extends State<didiyieVirtualAssistant> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int? selectindex;
  List<String> title2 = ["Thirtsy","Hungry","Tired","Angry","Bored","Sick","Energized","Other"];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: width/1,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36),
          child: Row(
            children: [
              InkWell(
                highlightColor: didiyieColor.transparent,
                splashColor: didiyieColor.transparent,
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height/16,
                      width: height/18,
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
              SizedBox(width: width/96,),
              Text("Step 1",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
              const Spacer(),
              Text("Skip question",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.black),),

            ],
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How are you feeling right now?",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 22),),
            SizedBox(height: height/56,),
            Text("Select all that applies:",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
            SizedBox(height: height/56,),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio:
                MediaQuery.of(context).size.aspectRatio * 10.8 / 1.75,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: title2.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: width / 36),
                  child: InkWell(
                    splashColor: didiyieColor.transparent,
                    highlightColor: didiyieColor.transparent,
                    onTap: () {
                      setState(() {
                        selectindex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: didiyieColor.lightappcolor),
                          color: selectindex == index ? didiyieColor.yellow:didiyieColor.white),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 36),
                        child: Center(
                          child: Row(
                            children: [
                              Image.asset(didiyiePngimage.hotfaceemoji,height: height/36,),
                              SizedBox(width: width/56,),
                              SizedBox(
                                width: width/6.8,
                                child: Text(
                                  title2[index],
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: mulishbold.copyWith(
                                      fontSize: 16, color: selectindex == index ? didiyieColor.white:didiyieColor.lightappcolor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
                    return const didiyieListRecommendations();
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
            ),
          ],
        ),
      ),

    );
  }
}
