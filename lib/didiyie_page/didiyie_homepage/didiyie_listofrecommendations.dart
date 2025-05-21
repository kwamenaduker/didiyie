import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_filter.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_viewdish.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieListRecommendations extends StatefulWidget {
  const didiyieListRecommendations({Key? key}) : super(key: key);

  @override
  State<didiyieListRecommendations> createState() => _didiyieListRecommendationsState();
}

class _didiyieListRecommendationsState extends State<didiyieListRecommendations> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int? selectindex;
  List<String> gridname = ["Eat","Drink","Dessert","Salad"];
  List<String> fname = ["Avocado and Egg Toast","Mac and Cheese","Power bowl","Vegetable Salad"];
  List<String> img1 = [
    didiyiePngimage.f1,
    didiyiePngimage.f2,
    didiyiePngimage.f3,
    didiyiePngimage.f4,
  ];

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
              Image.asset(didiyiePngimage.locationpoint,height: height/26,fit: BoxFit.fitHeight,),
              SizedBox(width: width/96,),
              Text("Gram Bistro",textAlign: TextAlign.center,style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const didiyieFilter();
                  },));
                },
                  child: Image.asset(didiyiePngimage.menuicon,height: height/30,fit: BoxFit.fitHeight,))

            ],
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height/36,vertical: width/26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("We think you might enjoy these specially selected dishes",style: mulishmedium.copyWith(fontSize: 22),maxLines: 2,overflow: TextOverflow.ellipsis,),
              SizedBox(height: height/36,),
              Row(
                children: [
                  SizedBox(
                    height: height/15,
                    width: width/1.5,
                    child: ListView.builder(
                      itemCount: gridname.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: didiyieColor.transparent,
                          highlightColor: didiyieColor.transparent,
                          onTap: () {
                            setState(() {
                              selectindex = index;
                            });
                          },
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              margin: EdgeInsets.only(right: width/36),
                              decoration: BoxDecoration(
                                  color: selectindex == index ?didiyieColor.yellow :didiyieColor.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: didiyieColor.greyy, blurRadius: 3)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width/26),
                                child: Center(child: Text(gridname[index].toString(),style: mulishsemiBold.copyWith(fontSize: 16, color: selectindex == index ?didiyieColor.white :didiyieColor.lightappcolor,),)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Container(
                      height: height/16,
                      width: height/16,
                      decoration: BoxDecoration(
                        color: didiyieColor.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                        ]
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(didiyiePngimage.listicon,height: height/36,fit: BoxFit.fitHeight,),
                      ),

                  ),
                ],
              ),
              SizedBox(height: height/36,),
              ListView.builder(
                itemCount: img1.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: didiyieColor.transparent,
                    highlightColor: didiyieColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const didiyieViewdish();
                      },));
                    },
                    child:Container(
                      margin: EdgeInsets.only(bottom: height/36),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: didiyieColor.white,
                          boxShadow: const [
                            BoxShadow(
                                color: didiyieColor.greyy, blurRadius: 10)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height / 96, horizontal: width / 36),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: didiyieColor.transparent,
                              child: Image.asset(
                                img1[index],
                              ),
                            ),
                            SizedBox(width: width / 36),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  fname[index],
                                  style: mulishsemiBold.copyWith(
                                      fontSize: 14, color: didiyieColor.black),
                                ),
                                SizedBox(height: height / 120),
                                Row(
                                  children: [
                                    Image.asset(didiyiePngimage.starhalf,height: height/36,fit: BoxFit.fitHeight,),
                                    SizedBox(width: width/56,),
                                    Text(
                                      "4.9 (120 reviews)",
                                      style: mulishsemiBold.copyWith(
                                          fontSize: 12, color: didiyieColor.lightappcolor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height / 46),
                                Text(
                                  "\$10.40",
                                  style: mulishbold.copyWith(
                                      fontSize: 14, color: didiyieColor.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  );
                },
              ),


            ],
          ),
        ),
      ),

    );
  }
}
