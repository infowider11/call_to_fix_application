import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/pages/cart.dart';
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

class Product_Detail_Page extends StatefulWidget {
  static const String id="Product_Detail_Page";
  const Product_Detail_Page({Key? key}) : super(key: key);

  @override
  State<Product_Detail_Page> createState() => _Product_Detail_PageState();
}

class _Product_Detail_PageState extends State<Product_Detail_Page> {
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
                  Image.asset(
                    MyImages.cooler,
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  appBar(context: context, title: 'Detail', titleColor: Colors.white),
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
                        Row(
                          children: [
                            headingText(text: 'Air Conditioner', fontSize: 18,),
                            hSizedBox,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingText(text: '\$200'),
                            RoundEdgedButton(
                              text: 'BUY', textColor: Colors.white,
                              borderRadius: 5,
                              height: 20,
                              width: 50,
                              fontSize: 10,
                              fontfamily: 'semibold',
                              horizontalPadding: 10,
                              verticalPadding: 0,
                              onTap: () {
                                Navigator.pushNamed(context, Cart_Page.id);
                              },
                            ),

                          ],
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
                        headingText(text: 'Product Description', fontSize: 16,),
                        vSizedBox,
                        ParagraphText(
                            text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        fontSize: 14, color: MyColors.textcolor,
                        ),
                        vSizedBox2,
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
                        headingText(text: 'Related products', fontSize: 18,),
                        vSizedBox,
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: 2,
                            clipBehavior: Clip.none,
                            childAspectRatio: 1.1,

                            children: [
                              for (var i = 0; i < 4; i++)
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, Product_Detail_Page.id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow:[
                                          boxShadow
                                        ]
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.asset(
                                            MyImages.refridgerator,
                                            width: MediaQuery.of(context).size.width,
                                            // height: 108,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                          child: ParagraphText(
                                            text: 'Refridgerator',
                                            fontSize: 12,textAlign: TextAlign.center, fontFamily: 'medium',
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
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
