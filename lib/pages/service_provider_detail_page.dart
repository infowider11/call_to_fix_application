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

class Service_Provider_Detail_Page extends StatefulWidget {
  static const String id="Service_Provider_Detail_Page";
  const Service_Provider_Detail_Page({Key? key}) : super(key: key);

  @override
  State<Service_Provider_Detail_Page> createState() => _Service_Provider_Detail_PageState();
}

class _Service_Provider_Detail_PageState extends State<Service_Provider_Detail_Page> {
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
                        headingText(text: 'Air Conditioner', fontSize: 18,),
                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            RoundEdgedButton(
                              text: 'ADD', textColor: Colors.white,
                              borderRadius: 5,
                              height: 20,
                              width: 50,
                              fontSize: 10,
                              fontfamily: 'semibold',
                              horizontalPadding: 10,
                              verticalPadding: 0,
                              onTap: () {
                                showModalBottomSheet<void>(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color:  Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        )
                                      ),
                                      child: Column(
                                        children: [
                                          vSizedBox,
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                visualDensity: VisualDensity(vertical: -4),
                                                activeColor: MyColors.primaryColor,
                                                focusColor: MyColors.primaryColor,
                                                value: SingingCharacter.lafayette,
                                                groupValue: _character,
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    _character = value;
                                                  });
                                                },
                                              ),
                                              hSizedBox,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  headingText(text: 'Instent Video Consult',fontSize: 15,),
                                                  ParagraphText(text: '\$100', color: MyColors.subtext,fontSize: 14,),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                            color: Color(0xFFC6C6C8),
                                            indent: 50,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                visualDensity: VisualDensity(vertical: -4),
                                                activeColor: MyColors.primaryColor,
                                                focusColor: MyColors.primaryColor,
                                                value: SingingCharacter.jefferson,
                                                groupValue: _character,
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    _character = value;
                                                  });
                                                },
                                              ),
                                              hSizedBox,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  headingText(text: 'In-Person Visit', fontSize: 15,),
                                                  ParagraphText(text: '\$300', color: MyColors.subtext,fontSize: 14,),
                                                ],
                                              )
                                            ],
                                          ),
                                          vSizedBox2,
                                          RoundEdgedButton(
                                            text: 'ADD ADDRESS AND SLOT', textColor: Colors.white,
                                            letterspace: 1,
                                            onTap: (){
                                              Navigator.of(context).pop();
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

                          ],
                        ),
                        vSizedBox,
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
