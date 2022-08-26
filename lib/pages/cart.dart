import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/paymentmethod.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';
import '../constants/image_urls.dart';
import '../widgets/avatar.dart';
import '../widgets/lists.dart';


class Cart_Page extends StatefulWidget {
  static const String id="Cart_Page";
  const Cart_Page({Key? key}) : super(key: key);

  @override
  State<Cart_Page> createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  TextEditingController house = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 9;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: appBar(context: context, title: 'Cart', appBarColor: MyColors.appbarcolor,
      actions: [
        TextButton(
            onPressed: (){},
            child: ParagraphText(text: 'Clear', color: Colors.red,
            fontSize: 14,
            )
        )
      ]

      ),
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: pad_horizontal,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    Color(0xFFF1F4F8),
                    Color(0xFFffffff).withOpacity(1),
                  ],
                ),
                // color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      StaffList(
                        text: 'Video Cunsult',
                        subtext: '\$100',
                        horizontalpadding: 0,
                        color: MyColors.primaryColor,
                        headingcolor: Colors.black,
                        fontSize: 12,
                        fontFamily: 'regular',
                        image: MyImages.plumb,
                        heightimg: 50,
                        widthimg: 50,
                        counting: true,
                        headingfontsize: 14,
                      ),
                      StaffList(
                        text: 'Ac Service (Split)',
                        subtext: '\$100',
                        horizontalpadding: 0,
                        color: MyColors.primaryColor,
                        headingcolor: Colors.black,
                        fontSize: 12,
                        fontFamily: 'regular',
                        image: MyImages.plumb,
                        heightimg: 50,
                        widthimg: 50,
                        counting: true,
                        headingfontsize: 14,
                      ),
                    ],
                  ),
                  vSizedBox,
                  headingText(text: 'Payment Summary'),
                  vSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(text: 'Payment Summary', fontSize: 12,),
                      ParagraphText(text: '\$100', fontSize: 12,),
                    ],
                  ),
                  py4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(text: 'Discount', fontSize: 12,),
                      ParagraphText(text: '\$10', fontSize: 12,),
                    ],
                  ),
                  Divider(
                    height: 20,
                    color: MyColors.subtext,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(text: 'Total', fontSize: 12,color: Colors.black, fontFamily: 'bold',),
                      ParagraphText(text: '\$10', fontSize: 12,fontFamily: 'bold',),
                    ],
                  ),
                  vSizedBox2,
                  headingText(text: 'Apply Coupon '),
                  vSizedBox2,
                  CustomTextField(
                      controller: house,
                      hintText: 'eg. XDF123456'),
                  vSizedBox,
                  Container(
                    height: 65,
                    child: ListView(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.primaryColor,
                                width: 0.5
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            // boxShadow: [boxShadow]

                          ),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatarcustom(
                                imageUrl: MyImages.video_circle_icon,
                                width: 20,
                                height: 20,
                              ),
                              hSizedBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingText(text: 'Save Flat \$100 on every request',color: Color(0xFF273240),fontSize: 9),
                                  ParagraphText(text: 'Get Plus now', color: MyColors.textcolor, fontSize: 9,)
                                ],
                              )
                            ],
                          ),
                        ),
                        hSizedBox,
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.primaryColor,
                                width: 0.5
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            // boxShadow: [boxShadow]

                          ),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatarcustom(
                                imageUrl: MyImages.video_circle_icon,
                                width: 20,
                                height: 20,
                              ),
                              hSizedBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingText(text: 'Save Flat \$100 on every request',color: Color(0xFF273240),fontSize: 9),
                                  ParagraphText(text: 'Get Plus now', color: MyColors.textcolor, fontSize: 9,)
                                ],
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: RoundEdgedButton(
                text: 'ADD ADDRESS AND SLOT',
                textColor: Colors.white,
                letterspace: 0.8,
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
                              headingText(text: 'Address', fontSize: 16, fontFamily: 'medium',),
                              vSizedBox2,
                              CustomTextField(
                                controller: house,
                                hintText: 'House/flat number',
                                borderradius: 15,
                              ),
                              vSizedBox,
                              CustomTextField(
                                controller: house,
                                hintText: 'Landmark (Optional)',
                                borderradius: 15,
                              ),
                              vSizedBox2,
                              headingText(text: 'Save as', fontSize: 16, fontFamily: 'regular', color: MyColors.textcolor,),
                              vSizedBox,
                              Row(
                                children: [
                                  Expanded(
                                    child: RoundEdgedButton(
                                      text: 'Home',
                                      textColor: Colors.white,
                                      letterspace: 1,
                                      fontSize: 13,
                                      borderRadius: 12,
                                      height: 45,
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  hSizedBox,
                                  Expanded(
                                    child: RoundEdgedButton(
                                      text: 'Other',
                                      textColor: Colors.white,
                                      isSolid: false,
                                      letterspace: 1,
                                      color: Colors.white,
                                      fontSize: 13,
                                      borderRadius: 12,
                                      height: 45,
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              vSizedBox2,
                              CustomTextField(
                                controller: house,
                                hintText: 'Eg. father’s Place, etc.',
                                borderradius: 15,
                              ),
                              vSizedBox2,
                              RoundEdgedButton(
                                text: 'SELECT SLOT', textColor: Colors.white,
                                letterspace: 1,
                                onTap: (){
                                  Navigator.of(context).pop();
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: MediaQuery.of(context).size.height / 1.4,
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
                                              headingText(text: 'Select date', fontSize: 16, fontFamily: 'medium',),
                                              ParagraphText(text: 'Service will take approx. 2hr 10 mins', color: MyColors.textcolor,fontSize: 13,),
                                              vSizedBox2,
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow: [boxShadow]
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: Image.asset(MyImages.calendar),
                                                ),
                                              ),
                                              vSizedBox2,
                                              headingText(text: 'Select  time', fontSize: 16, fontFamily: 'medium',),
                                              vSizedBox,
                                              GridView.count(
                                                clipBehavior: Clip.none,
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 8,
                                                  crossAxisSpacing: 5,
                                                  shrinkWrap: true,
                                                childAspectRatio: (itemWidth / itemHeight),
                                                  children: [
                                                    RoundEdgedButton(
                                                      text: '07:00 AM',
                                                      textColor: Colors.white,
                                                      isSolid: false,
                                                      letterspace: 1,
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      borderRadius: 10,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    RoundEdgedButton(
                                                      text: '08:00 AM',
                                                      textColor: MyColors.textcolor,
                                                      color: Colors.white,
                                                      letterspace: 1,
                                                      fontSize: 13,
                                                      borderRadius: 12,
                                                      horizontalPadding: 0,
                                                      verticalPadding: 0,
                                                      fontfamily: 'regular',
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),

                                                  ],
                                              ),
                                              vSizedBox8,
                                              RoundEdgedButton(
                                                text: 'Proceed to checkout', textColor: Colors.white,
                                                letterspace: 1,
                                                onTap: (){
                                                  Navigator.of(context).pop();
                                                  showModalBottomSheet<void>(
                                                    isScrollControlled: true,
                                                    backgroundColor: Colors.transparent,
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                          height: MediaQuery.of(context).size.height / 2.8,
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
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                        child: Image.asset(MyImages.Location, height: 24,)
                                                                    ),
                                                                    Expanded(
                                                                        flex: 10,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:[
                                                                            headingText(text: 'Address', fontSize: 16, fontFamily: 'semibold',),
                                                                            ParagraphText(text: 'Hdjdj - 14, lorem ipsum - CANADA',
                                                                              color: MyColors.textcolor,fontSize: 14,),
                                                                          ]
                                                                          )
                                                                    ),
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child: Image.asset(MyImages.edit, height: 15,)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 35,
                                                                color: MyColors.textcolor,
                                                                indent: 55,
                                                              ),
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                        child: Image.asset(MyImages.Timecircle, height: 16,)
                                                                    ),
                                                                    Expanded(
                                                                        flex: 10,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:[
                                                                            headingText(text: 'Time', fontSize: 16, fontFamily: 'semibold',),
                                                                            ParagraphText(text: 'Sat, Apr 23 - 11:30 AM',
                                                                              color: MyColors.textcolor,fontSize: 14,),
                                                                            vSizedBox,
                                                                          ]
                                                                          )
                                                                    ),
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child: Image.asset(MyImages.edit, height: 15,)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              vSizedBox2,
                                                              RoundEdgedButton(
                                                                text: 'Pay \$100', textColor: Colors.white,
                                                                letterspace: 1,
                                                                onTap: (){
                                                                  Navigator.of(context).pop();
                                                                  Navigator.pushNamed(context, PaymentMethod_Page.id);
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
                                              vSizedBox,
                                            ],
                                          )
                                      );
                                    },
                                  );
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
            ),
          ),
        ],
      ),

    );
  }
}
