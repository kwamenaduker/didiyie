import 'package:flutter/material.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_digital_assistent.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_icons.dart';

class didiyieChooseFlow extends StatefulWidget {
  const didiyieChooseFlow({Key? key}) : super(key: key);

  @override
  State<didiyieChooseFlow> createState() => _didiyieChooseFlowState();
}

class _didiyieChooseFlowState extends State<didiyieChooseFlow> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  List<String> gridname = ["Choose Virtual Assistant","Go to the menu"];
  List<String> griddesc = ["Simplify your decisions through\nour Smart Menu","If you already know what to order\nthis is the best choice"];
  List<String> gridimage = [didiyiePngimage.fp1,didiyiePngimage.fp2];

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
              Text("Let’s find the perfect dish for \nyou",textAlign: TextAlign.start,style: mulishmedium.copyWith(fontSize: 22),),
              SizedBox(height: height/30,),
              ListView.builder(
                itemCount: gridname.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: didiyieColor.transparent,
                    highlightColor: didiyieColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const didiyieDigitalAssistent();
                      },));
                    },
                    child:  Container(
                      width: width / 1,
                      margin: EdgeInsets.only(bottom: height/36),
                      decoration: BoxDecoration(
                          color: didiyieColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: didiyieColor.greyy, blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/36),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(gridimage[index].toString(), height: height / 10,fit: BoxFit.fitHeight,),
                            SizedBox(height: height/36,),
                            Text(gridname[index].toString(),style: mulishsemiBold.copyWith(fontSize: 16, color: didiyieColor.black),),
                            SizedBox(height: height/100,),
                            Row(
                              children: [
                                Text(griddesc[index].toString(),style: mulishmedium.copyWith(fontSize: 14, color:didiyieColor.lightappcolor,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                const Spacer(),
                                Container(
                                    height: height/16,
                                    width: height/16,
                                    decoration: BoxDecoration(
                                        color: didiyieColor.lightorange,
                                        borderRadius: BorderRadius.circular(16),
                                       ),
                                    child: const Icon(Icons.arrow_forward,color: didiyieColor.orange,size: 20,)

                                ),
                              ],
                            )
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
