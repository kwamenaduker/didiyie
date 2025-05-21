import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_page/didiyie_Authentication/didiyie_signup.dart';

import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';
import '../../didiyie_gloableclass/didiyie_fontstyle.dart';

class didiyieEmailverification extends StatefulWidget {
  const didiyieEmailverification({Key? key}) : super(key: key);

  @override
  State<didiyieEmailverification> createState() => _didiyieEmailverificationState();
}

class _didiyieEmailverificationState extends State<didiyieEmailverification> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          children: [
            SizedBox(height: height/6,),
            Text("What’s your email? 📨",style: dmmedium.copyWith(fontSize: 22),),
            SizedBox(height: height/56,),
            Text("We need it to search after your account or \ncreate a new one",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.appcolor),),
            SizedBox(height: height/26,),
            TextField(
              cursorColor: didiyieColor.black,
              style: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.black),
              decoration: InputDecoration(
                  filled: true,
                  hintStyle: mulishmedium.copyWith(fontSize: 14,color: didiyieColor.black),
                  fillColor: didiyieColor.white,
                  hintText: "Email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: didiyieColor.appgray)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: didiyieColor.appgray)),
             ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieSignup();
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
                    "Next".tr,
                    style: mulishsemiBold.copyWith(
                        fontSize: 16, color: didiyieColor.white),
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
