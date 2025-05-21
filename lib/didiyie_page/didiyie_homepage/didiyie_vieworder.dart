import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_orderpreparing.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class didiyieVieworder extends StatefulWidget {
  const didiyieVieworder({Key? key}) : super(key: key);

  @override
  State<didiyieVieworder> createState() => _didiyieVieworderState();
}

class _didiyieVieworderState extends State<didiyieVieworder> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  List<String> fname = ["Mac and Cheese","Curry Salmon","Power bowl"];
  List<String> img1 = [
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
                children: [
                  SizedBox(height: height/56,),
                  // Text("Gram Bistro",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
                  Text("Your order",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.black),),
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
              ListView.builder(
                itemCount: img1.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: height/36),
                    child: Slidable(
                      // key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion:  const DrawerMotion(),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            flex: 1,
                            onPressed: (value) {
                            //  fname.removeAt(index);
                              setState(() {});
                            },
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(16),bottomRight: Radius.circular(16)),
                            backgroundColor: didiyieColor.yellow,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: Container(
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
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor:didiyieColor.lightorange ,
                                    child: Image.asset(didiyiePngimage.minus,height: height/36,fit: BoxFit.fitHeight,color: didiyieColor.orange,),
                                  ),
                                  SizedBox(height: height/96,),
                                  Text(
                                    "0",
                                    style: mulishsemiBold.copyWith(
                                        fontSize: 14, color: didiyieColor.lightappcolor),
                                  ),
                                  SizedBox(height: height/96,),
                                  const CircleAvatar(
                                    radius: 15,
                                    backgroundColor:didiyieColor.lightorange ,
                                    child: Icon(Icons.add,size: 25,color: didiyieColor.orange,),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
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
              )

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
                return const didiyieOrderPreparing();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send_order".tr,
                      style: mulishsemiBold.copyWith(
                          fontSize: 16, color: didiyieColor.white),
                    ),
                    SizedBox(width: width/56,),
                    const Icon(Icons.arrow_forward,size: 22,color: didiyieColor.white,)
                  ],
                ),
              ),
            ),
          ),
        ),

      ),


    );
  }
}
