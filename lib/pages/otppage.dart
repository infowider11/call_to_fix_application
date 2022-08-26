import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';

class Otp_Page extends StatefulWidget {
  static const String id="OTP_Page";
  const Otp_Page({Key? key}) : super(key: key);

  @override
  State<Otp_Page> createState() => _Otp_PageState();
}

class _Otp_PageState extends State<Otp_Page> {
  TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.leaf_top),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.leaf_bottom),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomLeft
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSizedBox2,
                  ParagraphText(text: 'Enter Verification code', fontFamily: 'medium', fontSize: 20,),
                  ParagraphText(text: 'We have sent you a 4 digit verification code on\nthe given mobilenumber',
                    color: MyColors.textcolor, fontSize: 15,textAlign: TextAlign.center,),
                  vSizedBox2,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 52),
                    width: 240,
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextField(controller: namecontroller, hintText: '')),
                        hSizedBox,
                        Expanded(
                            child: CustomTextField(controller: namecontroller, hintText: '')),
                        hSizedBox,
                        Expanded(
                            child: CustomTextField(controller: namecontroller, hintText: '')
                        ),
                        hSizedBox,
                        Expanded(
                            child: Column(
                              children: [
                                CustomTextField(controller: namecontroller, hintText: '',),
                              ],
                            )),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  ParagraphText(text: 'Resend Code', fontFamily: 'semibold', fontSize: 15,color: MyColors.primaryColor,),
                  vSizedBox2,
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'CONTINUE',
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onTap: ()async{
                      if(currentUserType==UserType.user){
                        Navigator.pushNamed(context, TabsPage.id);
                      }else{

                        Navigator.pushNamed(context, Personal_Information_Page.id);
                      }
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
