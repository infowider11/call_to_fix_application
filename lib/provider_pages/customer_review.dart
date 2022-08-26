import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/sized_box.dart';
import '../widgets/buttons.dart';
import '../widgets/lists.dart';

enum SingingCharacter { lafayette, jefferson}

class Customer_Review_Page extends StatefulWidget {
  static const String id="Customer_Review_Page";
  const Customer_Review_Page({Key? key}) : super(key: key);

  @override
  State<Customer_Review_Page> createState() => _Customer_Review_PageState();
}

class _Customer_Review_PageState extends State<Customer_Review_Page> {
  TextEditingController house = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    color: Color(0xFFF1F4F8),
                  ),
                  appBar(context: context, title: 'Customer Ratings', titleColor: Colors.black),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0,-40),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                // height: MediaQuery.of(context).size.height - 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingText(text: 'Air Conditioner', fontSize: 18,),
                            Container(
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
                                  ParagraphText(text: '4.7(828k)', color: Colors.white, fontSize: 10,)
                                ],
                              ),
                            ),

                          ],
                        ),
                        vSizedBox,
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 0.1,
                      color: MyColors.textcolor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(text: 'Included', fontSize: 16,),
                        vSizedBox,
                        ParagraphText(
                            text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        fontSize: 14, color: MyColors.textcolor,
                        ),
                        vSizedBox2,
                        headingText(text: 'Excluded', fontSize: 16,),
                        vSizedBox,
                        ParagraphText(
                          text: 'Lorem Ipsum is simply dummy texty.',
                          fontSize: 14, color: MyColors.textcolor,
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 0.1,
                      color: MyColors.textcolor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(text: 'Customer Reviews', fontSize: 18,),
                        vSizedBox,
                        for (var i=0; i<10; i++)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                boxShadow
                              ]
                          ),
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              StaffList(
                                text: 'jaina smith',
                                subtext: 'Apr 2022',
                                horizontalpadding: 0,
                                color: MyColors.primaryColor,
                                headingcolor: Colors.black,
                                fontSize: 12,
                                fontFamily: 'regular',
                                image: MyImages.user_icon_circle,
                                heightimg: 50,
                                widthimg: 50,
                                rating: true,
                                headingfontsize: 14,
                                boxshadow: false,
                              ),
                              ParagraphText(
                                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                fontSize: 12, color: MyColors.subtext,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
