import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_addcard.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieOrderDone extends StatefulWidget {
  const didiyieOrderDone({Key? key}) : super(key: key);

  @override
  State<didiyieOrderDone> createState() => _didiyieOrderDoneState();
}

class _didiyieOrderDoneState extends State<didiyieOrderDone> {
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
                      child: Text("Your dishes are ready.",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.lightappcolor),),
                    ),
                    SizedBox(height: height/56,),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: width/36),
                      child: Text("Enjoy!",style: mulishbold.copyWith(fontSize: 18,color: didiyieColor.yellow),),
                    ),
                    SizedBox(height: height/36,),
                    Image.asset(didiyiePngimage.orderstatus3,width: width/1,fit: BoxFit.fitWidth,)
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
                          const Icon(Icons.keyboard_arrow_down_sharp,size: 25,color: didiyieColor.yellow,)
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
                return const didiyieAddCard();
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
                  "Pay \$53.20",
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
