import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_scanqrcode.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyiePaymentsuccess extends StatefulWidget {
  const didiyiePaymentsuccess({Key? key}) : super(key: key);

  @override
  State<didiyiePaymentsuccess> createState() => _didiyiePaymentsuccessState();
}

class _didiyiePaymentsuccessState extends State<didiyiePaymentsuccess> {
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
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(didiyiePngimage.walletimg,height: height/6,fit: BoxFit.fitHeight,),
              SizedBox(height: height/36,),
              Text("Woohoo!",style: mulishsemiBold.copyWith(fontSize: 18,color: didiyieColor.black),),
              SizedBox(height: height/56,),
              Text("Thank you for your payment!",style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),

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
              onbackpressed();
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
                  "Continue",
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

  onbackpressed() {
    return showDialog(
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/56),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.close,size: 22)
                    ],
                  ),
                  Image.asset(didiyiePngimage.star,height: height/6,fit: BoxFit.fitHeight,),
                  SizedBox(height: height/36,),
                  Text("Tell us about your experience",style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.black),),
                  SizedBox(height: height/36,),
                  Text("We love to hear from you how was the whole experience in our restaurant.",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: height/36,),
                  InkWell(
                    onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const didiyieScanqrCode();
                      },));
                    },
                    child: Container(
                      height: height / 13,
                      width: width/1,
                      decoration: BoxDecoration(
                        color: didiyieColor.appcolor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "Add_feedback".tr,
                          style: mulishsemiBold.copyWith(
                              fontSize: 16, color: didiyieColor.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

}
