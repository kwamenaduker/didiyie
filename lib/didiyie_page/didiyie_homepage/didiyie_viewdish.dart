import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_icons.dart';
import 'package:didiyie/didiyie_page/didiyie_homepage/didiyie_vieworder.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';

class didiyieViewdish extends StatefulWidget {
  const didiyieViewdish({Key? key}) : super(key: key);

  @override
  State<didiyieViewdish> createState() => _didiyieViewdishState();
}

class _didiyieViewdishState extends State<didiyieViewdish> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
 List<int> isselected = [];

  List<String> fname = ["Mac and Cheese","Curry Salmon","Power bowl"];
  List<String> img1 = [
    didiyiePngimage.f2,
    didiyiePngimage.f3,
    didiyiePngimage.f4,
  ];

  List<String> gridno = ["400","510","30","56","24"];
  List<String> gridname = ["kcal","grams","proteins","carbs","fats"];

  List<String> img = [
    didiyiePngimage.egg,
    didiyiePngimage.avocado,
    didiyiePngimage.salad,
  ];
  List<String> name = ["Egg","Avocado","Spinach"];

  List<String> tname = ["Extra eggs","Extra spinach","Extra bread","Extra tomato","Extra cucumber","Extra olives","Extra pepper","Extra avocado"];
  List<String> tprice = ["\$4.20","\$2.80","\$1.80","\$2.10","\$1.60","\$3.50","\$1.50","\$5.40"];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          highlightColor: didiyieColor.transparent,
          splashColor: didiyieColor.transparent,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: height/26,
                width: height/26,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
          child: Column(
            children: [
              Stack(
            children: [
              Image.asset(didiyiePngimage.dish,width: width/1,fit: BoxFit.fitWidth,),
              Positioned(
                  top: 1,
                  right: 10,
                  child:  Container(
                    decoration: BoxDecoration(
                      color: didiyieColor.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(didiyiePngimage.starhalf,height: height/36,fit: BoxFit.fitHeight,),
                          SizedBox(width: width/56,),
                          Text(
                            "4.9",
                            style: mulishsemiBold.copyWith(
                                fontSize: 14, color: didiyieColor.lightappcolor),
                          ),

                        ],
                      ),
                    ),
                      )
              )

        ],
          ),
              SizedBox(height: height/56,),
              Row(
                children: [
                  Text(
                    "Avocado and\nEgg Toast",
                    style: mulishbold.copyWith(
                        fontSize: 20, color: didiyieColor.black),
                  ),
                  const Spacer(),
                  Text(
                    "\$10.00",
                    style: mulishbold.copyWith(
                        fontSize: 24, color: didiyieColor.orange),
                  ),

                ],
              ),
              SizedBox(height: height/36,),
              Text(
                "You won't skip the most important meal of the\nday with this avocado toast recipe. Crispy, lacy\neggs and creamy avocado top hot buttered toast. ",
                style: mulishmedium.copyWith(
                    fontSize: 14, color: didiyieColor.lightappcolor),
              ),
              SizedBox(height: height/36,),
              Container(
                decoration: BoxDecoration(
                    color: didiyieColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                    ]
                ),
                child:SizedBox(
                  height: height/13,
                  width: width/1,
                  child: ListView.builder(
                    itemCount: gridname.length,

                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: didiyieColor.transparent,
                        highlightColor: didiyieColor.transparent,
                        onTap: () {
                          setState(() {
                          });
                        },
                        child:  Padding(
                          padding:  EdgeInsets.symmetric(vertical: height/120,horizontal: width/20),
                          child: Column(
                            children: [
                              Text(gridno[index].toString(),style: mulishsemiBold.copyWith(fontSize: 14, color:didiyieColor.black,),),
                              SizedBox(height: height/120               ,),
                              Text(gridname[index].toString(),style: mulishsemiBold.copyWith(fontSize: 12, color:didiyieColor.lightappcolor,),),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Text(
                    'Ingredients'.tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.lightappcolor),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              SizedBox(
                height: height / 7.5,
                child: ListView.builder(
                  itemCount: img.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: didiyieColor.transparent,
                      highlightColor: didiyieColor.transparent,
                      onTap: () {},
                      child: Container(
                        height: height / 8.5,
                        width: width/4,
                        decoration: BoxDecoration(
                            color: didiyieColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                            ]
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: width / 36, vertical: height / 96),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 36, vertical: height / 96),
                          child: Column(
                            children: [
                              Image.asset(
                                img[index].toString(),
                                height: height / 20,
                              ),
                              SizedBox(
                                height: height / 96,
                              ),
                              Text(
                                name[index].toString(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Text(
                    'Add_toppings'.tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.lightappcolor),
                  ),
                ],
              ),
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
                      setState(() {
                        if(isselected.contains(index)){
                          isselected.remove(index);
                        }else{
                          isselected.add(index);
                        }

                      });
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
                            Image.asset(
                              isselected.contains(index) ?
                              didiyiePngimage.checkbox:
                              didiyiePngimage.uncheck,
                              height: height / 36,
                            ),
                            SizedBox(
                              width: width / 36,
                            ),
                            Text(
                              tname[index].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                            ),
                            const Spacer(),
                            Text(
                              tprice[index].toString(),
                              style: mulishbold.copyWith(fontSize: 14,color: didiyieColor.orange),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Text(
                    'Recommended_sides'.tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.lightappcolor),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              ListView.builder(
                itemCount: img1.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: didiyieColor.transparent,
                    highlightColor: didiyieColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const didiyieViewdish();
                      },));
                    },
                    child:Container(
                      margin: EdgeInsets.only(bottom: height/36),
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
                                  backgroundColor:didiyieColor.appgray ,
                                  child: Image.asset(didiyiePngimage.minus,height: height/36,fit: BoxFit.fitHeight,),
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

                  );
                },
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Text(
                    'Add_request'.tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.lightappcolor),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Container(
                width: width/1,
                height: height/8,
                decoration: BoxDecoration(
                    color: didiyieColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: didiyieColor.greyy,blurRadius: 3)
                    ]
                ),
                child: TextField(
                  cursorColor: didiyieColor.black,
                  style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                  decoration: InputDecoration(
                    filled: true,
                    hintStyle: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.lightappcolor),
                    fillColor: didiyieColor.white,
                    hintText: "Ex: Don’t add onion",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    ),
                ),
              ),


            ]
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
          child: Row(
            children: [
              Container(
                height: height/13,
                decoration:  BoxDecoration(
                    color: didiyieColor.appgray,
                    borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Icon(Icons.minimize,size: 25,color: didiyieColor.appcolor,),
                      ),
                      SizedBox(width: width/46,),
                      Text(
                        "0",
                        style: mulishsemiBold.copyWith(
                            fontSize: 16, color: didiyieColor.lightappcolor),
                      ),

                      SizedBox(width: width/46,),
                      const Icon(Icons.add,size: 25,color: didiyieColor.appcolor,),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const didiyieVieworder();
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
                      "Add to order \$20.00",
                      style: mulishsemiBold.copyWith(
                          fontSize: 16, color: didiyieColor.white),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),

    );
  }
}
