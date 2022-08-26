import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/custom_phone_number_input.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/error_constants.dart';
import '../constants/image_urls.dart';
import '../provider_pages/provider_otppage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../widgets/customLoader.dart';
class ForgotPasswordPage extends StatefulWidget {
  static const String id="LoginPage";
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      body: SafeArea(
        child:
        // load?CustomLoader():
        Stack(
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
                  Image.asset(MyImages.logo, height: 157,fit: BoxFit.fitHeight,),
                  vSizedBox2,
                  ParagraphText(text: 'Forgot Password?', fontFamily: 'medium', fontSize: 20,),
                  ParagraphText(text: 'Enter your email', color: MyColors.textcolor, fontSize: 15,),
                  vSizedBox2,
                  CustomTextField(controller: emailController, hintText: 'Enter your email'),

                  vSizedBox2,
                  vSizedBox2,

                  RoundEdgedButton(
                    text: 'CONTINUE',
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onTap: ()async{
                      // await push(context: context, screen: Otp_Page());
                      if (emailController.text == '') {
                        showSnackbar('Please Enter your email');
                      } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text)) {
                        showSnackbar(MyErrorConstants.invalidEmailAddress);
                      }else{
                        setState(() {
                          load = true;
                        });
                        var request ={
                          "email": emailController.text,
                        };
                        var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.forgotPassword, body: request, context: context,);
                        if(jsonResponse['status'].toString()=='1'){
                          showSnackbar('${jsonResponse['message']}');
                          Navigator.pop(context);
                        }
                        setState(() {
                          load = false;
                        });
                      }

                      // Navigator.pushNamed(context, Otp_Page.id); //Customer
                      // if(namecontroller.text=='123456'){
                      //   Navigator.pushNamed(context, Otp_Page.id); //Customer
                      // }else{
                      //   Navigator.pushNamed(context, Provider_Otp_Page.id); //Service Provider
                      // }
                      // Navigator.pushNamed(context, Otp_Page.id);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 32,
              left: 0,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.chevron_left_outlined, size: 40,),

              ),
            ),
            if(load)
              CustomFullPageLoader()
            // if(_keyboardVisible==false)
            // Positioned(
            //   bottom: 80,
            //   child:RoundEdgedButton(
            //   text: 'Skip',
            //   textColor: Colors.white,
            //   height: 35,
            //   width: 70,
            //   horizontalPadding: 0,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
