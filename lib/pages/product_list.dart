import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/cart.dart';
import 'package:calltofix/pages/service_provider_detail_page.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/image_urls.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';

class Product_list_page extends StatefulWidget {
  static const String id="Product_List_Page";
  const Product_list_page({Key? key}) : super(key: key);

  @override
  State<Product_list_page> createState() => _Product_list_pageState();
}

class _Product_list_pageState extends State<Product_list_page> {
  bool viewVisible = false;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Air Conditioner',
          actions: [
            IconButton(onPressed: (){},
                icon: Image.asset(MyImages.Notification, width: 17,)
            )
          ]
      ),
      body: Container(
        padding: pad_horizontal,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox2,
                  vSizedBox8,
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
                      )

                    ],
                  ),
                  py4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(MyImages.checkmark, width: 15,),
                      px3,
                      ParagraphText(text: '200 Bookings this year in Navlakha', color: MyColors.textcolor, fontSize: 11,)
                    ],
                  ),
                  vSizedBox,
                  Container(
                    height: 70,
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
                  GridView.count(
                    padding: EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.78,
                    children: [
                      for (var i = 0; i < 10; i++)
                       GestureDetector(
                         onTap: (){
                           Navigator.pushNamed(context, Service_Provider_Detail_Page.id);
                         },
                         child: Container(
                           padding: EdgeInsets.all(12),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                 Center(
                                   child: CircleAvatarcustom(
                                     imageUrl: MyImages.plumb,
                                     imgwidth: 50,
                                     imgheight: 50,
                                   ),
                                 ),
                               vSizedBox,
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   headingText(text: 'Ac Service', color: Color(0xFF273240),fontSize: 15,),
                                   RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                       text: '',
                                       style: TextStyle(
                                           color: MyColors.textcolor,
                                           fontSize: 14,
                                           height: 1.5
                                       ),
                                       children: const <TextSpan>[
                                         TextSpan(text: 'Next at \$200', style: TextStyle(
                                             fontFamily: 'semibold',
                                             color: MyColors.primaryColor,
                                             fontSize: 10
                                         ),
                                         ),
                                         TextSpan(
                                             text: ' . ', style: TextStyle(
                                             color: Colors.black
                                         )
                                         ),
                                         TextSpan(text: '45 mins', style: TextStyle(
                                             color: Colors.black, fontSize: 10
                                         )),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                               vSizedBox,
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CircleAvatarcustom(
                                     imageUrl: MyImages.tag,
                                     width: 15,
                                     height: 15,
                                   ),
                                   hSizedBox,
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       ParagraphText(text: '30% off second service\nonwords..', color: MyColors.textcolor, fontSize: 9,)
                                     ],
                                   )
                                 ],
                               ),
                               Divider(
                                 height: 20,
                                 thickness: 0.1,
                                 color: MyColors.textcolor,
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   if(viewVisible == true)
                                   Container(
                                     width: 50,
                                     height: 20,
                                     padding: EdgeInsets.symmetric(horizontal: 5),
                                     decoration: BoxDecoration(
                                       color: Color(0xFF9AA6B8),
                                       borderRadius: BorderRadius.circular(5)
                                     ),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         GestureDetector(
                                           onTap: (){
                                             setState(() {
                                               viewVisible = false;
                                             });
                                           },
                                           child: ParagraphText(
                                             text: '-',
                                             color: Colors.black,
                                             fontSize: 10,
                                             fontFamily: 'semibold',
                                           ),
                                         ),
                                         ParagraphText(
                                           text: '$_counter',
                                           color: Colors.black,
                                           fontSize: 10,
                                           fontFamily: 'semibold',
                                         ),
                                         GestureDetector(
                                           onTap: _incrementCounter,
                                           child: ParagraphText(
                                             text: '+',
                                             color: Colors.black,
                                             fontSize: 10,
                                             fontFamily: 'semibold',
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   if(viewVisible == false)
                                   RoundEdgedButton(
                                     text: 'ADD', textColor: Colors.white,
                                     borderRadius: 5,
                                     height: 20,
                                     width: 50,
                                     fontSize: 10,
                                     fontfamily: 'semibold',
                                     horizontalPadding: 10,
                                     verticalPadding: 0,
                                     onTap: (){
                                       setState(() {
                                         viewVisible = true;
                                       });
                                     },
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Icon(
                                         Icons.star_rounded, color: MyColors.primaryColor, size: 15,
                                       ),
                                       px2,
                                       ParagraphText(text: '4.7(828k)', color: MyColors.textcolor, fontSize: 10,)
                                     ],
                                   ),
                                 ],
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
            Align(
              alignment:  Alignment.bottomCenter,
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: viewVisible,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: MyColors.primaryColor,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(text: '\$200.00', color: Colors.black, fontSize: 14, fontFamily: 'semibold',),
                      RoundEdgedButton(
                        text: 'VIEW CART', textColor: Colors.white,
                        borderRadius: 5,
                        height: 25,
                        fontSize: 10,
                        fontfamily: 'semibold',
                        horizontalPadding: 10,
                        verticalPadding: 0,
                        letterspace: 1,
                        width: 100,
                        onTap: (){
                          Navigator.pushNamed(context, Cart_Page.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),


      ),
    );
  }
}
