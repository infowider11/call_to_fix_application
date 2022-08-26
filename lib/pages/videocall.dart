import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/pages/cart.dart';
import 'package:calltofix/pages/my_bookings.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';

class VideoCall_Page extends StatefulWidget {
  static const String id="VideoCall_Page";
  const VideoCall_Page({Key? key}) : super(key: key);

  @override
  State<VideoCall_Page> createState() => _VideoCall_PageState();
}

class _VideoCall_PageState extends State<VideoCall_Page> {
  TextEditingController house = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Video Call', appBarColor: MyColors.appbarcolor),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Image.asset(MyImages.videocall, fit: BoxFit.cover,),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async{
                  Navigator.pushNamed(context, My_Bookings_page.id);
                  await Future.delayed(Duration(milliseconds: 600));
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          height: MediaQuery.of(context).size.height / 1.9,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F4F8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              vSizedBox2,
                              headingText(text: 'Rate the service provider', fontSize: 16, fontFamily: 'medium',),
                              ParagraphText(text: 'Give us a quick review and help us improve?',
                                fontSize: 14, color: MyColors.textcolor,
                              ),
                              vSizedBox2,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                  ),
                                  Icon(
                                    Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                  ),
                                  Icon(
                                    Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                  ),
                                  Icon(
                                    Icons.star_rounded, size: 45, color: MyColors.primaryColor,
                                  ),
                                  Icon(
                                    Icons.star_rounded, size: 45, color: MyColors.textcolor,
                                  ),
                                ],
                              ),
                              vSizedBox2,
                              CustomTextField(
                                controller: house,
                                hintText: 'Write the review here..',
                                borderradius: 15,
                                paddingsuffix: 10,
                                fontsize: 14,
                                suffixheight: 17,
                                maxLines: 6,
                                height: 127,
                              ),
                              vSizedBox2,
                              RoundEdgedButton(
                                text: 'Rate Now', textColor: Colors.white,
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
                  child: Image.asset(
                      MyImages.call_end)
              ),
            ),
          )
        ],
      )
    );
  }
}
