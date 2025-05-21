import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_orderalmostready.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieOrderPreparing extends StatefulWidget {
  const didiyieOrderPreparing({Key? key}) : super(key: key);

  @override
  State<didiyieOrderPreparing> createState() => _didiyieOrderPreparingState();
}

class _didiyieOrderPreparingState extends State<didiyieOrderPreparing> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  List<String> tname = ["Avocado and Egg Toast","Curry Salmon","Yogurt and fruits"];
  List<String> img = [
   didiyiePngimage.f1,
   didiyiePngimage.f2,
   didiyiePngimage.f3,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height/56,),
                  // Text("Gram Bistro",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
                  Text("Your order status",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.black),),
                ],
              ),
              const Spacer(),
              Image.asset(didiyiePngimage.menuicon,height: height/30,fit: BoxFit.fitHeight,)

            ],
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: didiyieColor.white,
                    boxShadow: const [
                      BoxShadow(
                          color: didiyieColor.greyy, blurRadius: 4)
                    ]),
                child:Column(
                  children: [
                    SizedBox(height: height/26,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/36),
                      child: Text("Your order will be ready in ",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.lightappcolor),),
                    ),
                    SizedBox(height: height/56,),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: width/36),
                      child: Text("10 minutes",style: mulishbold.copyWith(fontSize: 18,color: didiyieColor.yellow),),
                    ),
                    SizedBox(height: height/36,),
                    Image.asset(didiyiePngimage.orderstatus1,width: width/1,fit: BoxFit.fitWidth,)
                  ],
                ),

              ),
              SizedBox(height: height/46,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: didiyieColor.white,
                    boxShadow: const [
                      BoxShadow(
                          color: didiyieColor.greyy, blurRadius: 4)
                    ]),
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Order list and prices ",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_up,size: 25,color: didiyieColor.yellow,)
                        ],
                      ),
                      SizedBox(height: height/46,),
                      ListView.builder(
                        itemCount: tname.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: didiyieColor.transparent,
                            highlightColor: didiyieColor.transparent,
                            onTap: () {
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: didiyieColor.transparent,
                                  child: Image.asset(
                                    img[index].toString(),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 36,
                                ),
                                Text(
                                  tname[index].toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.black),
                                ),
                                const Spacer(),
                                Text(
                                  "2x \$10.00 ",
                                  style: mulishbold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                                ),

                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: height/56,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add,color: didiyieColor.yellow,size: 22,),
                          SizedBox(width: width/46,),
                          Text(
                            "Add more food to order",
                            style: mulishsemiBold.copyWith(
                                fontSize: 16, color: didiyieColor.yellow),
                          ),

                        ],
                      ),
                      SizedBox(height: height/26,),
                      const Divider(color: didiyieColor.greyy,),
                      SizedBox(height: height/36,),
                      Row(
                        children: [
                          Text(
                            "Items Total",
                            style: mulishsemiBold.copyWith(
                                fontSize: 16, color: didiyieColor.lightappcolor),
                          ),
                          const Spacer(),
                          Text(
                            "\$45.00",
                            style: mulishbold.copyWith(
                                fontSize: 16, color: didiyieColor.lightappcolor),
                          ),

                        ],
                      ),
                      SizedBox(height: height/36,),
                      Row(
                        children: [
                          Text(
                            "Tax",
                            style: mulishsemiBold.copyWith(
                                fontSize: 16, color: didiyieColor.lightappcolor),
                          ),
                          const Spacer(),
                          Text(
                            "\$05.00",
                            style: mulishbold.copyWith(
                                fontSize: 16, color: didiyieColor.lightappcolor),
                          ),

                        ],
                      ),
                      SizedBox(height: height/36,),
                      const Divider(color: didiyieColor.greyy,),
                      SizedBox(height: height/46,),
                      Row(
                        children: [
                          Text(
                            "Total price",
                            style: mulishsemiBold.copyWith(
                                fontSize: 16, color: didiyieColor.black),
                          ),
                          const Spacer(),
                          Text(
                            "\$50.00",
                            style: mulishbold.copyWith(
                                fontSize: 16, color: didiyieColor.orange  ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: didiyieColor.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
            ]
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
          child: InkWell(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const didiyieOrderAlmostready();
              },));
            },
            child: Container(
              height: height / 13,
              width: width/1.8,
              decoration: BoxDecoration(
                color: didiyieColor.appcolor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Next",
                  style: mulishsemiBold.copyWith(
                      fontSize: 16, color: didiyieColor.white),
                ),
              ),
            ),
          ),
        ),

      ),


    );
  }
}
