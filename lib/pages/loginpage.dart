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

import '../constants/constans.dart';
import '../constants/image_urls.dart';
import '../provider_pages/provider_otppage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../widgets/customLoader.dart';
class LoginPage extends StatefulWidget {
  static const String id="LoginPage";
  // final Map? data;
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumberController = TextEditingController();
  bool phoneVlidate =false;
  String phonenumber = '';
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
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
                  ParagraphText(text: 'Welcome! to Call to fix', fontFamily: 'medium', fontSize: 20,),
                  ParagraphText(text: 'Signup to continue', color: MyColors.textcolor, fontSize: 15,),
                  vSizedBox2,
                  // CustomTextField(controller: phone, hintText: 'Enter mobile number'),
                  CustomPhoneNumberInput(
                    controller: mobileNumberController,
                    hintText: 'Enter mobile number',
                    initialNumber: number,

                    onInputChanged: (PhoneNumber number){
                      phonenumber = number.dialCode!;
                      initialCountry=number.isoCode!;
                    },
                    onInputValidated: (bool value){
                      setState(() {
                        phoneVlidate=value;
                      });

                    },

                  ),
                  vSizedBox2,
                  vSizedBox2,

                  RoundEdgedButton(
                    text: 'CONTINUE',
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onTap: ()async{
                      // await push(context: context, screen: Otp_Page());
                      if(mobileNumberController.text.length<9){
                        showSnackbar('Please Enter a valid mobile number');
                      }else if(phonenumber==null){
                        print(number.toString());
                        showSnackbar('Please select a valid country');
                      }else{
                        setState(() {
                          load = true;
                        });
                        var request ={
                          "phone_code": phonenumber,
                          "phone_number": mobileNumberController.text,
                        };
                        var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.verifyMobile, body: request, context: context,);
                        print('------------------'+jsonResponse.toString());

                        if(jsonResponse['status'].toString()=='1') {
                          // if (currentUserType == UserType.user) {
                          //   widget.data!['phone'] = mobileNumberController.text;
                          //   widget.data!['phone_code'] = phonenumber;
                          //   print(
                          //       '------------------' + widget.data.toString());
                          //   await push(context: context,
                          //       screen: Provider_Otp_Page(
                          //           userDetails: jsonResponse['data'],
                          //           request: request,
                          //           data: widget.data));
                          // }
                          // else if(currentUserType == UserType.provider){
                            await push(context: context,
                                screen: Provider_Otp_Page(
                                    userDetails: jsonResponse['data'],
                                    request: request,));
                          // }
                        }
                        else{
                          print('------------------'+jsonResponse.toString());
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
