import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/loginpage.dart';
import 'package:calltofix/pages/signinpage.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';

class WelcomePage extends StatefulWidget {
  static const String id = "WelcomePage";
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool pressAttention1 = false;
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.welcome_back),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter)),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSizedBox6,
                  ParagraphText(
                    text: 'DISCOVER NOW',
                    color: MyColors.primaryColor,
                    letterspaceing: 1.2,
                    fontSize: 17,
                  ),
                  vSizedBox,
                  headingText(
                    text: 'Find Your On-Demand\nService Worker',
                    textAlign: TextAlign.center,
                    fontSize: 24,
                    fontFamily: 'medium',
                    height: 1.2,
                  ),
                  vSizedBox,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'We provide better service for you with our\n',
                      style: TextStyle(
                          color: MyColors.textcolor, fontSize: 14, height: 1.5),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Call-To-Fix',
                            style: TextStyle(
                                fontFamily: 'semibold',
                                color: MyColors.primaryColor)),
                        TextSpan(text: ' Service app'),
                      ],
                    ),
                  ),
                  vSizedBox4,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                pressAttention1 = !pressAttention1;
                                currentUserType = UserType.user;
                              });
                              await Future.delayed(Duration(milliseconds: 300));
                              await Navigator.pushNamed(
                                  context, SignIn_Page.id);
                              setState(() {
                                pressAttention1 = !pressAttention1;
                              });
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  boxShadow,
                                ],
                                border: pressAttention1
                                    ? Border.all(
                                        color: MyColors.primaryColor, width: 2)
                                    : Border.all(color: Colors.white, width: 2),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatarcustom(
                                    imageUrl: MyImages.user_icon_circle,
                                    height: 24,
                                    width: 24,
                                  ),
                                  hSizedBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(
                                          text: 'User',
                                          fontSize: 15,
                                          fontFamily: 'semibold',
                                          color: MyColors.primaryColor),
                                      ParagraphText(
                                        text: 'Click for User',
                                        fontSize: 10,
                                        fontFamily: 'regular',
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Container(),
                        // ),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Expanded(
                        //   flex: 2,
                        //   child: Container(),
                        // ),
                        Expanded(
                          // flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MouseRegion(
                                // onEnter: (event){
                                //   setState(() {
                                //     print('enteringg');
                                //     pressAttention = !pressAttention;
                                //     currentUserType = UserType.provider;
                                //   });
                                // },
                                // onExit: (event){
                                //   setState(() {
                                //     print('ecoit ');
                                //     pressAttention = !pressAttention;
                                //     // currentUserType = UserType.provider;
                                //   });
                                // },
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      pressAttention = !pressAttention;
                                      currentUserType = UserType.provider;
                                    });
                                    // await Future.delayed(Duration(milliseconds: 300));
                                    await Navigator.pushNamed(
                                        context, SignIn_Page.id);
                                    setState(() {
                                      pressAttention = !pressAttention;
                                    });
                                  },
                                  //
                                  // {
                                  //   setState(() {
                                  //     currentUserType = UserType.provider;
                                  //   });
                                  //   Navigator.pushNamed(context, LoginPage.id);
                                  //  },

                                  child: Container(
                                    // width: 140,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        boxShadow,
                                      ],
                                      border: pressAttention
                                          ? Border.all(
                                              color: MyColors.primaryColor,
                                              width: 2)
                                          : Border.all(
                                              color: Colors.white, width: 2),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatarcustom(
                                          imageUrl: MyImages.star_icon_circle,
                                          height: 24,
                                          width: 24,
                                        ),
                                        hSizedBox,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ParagraphText(
                                                text: 'Provider',
                                                fontSize: 15,
                                                fontFamily: 'semibold',
                                                color: MyColors.primaryColor),
                                            ParagraphText(
                                              text: 'Click for Provider',
                                              fontSize: 10,
                                              fontFamily: 'regular',
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       GestureDetector(
          //         child: CircleAvatarcustom(
          //           image: MyImages.next_icon_circle,
          //           bgcolor: Colors.transparent,
          //         ),
          //         onTap: (){
          //           Navigator.pushNamed(context, LoginPage.id);
          //         },
          //       ),
          //       vSizedBox,
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
