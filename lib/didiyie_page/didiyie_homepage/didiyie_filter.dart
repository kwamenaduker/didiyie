import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_fontstyle.dart';

import '../../didiyie_gloableclass/didiyie_color.dart';

class didiyieFilter extends StatefulWidget {
  const didiyieFilter({Key? key}) : super(key: key);

  @override
  State<didiyieFilter> createState() => _didiyieFilterState();
}

class _didiyieFilterState extends State<didiyieFilter> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int? selectindex;
  int? selectedindex;
  List<String> gridname = ["Food","Drink","Dessert"];
  List<String> title2 = ["Pizza","Burger","Salad","Soup","Chicken","Grill","Breakfast"];
  List<String> rating = ["1","2","3","4","5"];
  RangeValues _currentRangeValues = const RangeValues(20, 40);

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
        title: Text('Filters'.tr,style: mulishsemiBold.copyWith(fontSize: 16),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
          child: Column(
            children: [
              Text('Select_Categories'.tr,style: mulishsemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/46,),
              SizedBox(
                height: height/15,
                child: ListView.builder(
                  itemCount: gridname.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: didiyieColor.transparent,
                      highlightColor: didiyieColor.transparent,
                      onTap: () {
                        setState(() {
                          selectindex = index;
                        });
                      },
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          margin: EdgeInsets.only(right: width/36),
                          decoration: BoxDecoration(
                              color: selectindex == index ?didiyieColor.yellow :didiyieColor.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color:selectindex == index ?didiyieColor.transparent :didiyieColor.lightappcolor, ),
                              boxShadow: const [
                                BoxShadow(
                                    color: didiyieColor.greyy, blurRadius: 3)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/26),
                            child: Center(child: Text(gridname[index].toString(),style: mulishsemiBold.copyWith(fontSize: 16, color: selectindex == index ?didiyieColor.white :didiyieColor.lightappcolor,),)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height/26,),
              Text('Select_Product_Type'.tr,style: mulishsemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/46,),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                  MediaQuery.of(context).size.aspectRatio * 7.5 / 1.75,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: title2.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: width / 36),
                    child: InkWell(
                      splashColor: didiyieColor.transparent,
                      highlightColor: didiyieColor.transparent,
                      onTap: () {
                        setState(() {
                          selectedindex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: selectedindex == index ?didiyieColor.transparent :didiyieColor.lightappcolor,),
                            color: selectedindex == index ? didiyieColor.yellow:didiyieColor.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 36,),
                          child: Center(
                            child: SizedBox(
                              //width: width/6.8,
                              child: Text(
                                title2[index],
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: mulishbold.copyWith(
                                    fontSize: 16, color: selectindex == index ? didiyieColor.white:didiyieColor.lightappcolor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height/26,),
              Text('Rating'.tr,style: mulishsemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/46,),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                  MediaQuery.of(context).size.aspectRatio * 7.5 / 1.75,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rating.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: width / 36),
                    child: InkWell(
                      splashColor: didiyieColor.transparent,
                      highlightColor: didiyieColor.transparent,
                      onTap: () {
/*
                        setState(() {
                          selectindex = index;
                        });
*/
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color:didiyieColor.lightappcolor,),
                            color: didiyieColor.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 36,),
                          child: Center(
                            child: SizedBox(
                              //width: width/6.8,
                              child: Row(
                                children: [
                                  const Icon(Icons.star,size: 20,color: didiyieColor.yellow,),
                                  SizedBox(width: width/46,),
                                  Text(
                                    rating[index],
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: mulishbold.copyWith(
                                        fontSize: 16, color: didiyieColor.lightappcolor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height/26,),
              Text('Price_Range'.tr,style: mulishsemiBold.copyWith(fontSize: 16),),
              SizedBox(height: height/46,),
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                min: 0,
                activeColor: didiyieColor.yellow,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              SizedBox(height: height/26,),
              InkWell(
                onTap: () {
/*
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const didiyieListRecommendations();
                  },));
*/
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
                      "Continue".tr,
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
