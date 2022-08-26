import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'notification_page.dart';

class My_Wallet_Page extends StatefulWidget {
  static const String id="My_Wallet_Page";
  const My_Wallet_Page({Key? key}) : super(key: key);

  @override
  State<My_Wallet_Page> createState() => _My_Wallet_PageState();
}

class _My_Wallet_PageState extends State<My_Wallet_Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Color(0xFFF1F4F8),
                  Color(0xFFF1F4F8).withOpacity(0.50),
                ],
              ),
              // color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 210,
                      decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(120),
                        )
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vSizedBox8,
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            ParagraphText(text: 'Total Balance',
                                              fontSize: 18,
                                              fontFamily: 'medium',
                                             color: Colors.white,
                                            ),
                                            ParagraphText(text: '\$ 2000',
                                              fontSize: 40,
                                              fontFamily: 'semibold',
                                             color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                                child: Image.asset(MyImages.wallet_white, height: 46,)
                                            ),
                                            hSizedBox4
                                          ],
                                        ),

                                      ],
                                    ),
                                    vSizedBox,
                                    Row(
                                      children: [
                                        RoundEdgedButton(
                                            text: 'Withdraw  Request',
                                            textColor: MyColors.primaryColor,
                                            height: 20,
                                          fontSize: 10,
                                          horizontalPadding: 0,
                                          verticalPadding: 0,
                                          horizontalMargin: 0,
                                          color: Colors.white,
                                          width: 104,
                                          letterspace: 0,
                                          borderRadius: 5,
                                          fontfamily: 'regular',
                                        ),hSizedBox,
                                        RoundEdgedButton(
                                            text: 'Deposit',
                                            textColor: MyColors.primaryColor,
                                            height: 20,
                                          fontSize: 10,
                                          horizontalPadding: 0,
                                          verticalPadding: 0,
                                          horizontalMargin: 0,
                                          color: Colors.white,
                                          width: 50,
                                          letterspace: 0,
                                          borderRadius: 5,
                                          fontfamily: 'regular',
                                        ),hSizedBox,
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                     
                    ),
                    appBar(
                        implyLeading: false,
                        context: context,
                        title: 'My bookings',
                        appBarColor: Colors.transparent,
                        titleColor: Colors.white,
                        actions: [
                          IconButton(
                              visualDensity: VisualDensity(horizontal: 0),
                              onPressed: (){
                                Navigator.pushNamed(context, Notification_page.id);
                              },
                              padding: EdgeInsets.all(0),
                              icon: Image.asset(MyImages.Notification, width: 17,)
                          )
                        ]
                    ),
                  ],
                ),
                vSizedBox4,
                Container(
                  padding: pad_horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText(text: 'Transaction history', fontSize: 18, fontFamily: 'medium',),
                      vSizedBox,
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Provider_list_page.id);
                        },
                        child: Booking_List(
                          text: 'Ac Service',
                          subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                          horizontalpadding: 0,
                          color: Color(0xFF2C3A4B).withOpacity(0.50),
                          fontSize: 9,
                          fontFamily: 'regular',
                          image: MyImages.plumb,
                          heightimg: 55,
                          widthimg: 55,
                          btntext: 'Completed',
                          btntextcolor: Color(0xFF34A853),
                          btnradius: 5,
                          btncolor: Color(0xFF34A853).withOpacity(0.34),
                          btnfontsize: 10,
                          ammount: true,
                          amountcolor: Colors.red,
                          viewbtn: false,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Provider_list_page.id);
                        },
                        child: Booking_List(
                          text: 'Ac Service',
                          subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                          horizontalpadding: 0,
                          color: Color(0xFF2C3A4B).withOpacity(0.50),
                          fontSize: 9,
                          fontFamily: 'regular',
                          image: MyImages.plumb,
                          heightimg: 55,
                          widthimg: 55,
                          btntext: 'Pending',
                          btntextcolor: MyColors.primaryColor,
                          btnradius: 5,
                          btncolor: MyColors.primaryColor.withOpacity(0.34),
                          btnfontsize: 10,
                          ammount: true,
                          amountcolor: Color(0xFF34A853),
                          viewbtn: false,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Provider_list_page.id);
                        },
                        child: Booking_List(
                          text: 'Ac Service',
                          subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                          horizontalpadding: 0,
                          color: Color(0xFF2C3A4B).withOpacity(0.50),
                          fontSize: 9,
                          fontFamily: 'regular',
                          image: MyImages.plumb,
                          heightimg: 55,
                          widthimg: 55,
                          btntext: 'Payment Failed',
                          btntextcolor: Colors.red,
                          btnradius: 5,
                          btncolor: Colors.red.withOpacity(0.34),
                          btnfontsize: 10,
                          ammount: true,
                          amountcolor: Colors.red,
                          viewbtn: false,

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
