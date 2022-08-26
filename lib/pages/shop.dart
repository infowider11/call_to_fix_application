import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/product_category.dart';
import 'package:calltofix/pages/search_result.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';
class Shop_Page extends StatefulWidget {
  static const String id="Shop_Page";
  const Shop_Page({Key? key}) : super(key: key);

  @override
  State<Shop_Page> createState() => _Shop_PageState();
}

class _Shop_PageState extends State<Shop_Page> {
  TextEditingController search = TextEditingController();
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  bool pressAttention5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Shop', appBarColor: MyColors.appbarcolor,
          actions: [
            IconButton(onPressed: (){},
                icon: Image.asset(MyImages.Notification, width: 17,)
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      // Map data ={
                      //   'keyword':search.text
                      // };
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  searchResultPage()),
                      );
                      // Navigator.push(context, searchResultPage(data: data))
                    },

                    child: CustomTextField(controller: search, hintText: 'Search',
                      prefixIcon: MyImages.search,
                      enabled: false,
                      left: 0,
                    ),
                  ),
                  vSizedBox,
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention = !pressAttention;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context, Product_Category_Page.id);
                          setState(() {
                            pressAttention = !pressAttention;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon1, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Home \nRenovations',
                                fontSize: 9,textAlign: TextAlign.center,
                                color: pressAttention? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention1 = !pressAttention1;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context, Product_Category_Page.id);
                          setState(() {
                            pressAttention1 = !pressAttention1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention1? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention1? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Appliance\nServices',
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: pressAttention1? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention2 = !pressAttention2;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context, Product_Category_Page.id);
                          setState(() {
                            pressAttention2 = !pressAttention2;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention2? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention2? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon3, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Digital\nMarketing',
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: pressAttention2? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention3 = !pressAttention3;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context, Product_Category_Page.id);
                          setState(() {
                            pressAttention3 = !pressAttention3;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention3? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention3? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon4, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Maid\nServices',
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: pressAttention3? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention4 = !pressAttention4;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context,Product_Category_Page.id);
                          setState(() {
                            pressAttention4 = !pressAttention4;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention4? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention4? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon5, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Towing\nservices',
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: pressAttention4? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            pressAttention5 = !pressAttention5;
                          });
                          await Future.delayed(Duration(milliseconds: 300));
                          await Navigator.pushNamed(context,Product_Category_Page.id);
                          setState(() {
                            pressAttention5 = !pressAttention5;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:pressAttention5? MyColors.primaryColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow:[
                                boxShadow
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: pressAttention5? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(
                                text: 'Snow\nremoval',
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: pressAttention5? Colors.white: Colors.black.withOpacity(0.70),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  vSizedBox4,
                  headingText(text: 'Additions, Construction & Renovations', fontSize: 15, fontFamily: 'medium',),
                  vSizedBox,
                ],
              ),
              ),
              Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < 3; i++)
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatarcustom(
                                imageUrl: MyImages.category,
                                height: 100,
                                width: 144,
                                borderradius: 10,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          ParagraphText(text: 'Basement Renovation',
                            fontSize: 12,
                            textAlign: TextAlign.center,
                            color: MyColors.subtext,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox4,
                    headingText(text: 'Additions, Construction & Renovations', fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention = !pressAttention;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context,Product_Category_Page.id);
                            setState(() {
                              pressAttention = !pressAttention;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon1, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Home \nRenovations',
                                  fontSize: 9,textAlign: TextAlign.center,
                                  color: pressAttention? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention1 = !pressAttention1;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context,Product_Category_Page.id);
                            setState(() {
                              pressAttention1 = !pressAttention1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention1? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention1? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Appliance\nServices',
                                  fontSize: 9,
                                  textAlign: TextAlign.center,
                                  color: pressAttention1? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention2 = !pressAttention2;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context,Product_Category_Page.id);
                            setState(() {
                              pressAttention2 = !pressAttention2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention2? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention2? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon3, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Digital\nMarketing',
                                  fontSize: 9,
                                  textAlign: TextAlign.center,
                                  color: pressAttention2? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention3 = !pressAttention3;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context,Product_Category_Page.id);
                            setState(() {
                              pressAttention3 = !pressAttention3;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention3? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention3? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon4, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Maid\nServices',
                                  fontSize: 9,
                                  textAlign: TextAlign.center,
                                  color: pressAttention3? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention4 = !pressAttention4;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context, Product_Category_Page.id);
                            setState(() {
                              pressAttention4 = !pressAttention4;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention4? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention4? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon5, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Towing\nservices',
                                  fontSize: 9,
                                  textAlign: TextAlign.center,
                                  color: pressAttention4? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            setState(() {
                              pressAttention5 = !pressAttention5;
                            });
                            await Future.delayed(Duration(milliseconds: 300));
                            await Navigator.pushNamed(context, Product_Category_Page.id);
                            setState(() {
                              pressAttention5 = !pressAttention5;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color:pressAttention5? MyColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  boxShadow
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: pressAttention5? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                ParagraphText(
                                  text: 'Snow\nremoval',
                                  fontSize: 9,
                                  textAlign: TextAlign.center,
                                  color: pressAttention5? Colors.white: Colors.black.withOpacity(0.70),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
