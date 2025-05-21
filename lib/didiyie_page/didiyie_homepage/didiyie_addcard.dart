import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_checkout.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieAddCard extends StatefulWidget {
  const didiyieAddCard({Key? key}) : super(key: key);

  @override
  State<didiyieAddCard> createState() => _didiyieAddCardState();
}

class _didiyieAddCardState extends State<didiyieAddCard> {
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
                  Text("Checkout",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.black),),
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
                    SizedBox(height: height/36,),
                    Image.asset(didiyiePngimage.cards,height: height/10,fit: BoxFit.fitHeight,),
                    SizedBox(height: height/56,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/36),
                      child: Text("You don’t have any card",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.black),),
                    ),
                    SizedBox(height: height/56,),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: width/36),
                      child: Text("Please add a credit or a debit card in order to\npay your order.",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
                    ),
                    SizedBox(height: height/36,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const didiyieCheckout();
                        },));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add,color: didiyieColor.yellow,size: 22,),
                          SizedBox(width: width/46,),
                          Text(
                            "Add a new card",
                            style: mulishsemiBold.copyWith(
                                fontSize: 16, color: didiyieColor.yellow),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: height/26,),
                  ],
                ),
              ),
              SizedBox(height: height/36,),
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

                      Container(
                        width: width/1,
                        decoration: BoxDecoration(
                          color: didiyieColor.white,
                          border: Border.all(color: didiyieColor.greyy),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/46),
                          child: Row(
                            children:  [
                              const Icon(Icons.percent,size: 23,color: didiyieColor.lightappcolor,),
                              SizedBox(width:width/46,),
                              Text(
                                "Apply discount code",
                                style: mulishsemiBold.copyWith(
                                    fontSize: 14, color: didiyieColor.lightappcolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height/46,),
                      Container(
                        width: width/1,
                        decoration: BoxDecoration(
                            color: didiyieColor.white,
                            border: Border.all(color: didiyieColor.greyy),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/46),
                          child: Row(
                            children:  [
                              Image.asset(didiyiePngimage.icontrip,height: height/36,),
                              SizedBox(width:width/46,),
                              Text(
                                "Add tips",
                                style: mulishsemiBold.copyWith(
                                    fontSize: 14, color: didiyieColor.lightappcolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height/46,),
                      const Divider(color: didiyieColor.greyy,),
                      SizedBox(height: height/56,),
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

/*
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
*/


    );
  }
}
