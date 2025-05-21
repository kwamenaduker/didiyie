import 'package:flutter/material.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieRewards extends StatefulWidget {
  const didiyieRewards({Key? key}) : super(key: key);

  @override
  State<didiyieRewards> createState() => _didiyieRewardsState();
}

class _didiyieRewardsState extends State<didiyieRewards> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  List<String> tname = ["Refer a friend","2 for 1","3.200 points"];
  List<String> tprice = ["Share your promo code with a friend","Buy 2 dishes and get 1 for free","Transform your points in real USD"];

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
              SizedBox(width: width/56,),
              Text("My Rewards",style: mulishsemiBold.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Use your rewards or new ones ",style: mulishsemiBold.copyWith(fontSize: 22,color: didiyieColor.black),),
              SizedBox(height: height/36,),
              Image.asset(didiyiePngimage.discountcard,width: width/1,fit: BoxFit.fitWidth,),
              SizedBox(height: height/36,),
              Text("Get new rewards",style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.lightappcolor),),
              SizedBox(height: height/36,),
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
                    child: Container(
                      width: width/1,
                      decoration: BoxDecoration(
                          color: didiyieColor.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                          ]
                      ),
                      margin: EdgeInsets.only(bottom: height/56),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 36, vertical: height / 46),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tname[index].toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: mulishsemiBold.copyWith(fontSize: 16,color: didiyieColor.black),
                                ),
                                SizedBox(height: height/46,),
                                Text(
                                  tprice[index].toString(),
                                  style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward,size: 22,color: didiyieColor.orange,)

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
