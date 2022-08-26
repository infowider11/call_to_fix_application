import 'dart:developer';

import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../pages/signupuser.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/otp_widget.dart';
// import '../constanimport '../pages/signupuser.dart';
// ts/sized_box.dart';
// import '../constants/sized_box.dart';
// import '../pages/signupuser.dart';
// import '../widgets/CustomTexts.dart';
// import '../widgets/buttons.dart';
// import '../widgets/customtextfield.dart';
// import '../widgets/otp_widget.dart';

class Provider_Otp_Page extends StatefulWidget {
  // static const String id="Provider_Otp_Page";
  final Map<String, dynamic> userDetails;
  final Map<String, dynamic> request;
  // final Map? data;
  const Provider_Otp_Page({Key? key, required this.userDetails, required this.request,}) : super(key: key);

  @override
  State<Provider_Otp_Page> createState() => _Provider_Otp_PageState();
}

class _Provider_Otp_PageState extends State<Provider_Otp_Page> {
  TextEditingController namecontroller = TextEditingController();

  bool showOTPWidget = true;

  bool load = false;

  showLoading()async{
    setState(() {
      load = true;
    });
    try{
      // print("datata"+widget.request.toString());

      print("usertgffgdfype"+widget.request.toString());
      if(currentUserType==UserType.user){
        await pushReplacement(context: context, screen: SignUp_Page(data: widget.request,));
        // var res=await Webservices.postData(apiUrl: ApiUrls.signupUser, body: widget.data!, context: context);
        // log(res.toString());
        // if(res['status'].toString()=='1'){
        //   await updateSharedPreferences(res['data']['id']);
        //   await Navigator.of(context)
        //       .pushNamedAndRemoveUntil(TabsPage.id, (Route<dynamic> route) => false);
        // }
      }else if(currentUserType==UserType.provider){
        await pushReplacement(context: context, screen: Personal_Information_Page(request: widget.request,));

      }

      setState(() {
        load = false;
      });
    }catch(e){
      print('error in otp verification error$e');
      load = false;
      setState(() {

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      body:
      // load?CustomLoader():
      SafeArea(
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
                  if(showOTPWidget)
                    OtpVerification(
                        bgColor: Colors.white,
                        borderColor: Colors.transparent,
                        textColor: Colors.black,
                        correctOtp: widget.userDetails['token'].toString(),
                        userDetails:widget.userDetails,
                        load: showLoading,
                        wrongOtp: (){
                          setState(() {
                            showOTPWidget = false;
                          });
                          Future.delayed(Duration(milliseconds: 100)).then((value){
                            setState(() {
                              showOTPWidget = true;
                            });
                          });
                        },
                        navigationFrom: 'signup_otp_verification_screen')
                  else
                    SizedBox(height: 100,),
                  vSizedBox2,
                  GestureDetector(
                      child: ParagraphText(text: 'Resend Code', fontFamily: 'semibold', fontSize: 15,color: MyColors.primaryColor,
                      ),
                    onTap: ()async{

                        setState(() {
                          load = true;
                        });
                        await Webservices.postData(apiUrl: ApiUrls.resent_otp, body: widget.request, context: context, showSuccessMessage: true);
                        setState(() {
                          load = false;
                        });
                    },
                  ),
                  vSizedBox2,
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'CONTINUE',
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onTap: (){
                      Navigator.pushNamed(context, Personal_Information_Page.id);
                    },
                  ),

                ],
              ),
            ),
            // if(load)
            //   CustomFullPageLoader()
          ],
        ),
      ),
    );
  }
}
