import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_paymentsuccess.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_rewards.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieCheckout extends StatefulWidget {
  const didiyieCheckout({Key? key}) : super(key: key);

  @override
  State<didiyieCheckout> createState() => _didiyieCheckoutState();
}

class _didiyieCheckoutState extends State<didiyieCheckout> {
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
              Row(
                children: [
                  Text("Payment method",style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.black),),
                  const Spacer(),
                  Text("Add new card",style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.yellow),),
                ],
              ),
              SizedBox(height: height/36,),
              Image.asset(didiyiePngimage.card,width: width/1,fit: BoxFit.fitWidth,),
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

                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const didiyieRewards();
                          },));
                        },
                        child: Container(
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
                return const didiyiePaymentsuccess();
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
                  "Pay \$50.00",
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
