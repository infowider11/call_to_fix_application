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

class Terms_Page extends StatefulWidget {
  static const String id="Terms_Page";
  const Terms_Page({Key? key}) : super(key: key);

  @override
  State<Terms_Page> createState() => _Terms_PageState();
}

class _Terms_PageState extends State<Terms_Page> {
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
        appBar: appBar(context: context, title: 'Terms & Conditions', appBarColor: MyColors.appbarcolor),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height,
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
                    vSizedBox,
                    headingText(text: '1. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox4,
                    headingText(text: '2. Lorem Ipsum is simply dummy text?',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox4,
                    headingText(text: '3. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox4,
                    headingText(text: '4. Lorem Ipsum is simply dummy text?',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox4,
                    headingText(text: '5. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox4,
                    headingText(text: '6. Lorem Ipsum is simply dummy text?',
                      fontSize: 15, fontFamily: 'medium',),
                    vSizedBox,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      color: MyColors.textcolor, fontSize: 14,),
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
