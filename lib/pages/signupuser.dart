import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/loginpage.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/pages/pending_screen_provider.dart';
import 'package:calltofix/pages/signinpage.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';
import '../constants/error_constants.dart';
import '../constants/global_functions.dart';
import '../constants/global_keys.dart';
import '../constants/image_urls.dart';
import '../functions/navigation_functions.dart';
import '../functions/showSnackbar.dart';
import '../provider_pages/provider_otppage.dart';
import '../provider_pages/select_city.dart';

class SignUp_Page extends StatefulWidget {
  static const String id="SignUp_Page";
  final Map<String ,dynamic>? data;

  SignUp_Page({Key? key,required this.data}) : super(key: key);
  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Map? city;
  bool load= false;

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox2,
                    ParagraphText(text: 'Welcome! to Call to fix', fontFamily: 'medium', fontSize: 20,),
                    ParagraphText(text: 'Enter Your Details', color: MyColors.textcolor, fontSize: 15,),
                    vSizedBox2,
                    CustomTextField(controller: fnameController, hintText: 'Full Name'),
                    vSizedBox2,
                    CustomTextField(controller: emailController, hintText: 'Email'),
                    vSizedBox2,
                    CustomTextField(controller: userNameController, hintText: 'User Name'),
                    vSizedBox2,
                    CustomTextField(controller: addressController, hintText: 'Address'),
                    vSizedBox2,
                    // vSizedBox2,
                    // headingText(text: 'Select your city', fontSize: 16, fontFamily: 'medium',),
                    // vSizedBox,
                    GestureDetector(
                      onTap: ()async{
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Navigator.pushNamed(context, Select_City_Page.id);
                        Map? tempcity = await push(context: context, screen: Select_City_Page(selectedCity: city));
                        print('the selected city is $tempcity');
                        if(tempcity!=null){
                          city = tempcity;
                          setState(() {

                          });
                        }

                      },
                      child: Container(
                          height: 50,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                boxShadow
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child:
                                city!=null? ParagraphText(text: city!['name']):
                                ParagraphText(text: 'Select City',fontSize: 13, color: MyColors.textcolor,),
                              ),
                              Flexible(
                                  child: Image.asset(MyImages.arrow_down, height: 20,)
                              ),
                            ],
                          )
                      ),
                    ),
                    vSizedBox2,
                    CustomTextField(controller: passwordController, hintText: 'Password', obscureText: true,),
                    vSizedBox2,
                    CustomTextField(controller: cpasswordController, hintText: 'Confirm Password', obscureText: true,),
                    vSizedBox2,
                    RoundEdgedButton(
                      text: 'SIGN UP',
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      onTap: ()async{
                        if(fnameController.text==''){
                          showSnackbar(MyErrorConstants.invalidName);
                        }else if (emailController.text == '') {
                        showSnackbar( 'Please Enter your email');
                        } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
                          showSnackbar(MyErrorConstants.invalidEmailAddress);
                        }else if (userNameController.text == '') {
                          showSnackbar( 'Please Enter your user name');
                        } else if(addressController.text==''){
                          showSnackbar(MyErrorConstants.Address);
                        }
                        else if (city==null) {
                          showSnackbar( 'Please Select city.');
                        } else if(passwordController.text.length<6){
                          showSnackbar('password should be more than 6 chacter');
                        }else if(cpasswordController.text==''){
                          showSnackbar('Please enter confirm password .');
                        }else if(passwordController.text!=cpasswordController.text){
                          showSnackbar('Confirm passwword should be same as password');
                        }else{
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            load = true;
                          });

                          Map <String, dynamic>dataa = {
                            "full_name": fnameController.text,
                            "email": emailController.text,
                            'address':addressController.text,
                            "password": passwordController.text,
                            "user_name":userNameController.text,
                            "user_type": '1',
                            " phone_code":widget.data!['phone_code'],
                            "phone":widget.data!['phone_number'],
                            "city": city!['id'],

                          };
                          Map <String, dynamic>request = {
                            'email':emailController.text
                          };
                          var res = await Webservices.getMap(ApiUrls.verifyEmail,request: request);
                          print("email ress---"+res.toString());
                          if(res['status'].toString()=='1'){
                            print('prasoon-----');
                            var res=await Webservices.postData(apiUrl: ApiUrls.signupUser, body: dataa, context: context);
                            log(res.toString());
                            if(res['status'].toString()=='1'){
                              print('enter----prasoon----');
                              await updateSharedPreferences(res['data']['id']);
                              // userData=res['data'];
                              Navigator.popUntil(context, (route) => route.isFirst);
                              await pushReplacement(context: MyGlobalKeys.navigatorKey.currentContext!, screen: PendingScreen(is_provider: false,));
                              // await Navigator.of(context)
                              //     .pushNamedAndRemoveUntil(PendingScreen(), (Route<dynamic> route) => false);
                              // await Navigator.of(context)
                              //     .pushNamedAndRemoveUntil(TabsPage.id, (Route<dynamic> route) => false);
                            }

                          }
                          else{
                            showSnackbar('Email Already exist');
                          }
                        }
                        try{
                          setState(() {
                            load = false;
                          });
                        }catch(e){
                          print('Error in catch block Expected 433 $e');
                        }

                        // Navigator.pushNamed(context, LoginPage.id); //Customer
                        // if(namecontroller.text=='123456'){
                        //   Navigator.pushNamed(context, Otp_Page.id); //Customer
                        // }else{
                        //   Navigator.pushNamed(context, Provider_Otp_Page.id); //Service Provider
                        // }
                        // Navigator.pushNamed(context, Otp_Page.id);
                      },
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ParagraphText(text: 'Already have an account'),
                        px4,
                        GestureDetector(
                          onTap: (){
                              Navigator.pushNamed(context, SignIn_Page.id);
                          },
                          child: ParagraphText(
                            text: 'Sign In', color: MyColors.primaryColor,),
                        )


                      ],
                    )
                    // vSizedBox2,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ParagraphText(text: 'If you don\'t have an account'),
                    //     px4,
                    //     GestureDetector(
                    //       onTap: (){
                    //           // if(currentUserType==UserType.user){
                    //           //   Navigator.pushNamed(context, TabsPage.id);
                    //           // }else{
                    //           //   Navigator.pushNamed(context, Personal_Information_Page.id);
                    //           // }
                    //
                    //       },
                    //         child: ParagraphText(
                    //           text: 'Sign Up', color: MyColors.primaryColor,),
                    //     )
                    //
                    //
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            if(load)
              CustomFullPageLoader(),
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
