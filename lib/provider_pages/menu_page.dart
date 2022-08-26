import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/aboutus.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/change_password_page.dart';
import 'package:calltofix/pages/manage_payment_method.dart';
import 'package:calltofix/pages/manageaddress.dart';
import 'package:calltofix/pages/my_wallet.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/privacy.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/terms.dart';
import 'package:calltofix/provider_pages/customer_review.dart';
import 'package:calltofix/provider_pages/my_wallet_provider.dart';
import 'package:calltofix/provider_pages/package_managment_page.dart';
import 'package:calltofix/provider_pages/provider_myprofilepage.dart';
import 'package:calltofix/provider_pages/service_managment_page.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/global_functions.dart';
import '../pages/welcome.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';
import '../widgets/buttons.dart';
import '../widgets/customLoader.dart';

class Menu_Page extends StatefulWidget {
  static const String id="Menu_Page";
  const Menu_Page({Key? key}) : super(key: key);

  @override
  State<Menu_Page> createState() => _Menu_PageState();
}

class _Menu_PageState extends State<Menu_Page> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want  to log Out your account ?'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(child: const Text('Log Out'),
              onPressed: () async {
                await logout();
                setState(() {

                });
                // Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
  TextEditingController house = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          context: context,
          title: 'Menu',
          appBarColor: MyColors.appbarcolor,
      ),
      body:SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Color(0xFFF1F4F8),
                Color(0xFFF1F4F8).withOpacity(0.5),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                            Flexible(
                                child: Column(
                                  children: [
                                    CustomCircularImage(
                                      imageUrl: userData!['image'],
                                      height: 50,
                                      width: 50,
                                    ),
                                  ],
                                )

                            ),
                          Flexible(
                            child: Column(
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              vSizedBox4,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    boxShadow
                  ]
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'My Profile', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Provider_MyProfilePage.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Service Managment', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Service_managment_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Package Managment', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Package_Managment_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'My Wallet', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, My_Wallet_Provider_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Manage Payment Options', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Manage_Payment_Method_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'My Ratings', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Customer_Review_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Rate Us', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height: MediaQuery.of(context).size.height / 1.9,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.ratings, height: 126,fit: BoxFit.fitHeight,),
                                    vSizedBox,
                                    headingText(text: 'Your Opinion matters  to us!', fontSize: 18, fontFamily: 'medium',),
                                    py4,
                                    ParagraphText(text: 'Give us a quick review and help us improve?',
                                      fontSize: 14, color: MyColors.textcolor,
                                    ),
                                    vSizedBox,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded, size: 45, color: MyColors.textcolor,
                                        ),
                                      ],
                                    ),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text: 'Rate Now', textColor: Colors.white,
                                      letterspace: 1,
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    vSizedBox,
                                    TextButton(
                                        onPressed: (){},
                                        child: ParagraphText(
                                          text: 'Not Now',
                                          color: MyColors.primaryColor,
                                          underlined: true,
                                          fontFamily: 'medium',
                                          fontSize: 15,
                                        )
                                    )
                                  ],
                                )
                            );
                          },
                        );
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Log Out', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: ()async{
                        _showMyDialog();
                     // await logout();
                      },

                    ),
                  ],
                ),
              ),
              vSizedBox4,
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      boxShadow
                    ]
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Change Password', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: ()async{
                        await push(context: context, screen: ChangePasswordPage());
                        setState(() {

                        });
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Terms & Conditions', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Terms_Page.id);
                      },
                    ),


                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Privacy Policy', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFC6C6C8),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Privacy_Page.id);
                      },
                    ),

                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ParagraphText(text: 'Help', fontSize: 13, fontFamily: 'regular',color: Color(0xFF273240),),
                              Icon(
                                Icons.chevron_right_outlined, color: MyColors.textcolor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: (){
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height: MediaQuery.of(context).size.height / 1.65,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    vSizedBox2,
                                    headingText(text: 'How can we help you?', fontSize: 16, fontFamily: 'medium',),
                                    vSizedBox2,
                                    CustomTextField(
                                      controller: house,
                                      hintText: 'Mobile Number',
                                      borderradius: 15,
                                    ),
                                    vSizedBox,
                                    CustomTextField(
                                      controller: house,
                                      hintText: 'Email Address',
                                      borderradius: 15,
                                    ),
                                    vSizedBox,
                                    CustomTextField(
                                      controller: house,
                                      hintText: 'Metion your issue',
                                      borderradius: 15,
                                      height: 170,
                                      maxLines: 8,
                                    ),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text: 'SEND', textColor: Colors.white,
                                      letterspace: 1,
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    vSizedBox,
                                  ],
                                )
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
