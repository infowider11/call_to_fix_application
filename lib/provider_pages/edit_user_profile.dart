import 'dart:io';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/loginpage.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/pages/signinpage.dart';
import 'package:calltofix/provider_pages/select_city.dart';
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
import '../constants/image_urls.dart';
import '../functions/image_picker.dart';
import '../functions/navigation_functions.dart';
import '../functions/showSnackbar.dart';
import '../provider_pages/provider_otppage.dart';
import '../widgets/custom_circular_image.dart';

class Edit_User_Profile_Page extends StatefulWidget {
  static const String id="Edit_User_Profile_Page";
  const Edit_User_Profile_Page({Key? key}) : super(key: key);

  @override
  State<Edit_User_Profile_Page> createState() => _Edit_User_Profile_PageState();
}

class _Edit_User_Profile_PageState extends State<Edit_User_Profile_Page> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController cpasswordController = TextEditingController();
  Map? city;
  bool load =false;
  File? image;
  @override
  void initState() {
    // TODO: implement initState
    autofill();
    super.initState();
  }
  autofill()async{
    print("userdataaaaaaaaa"+userData.toString());
    fnameController.text=userData!['full_name'];
    emailController.text=userData!['email'];
    phoneController.text=userData!['phone_with_code'];
    addressController.text=userData!['address'];
    userNameController.text=userData!['user_name'];
    city=userData!['city'];
    print("citycity"+city.toString());

    // city!['name']=userData!['city ']['name'];

  }

  @override

  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: appBar(context: context ,title: 'Edit Profile' ,fontsize: 18),
      body: SafeArea(
        child: Stack(

          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(MyImages.leaf_top),
                  //     fit: BoxFit.fitWidth,
                  //     alignment: Alignment.topLeft
                  // ),
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
                    // ParagraphText(text: 'Edit Profile', fontFamily: 'medium', fontSize: 20,),
                    // ParagraphText(text: 'Enter Your Details', color: MyColors.textcolor, fontSize: 15,),
                    // vSizedBox4,
                    // vSizedBox2,
                    GestureDetector(
                      onTap: ()async{
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Please Choose:',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    vSizedBox4,
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            File? tempImage = await pickImage(false);
                                            image=tempImage;
                                            if (tempImage != null) {
                                              Navigator.pop(context);
                                              // setState(() {
                                              //   load = true;
                                              // });
                                              // await Webservices.postDataWithImageFunction(body: {
                                              //   'user_id': userData!['id']
                                              // }, files: {
                                              //   'profile': tempImage
                                              // }, context: context, apiUrl: ApiUrls.profile_update);
                                              // await updateSharedPreferences(userData!['id']);
                                              //
                                              //
                                              // setState(() {
                                              //   load = false;
                                              // });
                                            }
                                          },
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 40,
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                        hSizedBox8,
                                        GestureDetector(
                                          onTap: () async {
                                            File? tempImage = await pickImage(true);

                                            setState(() {
                                              image=tempImage;
                                                      });
                                            // if (tempImage != null) {
                                            //   Navigator.pop(context);
                                            //   setState(() {
                                            //     load = true;
                                            //   });
                                            //
                                            //   await Webservices.postDataWithImageFunction(body: {
                                            //     'user_id': userData!['id']
                                            //   }, files: {
                                            //     'profile': tempImage
                                            //   }, context: context, apiUrl: ApiUrls.profile_update);
                                            //   await updateSharedPreferences(userData!['id']);
                                            //
                                            //
                                            //   setState(() {
                                            //     load = false;
                                            //   });
                                            // }
                                          },
                                          child: Icon(
                                            Icons.image,
                                            size: 40,
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Stack(
                        children: [
                          CustomCircularImage(
                            imageUrl: userData!['image'],
                            image: image,
                            height: 95,
                            fileType: image==null?CustomFileType.network:CustomFileType.file,
                            width: 95,

                          ),
                          Positioned(
                              right: 0,
                              bottom: 5,
                              child: Image.asset(MyImages.camera, width: 30,)
                          )
                        ],
                      ),
                    ),

                    vSizedBox4,
                    CustomTextField(controller: emailController, hintText: 'Email',enabled: false,textColor: Colors.grey,),
                    vSizedBox2,
                    CustomTextField(controller: phoneController, hintText: 'Phone',enabled: false,textColor: Colors.grey,),
                    vSizedBox2,
                    CustomTextField(controller: fnameController, hintText: 'Full Name'),
                    vSizedBox2,

                    CustomTextField(controller: userNameController, hintText: 'User Name'),
                    vSizedBox2,

                    CustomTextField(controller: addressController, hintText: 'Address'),
                    vSizedBox2,
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
                    // CustomTextField(controller: cpasswordController, hintText: 'Confirm Password', obscureText: true,),
                    // vSizedBox2,
                    RoundEdgedButton(
                      text: 'UPDATE',
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      onTap: ()async{
                        if(fnameController.text==''){
                          showSnackbar(MyErrorConstants.invalidName);
                        }else if(addressController.text==''){
                          showSnackbar(MyErrorConstants.Address);
                        }else{
                          Map <String, dynamic>data = {
                            "user_id":userData!['id'],
                            "full_name": fnameController.text,
                            'address':addressController.text,
                            "city": city!['id'],
                            "user_name":userNameController.text,

                          };
                          Map<String,dynamic>files = {
                            // 'cover_image':image,
                          };
                          if(image!=null){
                            files["image"]=image;

                          }
                          Map <String, dynamic>request = {
                            'email':emailController.text
                          };
                          setState(() {
                            load = true;
                          });
                          var res = await Webservices.postDataWithImageFunction(body: data, files: files, context: context, apiUrl: ApiUrls.editProfile);
                          print("email ress---"+res.toString());
                          if(res['status'].toString()=='1'){
                            print('hjhkj');
                            await updateSharedPreferences(userData!['id']);
                            Navigator.pop(context);
                            showSnackbar(res['message']);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => LoginPage(data:data)),
                            // );

                          }
                          else{
                            showSnackbar(res['message']);
                          }
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
                        // ParagraphText(text: 'Already have an account'),
                        px4,
                        // GestureDetector(
                        //   onTap: (){
                        //     Navigator.pushNamed(context, SignIn_Page.id);
                        //   },
                        //   child: ParagraphText(
                        //     text: 'Update', color: MyColors.primaryColor,),
                        // )


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
