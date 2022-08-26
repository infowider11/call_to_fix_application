import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/pages/terms.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About_Us_Page extends StatefulWidget {
  static const String id="About_Us_Page";
  const About_Us_Page({Key? key}) : super(key: key);

  @override
  State<About_Us_Page> createState() => _About_Us_PageState();
}

class _About_Us_PageState extends State<About_Us_Page> {
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
        appBar: appBar(context: context, title: 'About Us', appBarColor: MyColors.appbarcolor),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                    vSizedBox4,
                    Center(
                        child: Image.asset(MyImages.logo, height: 95,
                        )
                    ),
                    vSizedBox4,
                    headingText(text: 'About Us', fontSize: 20, fontFamily: 'medium',),
                    vSizedBox2,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages',
                      color: MyColors.textcolor, fontSize: 14,),
                    vSizedBox2,
                    ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages',
                      color: MyColors.textcolor, fontSize: 14,),

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Terms_Page.id);
                    },
                    child: ParagraphText(
                      textAlign: TextAlign.center,
                      text: 'Terms & Conditions',
                      color: MyColors.primaryColor,
                      underlined: true,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
