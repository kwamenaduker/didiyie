import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_icons.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_sharelocation.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';

class didiyieSetLocation extends StatefulWidget {
  const didiyieSetLocation({Key? key}) : super(key: key);

  @override
  State<didiyieSetLocation> createState() => _didiyieSetLocationState();
}

class _didiyieSetLocationState extends State<didiyieSetLocation> {
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
        leading: Container(
          color: didiyieColor.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(didiyiePngimage.menuicon,height: height/36,fit: BoxFit.fitHeight,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
          child: Column(
            children: [
              Text("Set your locations ",style: dmmedium.copyWith(fontSize: 22),),
              SizedBox(height: height/36,),
              Container(
                  width: width/1,
                  decoration: BoxDecoration(
                      color: didiyieColor.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: didiyieColor.greyy, blurRadius: 5)
                      ]  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width/36,vertical: height/30),
                    child: Column(
                      children: [
                        Image.asset(didiyiePngimage.qrcode,height: height/10,fit: BoxFit.fitHeight,),
                        SizedBox(height: height/30,),
                        Text("Scan QR Code",style: mulishsemiBold.copyWith(fontSize: 16),),
                        SizedBox(height: height/36,),
                        Text("Choose the simply way, scan your QR Code \nfrom our table",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),

                      ],
                    ),
                  )

              ),
              SizedBox(height: height/36,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const didiyieShareLocation();
                  },));
                },
                child: Container(
                    width: width/1,
                    decoration: BoxDecoration(
                        color: didiyieColor.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: didiyieColor.greyy, blurRadius: 5)
                        ]  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width/36,vertical: height/30),
                      child: Column(
                        children: [
                          Image.asset(didiyiePngimage.locationicon,height: height/10,fit: BoxFit.fitHeight,),
                          SizedBox(height: height/30,),
                          Text("Select location manually",style: mulishsemiBold.copyWith(fontSize: 16),),
                          SizedBox(height: height/36,),
                          Text("If you prefer to add your location manually,\nhere is your option",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),

                        ],
                      ),
                    )

                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
