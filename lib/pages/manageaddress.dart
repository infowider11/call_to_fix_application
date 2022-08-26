import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/checkbox.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';

class Manage_address_page extends StatefulWidget {
  static const String id="Manage_address_page";
  const Manage_address_page({Key? key}) : super(key: key);

  @override
  State<Manage_address_page> createState() => _Manage_address_pageState();
}

class _Manage_address_pageState extends State<Manage_address_page> {
  TextEditingController house = TextEditingController();
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
        appBar: appBar(
          context: context, title: 'Manage Addresses', appBarColor: MyColors.appbarcolor,
        actions: [
          IconButton(
              visualDensity: VisualDensity(horizontal: 0),
              onPressed: (){},
              padding: EdgeInsets.all(0),
              icon: Image.asset(MyImages.Notification, width: 17,)
          )
        ]
        ),
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
            padding: pad_horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        boxShadow
                      ]
                  ),
                  padding: EdgeInsets.only(right: 16, bottom: 16),
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
                                      headingText(text: 'Canada', fontSize: 14, fontFamily: 'semibold',),
                                      ParagraphText(text: '14, lorem ipsum - CANADA',
                                        color: MyColors.textcolor,fontSize: 14,),
                                    ]
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: PopupMenuButton(
                                  icon: Icon(Icons.more_vert, color: Colors.black,),
                                  elevation: 0,
                                  offset: Offset(-30, 0),
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                    PopupMenuItem(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text('Edit'),
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
                                                        text: 'ADD ADDRESS', textColor: Colors.white,
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
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text('Delete'),
                                      ),
                                    ),
                                  ],
                                ),
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
                                child: Image.asset(MyImages.Location, height: 24,)
                            ),
                            Expanded(
                                flex: 10,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      headingText(text: 'Canada', fontSize: 14, fontFamily: 'semibold',),
                                      ParagraphText(text: 'Hdjdj - 14, lorem ipsum - CANADA',
                                        color: MyColors.textcolor,fontSize: 14,),
                                    ]
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: PopupMenuButton(
                                  icon: Icon(Icons.more_vert, color: Colors.black,),
                                  elevation: 0,
                                  offset: Offset(-30, 0),
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                    const PopupMenuItem(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text('Edit'),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text('Delete'),
                                      ),
                                    ),
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
                headingText(
                  text: 'Add New Address',
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                vSizedBox,
                GestureDetector(
                  onTap: (){
                    // Navigator.pushNamed(context, Provider_list_page.id);
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
                                  text: 'ADD ADDRESS', textColor: Colors.white,
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
                  child: StaffList(
                    text: 'Add anather address',
                    subtext: '',
                    subtextpad: false,
                    addicon: true,
                    horizontalpadding: 0,
                    color: Color(0xFF2C3A4B).withOpacity(0.50),
                    fontSize: 12,
                    fontFamily: 'regular',
                    heightimg: 50,
                    widthimg: 50,
                    usericon: false,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
