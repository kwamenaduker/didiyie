import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_listofrecommendations.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieScanqrCode extends StatefulWidget {
  const didiyieScanqrCode({Key? key}) : super(key: key);

  @override
  State<didiyieScanqrCode> createState() => _didiyieScanqrCodeState();
}

class _didiyieScanqrCodeState extends State<didiyieScanqrCode> {
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
              const Spacer(),
              Image.asset(didiyiePngimage.menuicon,height: height/30,fit: BoxFit.fitHeight,)

            ],
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          children: [
            SizedBox(height: height/26,),
            Text("The last step before you go",style: mulishmedium.copyWith(fontSize: 22,color: didiyieColor.black),),
            SizedBox(height: height/16,),
            Image.asset(didiyiePngimage.scancode,height: height/3.5,fit: BoxFit.fitHeight,),
            SizedBox(height: height/26,),
            Text("Please scan the QR Code at the\nexit of restaurant.",textAlign: TextAlign.center,style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
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
                      "Scan later",
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
                      "Scan now",
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
