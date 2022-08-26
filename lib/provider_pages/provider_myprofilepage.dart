import 'dart:developer';
import 'dart:io';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/provider_pages/edit_profile.dart';
import 'package:calltofix/provider_pages/provider_notification_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../functions/image_picker.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/avatar.dart';
import 'menu_page.dart';

class Provider_MyProfilePage extends StatefulWidget {
  static const String id="Provider_MyProfilePage";
  const Provider_MyProfilePage({Key? key}) : super(key: key);

  @override
  State<Provider_MyProfilePage> createState() => _Provider_MyProfilePageState();
}

class _Provider_MyProfilePageState extends State<Provider_MyProfilePage> {
  List<Map<String, dynamic>> imgList= [
    {
      "url":'assets/images/slider.png', },
    {
      "url":'assets/images/welcome_back.png',},
    {
      "url":'assets/images/slider.png', }
  ];
  int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  bool pressAttention5 = false;


  bool load= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        appBarColor: MyColors.appbarcolor,
        context: context,
        leading: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Menu_Page.id);
          },
          child: Icon(
            Icons.menu_outlined, color: Colors.black,
          ),
        ),
        implyLeading: false,
        title: 'My Profile',
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, Provider_Notification_page.id);
              },
              icon: Image.asset(MyImages.Notification, width: 17,)
          )
        ]

      ),
      body:
      // load?CustomLoader():
      Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    Color(0xFFF1F4F8),
                    Color(0xFFF1F4F8).withOpacity(0.5),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox,
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                          child: GestureDetector(
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
                                                  if (tempImage != null) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      load = true;
                                                    });
                                                    await Webservices.postDataWithImageFunction(body: {
                                                      'user_id': userData!['id']
                                                    }, files: {
                                                      'profile': tempImage
                                                    }, context: context, apiUrl: ApiUrls.profile_update);
                                                    await updateSharedPreferences(userData!['id']);


                                                    setState(() {
                                                      load = false;
                                                    });
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
                                                  if (tempImage != null) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      load = true;
                                                    });

                                                    await Webservices.postDataWithImageFunction(body: {
                                                      'user_id': userData!['id']
                                                    }, files: {
                                                      'profile': tempImage
                                                    }, context: context, apiUrl: ApiUrls.profile_update);
                                                    await updateSharedPreferences(userData!['id']);


                                                    setState(() {
                                                      load = false;
                                                    });
                                                  }
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
                                  height: 95,
                                  width: 95,
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 5,
                                    child: Image.asset(MyImages.camera, width: 30,)
                                )
                              ],
                            ),
                          )
                      ),
                      Flexible(
                        flex: 14,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ParagraphText(text: '${userData!['full_name']}',
                                      fontSize: 14,
                                      fontFamily: 'medium',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Image.asset(MyImages.Location, height: 15,),
                                        SizedBox(width: 5,),
                                        ParagraphText(text: '${userData!['city']['name']}',fontSize: 12,
                                          fontFamily: 'medium', color: MyColors.subtext,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star_rounded, color: Colors.white, size: 15,
                                          ),
                                          px2,
                                          ParagraphText(text:'${userData!['avg_rate']}(${userData!['avg_rate_count']})',color: Colors.white, fontSize: 10,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              RoundEdgedButton(
                                  text: 'Edit Profile',
                                  textColor: Colors.white,
                                  color: MyColors.primaryColor,
                                  height: 20,
                                  width: 60,
                                  fontSize: 10,
                                  borderRadius: 5,
                                  horizontalPadding: 0,
                                  verticalPadding: 0,
                                  fontfamily: 'regular',
                                letterspace: 0,
                                onTap: ()async{
                                    await Navigator.pushNamed(context, Edit_Profile_Page.id);
                                    setState(() {

                                    });
                                },
                              )
                            ],
                          )
                      )
                    ],
                  ),
                  vSizedBox2,
                  headingText(text: 'Personal Details', fontSize: 16, fontFamily: 'medium',),
                  vSizedBox,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ]
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vSizedBox2,
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        headingText(text: 'Mobile no.', fontSize: 15, fontFamily: 'semibold',),
                                        ParagraphText(text: '${userData!['phone_with_code']}',
                                          color: MyColors.textcolor,fontSize: 9,),
                                        vSizedBox,
                                      ]
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  // child: Image.asset(MyImages.edit, height: 15,)
                                child: vSizedBox,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10,
                          color: MyColors.textcolor.withOpacity(0.5),
                        ),
                        vSizedBox,
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        headingText(text: 'Email Id', fontSize: 15, fontFamily: 'semibold',),
                                        ParagraphText(text: '${userData!['email']}',
                                          color: MyColors.textcolor,fontSize: 9,),
                                        vSizedBox,
                                      ]
                                  )
                              ),
                              Expanded(
                                flex: 1,
                                // child: Image.asset(MyImages.edit, height: 15,)
                                child: vSizedBox,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10,
                          color: MyColors.textcolor.withOpacity(0.5),
                        ),
                        vSizedBox,
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        headingText(text: 'City', fontSize: 15, fontFamily: 'semibold',),
                                        ParagraphText(text: '${userData!['city']['name']}',
                                          color: MyColors.textcolor,fontSize: 9,),
                                        vSizedBox,
                                      ]
                                  )
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   // child: Image.asset(MyImages.edit, height: 15,)
                              //   child: vSizedBox,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // vSizedBox2,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     headingText(text: 'Work Information', fontSize: 16, fontFamily: 'medium',),
                  //     // RoundEdgedButton(text: 'Edit', textColor: Colors.white, height: 21,width: 31,
                  //     // horizontalPadding: 0,
                  //     //   verticalPadding: 0,
                  //     //   borderRadius: 5,
                  //     //   fontSize: 10,
                  //     //   letterspace: 0,
                  //     //   fontfamily: 'regular',
                  //     // )
                  //   ],
                  // ),
                  // vSizedBox,
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         boxShadow
                  //       ]
                  //   ),
                  //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       vSizedBox2,
                  //       // Container(
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     crossAxisAlignment: CrossAxisAlignment.center,
                  //       //     children: [
                  //       //       Column(
                  //       //           crossAxisAlignment: CrossAxisAlignment.start,
                  //       //           children:[
                  //       //             // headingText(text: 'Profession', fontSize: 15, fontFamily: 'semibold',),
                  //       //             // ParagraphText(text: '${userData!['work_category']['title']}',
                  //       //             //   color: MyColors.textcolor,fontSize: 14,),
                  //       //           ]
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //       // Divider(
                  //       //   height: 10,
                  //       //   color: MyColors.textcolor,
                  //       // ),
                  //       // vSizedBox,
                  //       // Container(
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     crossAxisAlignment: CrossAxisAlignment.center,
                  //       //     children: [
                  //       //       Column(
                  //       //           crossAxisAlignment: CrossAxisAlignment.start,
                  //       //           children:[
                  //       //             // headingText(text: 'Source of income', fontSize: 15, fontFamily: 'semibold',),
                  //       //             // ParagraphText(text: '${userData!['source_of_income']['title']}',
                  //       //             //   color: MyColors.textcolor,fontSize: 14,),
                  //       //             vSizedBox,
                  //       //           ]
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  vSizedBox2,
                  headingText(text: 'Identity document', fontSize: 16, fontFamily: 'medium',),
                  vSizedBox,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          boxShadow
                        ]
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(text: 'ID Proof', fontSize: 15, fontFamily: 'medium',color: Color(0xFF273240),),
                        vSizedBox,
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Image.network(
                              userData!['id_proof'],
                              width: MediaQuery.of(context).size.width-100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          boxShadow
                        ]
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(text: 'Driving license', fontSize: 15, fontFamily: 'medium',color: Color(0xFF273240),),
                        vSizedBox,
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(
                            userData!['driving_license'],
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox,
                  if(userData!['profession_certificate']!='')
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          boxShadow
                        ]
                    ),
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(text: 'Training Certificate', fontSize: 15, fontFamily: 'medium',color: Color(0xFF273240),),
                        vSizedBox,
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:userData!['profession_certificate']==''?Center(child: ParagraphText(text: 'No Training Certificate Uploaded',),): Image.network(
                            userData!['profession_certificate'],
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox4
                ],
              ),
            ),
          ),
          if(load)
            CustomFullPageLoader()
        ],
      ),
    );
  }
}
