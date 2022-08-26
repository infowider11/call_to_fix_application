import 'dart:convert';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/loginpage.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/pages/pending_screen_provider.dart';
import 'package:calltofix/pages/signupuser.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/pages/welcome.dart';
import 'package:calltofix/provider_pages/forgot_password_page.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/provider_pages/provider_home_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';
import '../constants/error_constants.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../functions/showSnackbar.dart';
import '../provider_pages/about_work_page.dart';
import '../provider_pages/provider_otppage.dart';

class SignIn_Page extends StatefulWidget {
  static const String id = "SignIn_Page";
  const SignIn_Page({Key? key}) : super(key: key);

  @override
  State<SignIn_Page> createState() => _SignIn_PageState();
}

class _SignIn_PageState extends State<SignIn_Page> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
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
                      alignment: Alignment.topLeft),
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
                      alignment: Alignment.bottomLeft),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      MyImages.logo,
                      height: 157,
                      fit: BoxFit.fitHeight,
                    ),
                    vSizedBox2,
                    ParagraphText(
                      text: 'Welcome! to Call to fix',
                      fontFamily: 'medium',
                      fontSize: 20,
                    ),
                    ParagraphText(
                      text: 'Login to continue',
                      color: MyColors.textcolor,
                      fontSize: 15,
                    ),
                    vSizedBox2,
                    CustomTextField(
                        controller: emailController,
                        hintText: 'Email ID/ Username'),
                    vSizedBox2,
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    vSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            push(context: context, screen: ForgotPasswordPage());
                          },
                          child: ParagraphText(
                            text: 'Forgot Password?',
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    vSizedBox2,
                    RoundEdgedButton(
                      text: 'Login',
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      onTap: () async {

                        // Navigator.pushNamed(context, LoginPage.id); //Customer
                        // if(namecontroller.text=='123456'){
                        //   Navigator.pushNamed(context, Otp_Page.id); //Customer
                        // }else{
                        //   Navigator.pushNamed(context, Provider_Otp_Page.id); //Service Provider
                        // }
                        // Navigator.pushNamed(context, Otp_Page.id);
                        if (currentUserType == UserType.user) {
                           if (emailController.text == '') {
                                showSnackbar('Please Enter your email');
                          }

                       else if(passwordController.text.length<6){
                          showSnackbar(MyErrorConstants.passwordTooShort);
                          }else {
                             setState(() {
                               load = true;
                             });
                             var request = {
                               'email': emailController.text,
                               'password': passwordController.text,
                               'user_type': "1"
                             };
                             print("login data"+request.toString());
                             var jsonResponse = await Webservices.postData(
                                 apiUrl: ApiUrls.login,
                                 body: request,
                                 context: context);
                             setState(() {
                               load = false;
                             });
                             if (jsonResponse['status'].toString()=='1') {
                               print("login response"+jsonResponse.toString());
                               await updateSharedPreferences(jsonResponse['data']['id']);
                               if(jsonResponse['data']['email_verified'].toString()=='1'){
                                 await Navigator.of(context)
                                     .pushNamedAndRemoveUntil(TabsPage.id, (Route<dynamic> route) => false);
                               } else {
                                 pushReplacement(context: context, screen: PendingScreen(is_provider: false,));
                               }

                             }

                             else{
                               showSnackbar(jsonResponse['message']);
                             }


                           }
                        }
                        if (currentUserType == UserType.provider) {
                          if (emailController.text == '') {
                            showSnackbar('Please Enter your email');
                          }
                          // else if (!RegExp(
                          //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //     .hasMatch(emailController.text)) {
                          //   showSnackbar(MyErrorConstants.invalidEmailAddress);
                          // }
                          else if(passwordController.text.length<6){
                            showSnackbar(MyErrorConstants.passwordTooShort);
                          }else {
                            setState(() {
                              load = true;
                            });
                            var request = {
                              'email': emailController.text,
                              'password': passwordController.text,
                              'user_type': "2"

                            };
                            var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.login, body: request, context: context);
                            if(jsonResponse['status']==1){
                              await updateSharedPreferences(jsonResponse['data']['id']);
                              try{
                                if(sharedPreferences.getString('user_data')!=null){
                                  userData = jsonDecode(sharedPreferences.getString('user_data')!);
                                  if(userData!=null)
                                    await updateSharedPreferences(userData!['id']);

                                  if(userData!['driving_license']==''){
                                    print('Driving license is pending');
                                    pushReplacement(context: context, screen: About_Work_Page());
                                  }
                                  else if(userData!['approved_by_admin'].toString()=='1'&&jsonResponse['data']['email_verified'].toString()=='1'){
                                    print('all good');
                                    pushReplacement(context: context, screen: Tabs_Provider_Page());
                                  }else {
                                    print('Inside elseeee $userData');
                                    pushReplacement(context: context, screen: PendingScreen());
                                  }
                                }else{
                                  print('the shared preference is null');
                                  Navigator.pushReplacementNamed(context, WelcomePage.id);
                                }
                              }catch(e){
                                print('Error in catch block navigation 11');
                                Navigator.pushReplacementNamed(context, WelcomePage.id);
                              }
                            }else{
                              setState(() {
                                load = false;
                              });
                              showSnackbar(jsonResponse['message']);
                            }

                          }
                          // Navigator.pushNamed(context, Tabs_Provider_Page.id);
                        }
                      },
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ParagraphText(text: 'If you don\'t have an account'),
                        px4,
                        GestureDetector(
                          onTap: () async {
                            if (currentUserType == UserType.user) {
                              Navigator.pushNamed(context, LoginPage.id);
                            }
                            if (currentUserType == UserType.provider) {
                              Navigator.pushNamed(context, LoginPage.id);
                            }
                          },
                          child: ParagraphText(
                            text: 'Sign Up',
                            color: MyColors.primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
