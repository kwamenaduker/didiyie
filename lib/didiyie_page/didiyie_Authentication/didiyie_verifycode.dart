import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:didiyie/didiyie_gloableclass/didiyie_color.dart';

import '../../didiyie_gloableclass/didiyie_fontstyle.dart';
import '../didiyie_homepage/didiyie_setlocation.dart';

class didiyieVerifycode extends StatefulWidget {
  const didiyieVerifycode({Key? key}) : super(key: key);

  @override
  State<didiyieVerifycode> createState() => _didiyieVerifycodeState();
}

class _didiyieVerifycodeState extends State<didiyieVerifycode> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/26),
        child: Column(
          children: [
            SizedBox(height: height/16,),
            Text("Verify Code ⚡",style: dmmedium.copyWith(fontSize: 22),),
            SizedBox(height: height/56,),
            Text("We just sent a 4-digit verification code to \nrobert.fox@gmail.com. Enter the code in \nthe box below to continue.",textAlign: TextAlign.center,style: mulishmedium.copyWith(fontSize: 16,color: didiyieColor.appcolor),),
            SizedBox(height: height/26,),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height / 13,
                    width: width / 6,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin1) {},
                      decoration: InputDecoration(
                          fillColor: didiyieColor.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          )),
                      //  style: Theme.of(context).textTheme.headline6,
                      style: mulishregular.copyWith(
                          fontSize: 20,
                          color: didiyieColor.appcolor),
                      cursorColor: didiyieColor.black,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 13,
                    width: width / 6,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin2) {},
                      decoration: InputDecoration(
                          fillColor: didiyieColor.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          )),
                      //  style: Theme.of(context).textTheme.headline6,
                      style: mulishregular.copyWith(
                          fontSize: 20,
                          color: didiyieColor.appcolor),
                      cursorColor: didiyieColor.black,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 13,
                    width: width / 6,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin3) {},
                      decoration: InputDecoration(
                          fillColor: didiyieColor.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          )),
                      //  style: Theme.of(context).textTheme.headline6,
                      style: mulishregular.copyWith(
                          fontSize: 20,
                          color: didiyieColor.appcolor),
                      cursorColor: didiyieColor.black,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 13,
                    width: width / 6,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      onSaved: (pin4) {},
                      decoration: InputDecoration(
                          fillColor: didiyieColor.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: didiyieColor.lightappcolor),
                            borderRadius: BorderRadius.circular(16),
                          )),
                      //  style: Theme.of(context).textTheme.headline6,
                      style: mulishregular.copyWith(
                          fontSize: 20,
                          color: didiyieColor.appcolor),
                      cursorColor: didiyieColor.black,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    //otpdialog();
                  },
                  child: Text(
                    "Didn’t receive a code?",
                    style: mulishsemiBold.copyWith(
                        fontSize: 16,color: didiyieColor.lightappcolor
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 46,
                ),
                Text(
                  "Resend_Code".tr,
                  style: mulishbold.copyWith(
                      fontSize: 16, color: didiyieColor.yellow),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const didiyieSetLocation();
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
