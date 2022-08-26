import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import 'CustomTexts.dart';
import 'avatar.dart';



class StaffList extends StatelessWidget {
  final String text;
  final String subtext;
  final String image;
  final double? letterspaceing;
  final double? height;
  final double heightimg;
  final double widthimg;
  final double horizontalpadding;
  final Color? color;
  final Color? headingcolor;
  final double? fontSize;
  final double? headingfontsize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? headingfontfamily;
  final TextAlign? textAlign;
  final bool underlined;
  final bool usericon;
  final bool popupmenu;
  final bool popup;
  final bool rating;
  final bool counting;
  final bool boxshadow;
  final bool subtextpad;
  final bool addicon;
  final bool deleteicon;
  final bool underlinedtext;
  final bool chosseoption;
  const StaffList({
    Key? key,
    required this.text,
    required this.subtext,
    this.color = Colors.black,
    this.headingcolor = MyColors.headingcolor,
    this.fontSize,
    this.headingfontsize = 15,
    this.image = MyImages.user_icon_circle,
    this.letterspaceing,
    this.height,
    this.heightimg = 35,
    this.widthimg = 35,
    this.horizontalpadding = 16,
    this.fontWeight,
    this.fontFamily = 'medium',
    this.headingfontfamily = 'semibold',
    this.textAlign,
    this.underlined = false,
    this.usericon=true,
    this.popupmenu=false,
    this.popup=false,
    this.rating=false,
    this.counting=false,
    this.boxshadow=true,
    this.subtextpad=true,
    this.addicon=false,
    this.deleteicon=false,
    this.underlinedtext=false,
    this.chosseoption=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: boxshadow?[
          boxShadow
        ]: null
        // border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.symmetric(horizontal: boxshadow? 16 : 0, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: horizontalpadding, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Row(
              children: [
                if(usericon)
                Flexible(
                  flex: 3,
                    child: CircleAvatarcustom(
                      imageUrl: image,
                      bgcolor: Colors.transparent,
                      height: heightimg,
                      width: widthimg,
                      fit: BoxFit.fitHeight,
                      borderradius: 50,
                    )
                ),
                hSizedBox,
                Flexible(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                        child: ParagraphText(text: text,
                          fontSize: headingfontsize,
                          fontFamily: headingfontfamily,
                          color: Color(0xFF273240),
                        ),
                      ),
                      if(subtextpad==true)
                      Padding(
                        padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                        child: ParagraphText(
                          text: subtext,
                          fontSize: fontSize,
                          fontFamily: fontFamily,
                          color: color,
                        ),
                      ),
                      if(underlinedtext==true)
                        Padding(
                          padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                          child: ParagraphText(
                            text: subtext,
                            fontSize: fontSize,
                            fontFamily: fontFamily,
                            color: color,
                            underlined: true,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if(popupmenu)
          Flexible(
            flex: 1,
              child:PopupMenuButton(
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
          if(popup)
          Flexible(
            flex: 1,
            child:GestureDetector(
            onTap: (){
              // showDialog<void>(context: context, builder: (context) => dialog1);
              },
              child: Icon(
                Icons.chevron_right_outlined, color: MyColors.textcolor,
              ),
            ),
          ),
          if(addicon)
          Flexible(
              flex: 1,
              child:GestureDetector(
                onTap: (){
                  // showDialog<void>(context: context, builder: (context) => dialog1);
                },
                child: Icon(
                  Icons.add, color: Colors.black,
                ),
              ),
            ),
          if(deleteicon)
          Flexible(
              flex: 1,
              child:GestureDetector(
                onTap: (){
                  // showDialog<void>(context: context, builder: (context) => dialog1);
                },
                child: Image.asset(MyImages.Delete, height: 22,)
              ),
            ),
          if(chosseoption)
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: (){
                        // showDialog<void>(context: context, builder: (context) => dialog1);
                      },
                      child: Image.asset(MyImages.cross, height: 24,)
                  ),
                  px4,
                  GestureDetector(
                      onTap: (){
                        // showDialog<void>(context: context, builder: (context) => dialog1);
                      },
                      child: Image.asset(MyImages.check, height: 24,)
                  ),
                ],
              ),
          ),
          if(rating)
          Flexible(
              flex: 2,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star_rounded, color: Colors.black, size: 15,
                  ),
                  px2,
                  ParagraphText(text: '4.7', color: Colors.black, fontSize: 10,)
                ],
              ),
            ),
          if(counting)
          Flexible(
              flex: 2,
              child:Container(
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
                      },
                      child: ParagraphText(
                        text: '-',
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'semibold',
                      ),
                    ),
                    ParagraphText(
                      text: '1',
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'semibold',
                    ),
                    GestureDetector(
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
            ),
        ],
      ),
    );
  }
}


class Booking_List extends StatelessWidget {
  final String text;
  final String subtext;
  final String btntext;
  final String image;
  final double? letterspaceing;
  final double? height;
  final double heightimg;
  final double widthimg;
  final double horizontalpadding;
  final Color? color;
  final Color? headingcolor;
  final Color? amountcolor;
  final Color btntextcolor;
  final Color btncolor;
  final double? fontSize;
  final double btnradius;
  final double? btnfontsize;
  final double? headingfontsize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? headingfontfamily;
  final TextAlign? textAlign;
  final bool underlined;
  final bool usericon;
  final bool popupmenu;
  final bool popup;
  final bool rating;
  final bool counting;
  final bool boxshadow;
  final bool subtextpad;
  final bool addicon;
  final bool deleteicon;
  final bool underlinedtext;
  final bool button;
  final bool ammount;
  final bool viewbtn;
  final bool requestbtn;
  final bool videobtn;
  const Booking_List({
    Key? key,
    required this.text,
    required this.subtext,
    required this.btntext,
    this.color = Colors.black,
    this.btntextcolor = Colors.white,
    this.btncolor = Colors.black,
    this.headingcolor = MyColors.headingcolor,
    this.amountcolor = MyColors.headingcolor,
    this.fontSize,
    this.btnfontsize,
    this.btnradius = 10,
    this.headingfontsize = 15,
    this.image = MyImages.user_icon_circle,
    this.letterspaceing,
    this.height,
    this.heightimg = 35,
    this.widthimg = 35,
    this.horizontalpadding = 16,
    this.fontWeight,
    this.fontFamily = 'medium',
    this.headingfontfamily = 'semibold',
    this.textAlign,
    this.underlined = false,
    this.usericon=true,
    this.popupmenu=false,
    this.popup=false,
    this.rating=false,
    this.counting=false,
    this.boxshadow=true,
    this.subtextpad=true,
    this.addicon=false,
    this.deleteicon=false,
    this.underlinedtext=false,
    this.button=false,
    this.ammount=false,
    this.viewbtn=true,
    this.requestbtn=false,
    this.videobtn=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: boxshadow?[
            boxShadow
          ]: null
        // border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.symmetric(horizontal: boxshadow? 16 : 0, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: horizontalpadding, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 12,
            child: Row(
              children: [
                if(usericon)
                  Flexible(
                      flex: 3,
                      child: CustomCircularImage(
                        imageUrl: image,
                        height: heightimg,
                        width: widthimg,
                        fit: BoxFit.cover,
                      )
                  ),
                hSizedBox,
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                        child: ParagraphText(text: text,
                          fontSize: headingfontsize,
                          fontFamily: headingfontfamily,
                          color: Color(0xFF273240),
                        ),
                      ),py3,
                      if(subtextpad==true)
                        Padding(
                          padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                          child: ParagraphText(
                            text: subtext,
                            fontSize: fontSize,
                            fontFamily: fontFamily,
                            color: color,
                          ),
                        ),
                        py3,
                      if(viewbtn)
                      Row(
                          children: [
                            Padding(
                              padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                              child: ParagraphText(
                                text: 'View Details',
                                fontSize: 9,
                                fontFamily: fontFamily,
                                color:MyColors.primaryColor,
                                underlined: true,
                              ),
                            ),
                            hSizedBox,
                            Padding(
                              padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                              child: ParagraphText(
                                text: 'Mark as complete',
                                fontSize: 9,
                                fontFamily: fontFamily,
                                color: MyColors.primaryColor,
                                underlined: true,
                              ),
                            ),
                          ],
                        ),
                      py3,
                      if(requestbtn)
                        Row(
                          children: [
                            Flexible(
                                child: Column(
                                  children: [
                                    RoundEdgedButton(
                                      textColor: btntextcolor,
                                      color: btncolor,
                                      fontSize: btnfontsize,
                                      borderRadius: btnradius,
                                      text: 'Accept',
                                      width: 67,
                                      verticalPadding: 0,
                                      horizontalPadding: 0,
                                      height: 20,
                                      fontfamily: 'regular',
                                      letterspace: 0,
                                      onTap: ()async{
                                      },
                                    ),
                                  ],
                                )
                            ),
                            hSizedBox,
                            Flexible(
                                child: Column(
                                  children: [
                                    RoundEdgedButton(
                                      textColor: Colors.red,
                                      color: Colors.red.withOpacity(0.4),
                                      fontSize: btnfontsize,
                                      borderRadius: btnradius,
                                      text: 'Reject',
                                      width: 62,
                                      verticalPadding: 0,
                                      horizontalPadding: 0,
                                      height: 20,
                                      fontfamily: 'regular',
                                      letterspace: 0,
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      py3,
                      if(videobtn)
                        Row(
                          children: [
                            RoundEdgedButton(
                              textColor: Colors.white,
                              color: MyColors.primaryColor,
                              fontSize: btnfontsize,
                              borderRadius: btnradius,
                              text: 'Start Video call',
                              width: 100,
                              verticalPadding: 0,
                              horizontalPadding: 0,
                              height: 20,
                              fontfamily: 'regular',
                              letterspace: 0,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if(popupmenu)
            Flexible(
              flex: 1,
              child:PopupMenuButton(
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
                      title: Text('Upload Photo'),
                    ),
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('Remove Photo'),
                    ),
                  ),
                ],
              ),
            ),
          if(popup)
            Flexible(
              flex: 1,
              child:GestureDetector(
                onTap: (){
                  // showDialog<void>(context: context, builder: (context) => dialog1);
                },
                child: Icon(
                  Icons.chevron_right_outlined, color: MyColors.textcolor,
                ),
              ),
            ),
          if(addicon)
            Flexible(
              flex: 1,
              child:GestureDetector(
                onTap: (){
                  // showDialog<void>(context: context, builder: (context) => dialog1);
                },
                child: Icon(
                  Icons.add, color: Colors.black,
                ),
              ),
            ),
          if(deleteicon)
            Flexible(
              flex: 1,
              child:GestureDetector(
                  onTap: (){
                    // showDialog<void>(context: context, builder: (context) => dialog1);
                  },
                  child: Image.asset(MyImages.Delete, height: 22,)
              ),
            ),
          if(rating)
            Flexible(
              flex: 2,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star_rounded, color: Colors.black, size: 15,
                  ),
                  px2,
                  ParagraphText(text: '4.7', color: Colors.black, fontSize: 10,)
                ],
              ),
            ),
          if(counting)
            Flexible(
              flex: 2,
              child:Container(
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
                      },
                      child: ParagraphText(
                        text: '-',
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'semibold',
                      ),
                    ),
                    ParagraphText(
                      text: '1',
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'semibold',
                    ),
                    GestureDetector(
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
            ),
          if(button)
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  RoundEdgedButton(
                    textColor: btntextcolor,
                    color: btncolor,
                    fontSize: btnfontsize,
                    borderRadius: btnradius,
                    text: btntext,
                    width: 99,
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    height: 20,
                    fontfamily: 'regular',
                    letterspace: 0,
                  ),
                ],
              )
            ),
          if(ammount)
            Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ParagraphText(
                      text: '-\$100',
                      fontSize: 18,
                      fontFamily: 'medium',
                      color: amountcolor,
                    ),
                  ],
                )
            ),

        ],
      ),
    );
  }
}

class Job extends StatelessWidget {
  final String text;
  final String subtext;
  final String btntext;
  final String viewbtntext;
  final String image;
  final double? letterspaceing;
  final double? height;
  final double heightimg;
  final double widthimg;
  final double horizontalpadding;
  final Color? color;
  final Color? headingcolor;
  final Color? amountcolor;
  final Color btntextcolor;
  final Color btncolor;
  final Color viewbtncolor;
  final double? fontSize;
  final double btnradius;
  final double? btnfontsize;
  final double? headingfontsize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? headingfontfamily;
  final TextAlign? textAlign;
  final bool underlined;
  final bool usericon;
  final bool popupmenu;
  final bool popup;
  final bool rating;
  final bool counting;
  final bool boxshadow;
  final bool subtextpad;
  final bool addicon;
  final bool deleteicon;
  final bool underlinedtext;
  final bool button;
  final bool ammount;
  final bool viewbtn;
  final bool requestbtn;
  const Job({
    Key? key,
    required this.text,
    required this.subtext,
    required this.btntext,
    required this.viewbtntext,
    this.color = Colors.black,
    this.btntextcolor = Colors.white,
    this.btncolor = Colors.black,
    this.viewbtncolor = Colors.black,
    this.headingcolor = MyColors.headingcolor,
    this.amountcolor = MyColors.headingcolor,
    this.fontSize,
    this.btnfontsize,
    this.btnradius = 10,
    this.headingfontsize = 15,
    this.image = MyImages.user_icon_circle,
    this.letterspaceing,
    this.height,
    this.heightimg = 35,
    this.widthimg = 35,
    this.horizontalpadding = 16,
    this.fontWeight,
    this.fontFamily = 'medium',
    this.headingfontfamily = 'semibold',
    this.textAlign,
    this.underlined = false,
    this.usericon=true,
    this.popupmenu=false,
    this.popup=false,
    this.rating=false,
    this.counting=false,
    this.boxshadow=true,
    this.subtextpad=true,
    this.addicon=false,
    this.deleteicon=false,
    this.underlinedtext=false,
    this.button=false,
    this.ammount=false,
    this.viewbtn=true,
    this.requestbtn=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: boxshadow?[
            boxShadow
          ]: null
        // border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.symmetric(horizontal: boxshadow? 16 : 0, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: horizontalpadding, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 12,
            child: Row(
              children: [
                if(usericon)
                  Flexible(
                      flex: 3,
                      child: CircleAvatarcustom(
                        imageUrl: image,
                        bgcolor: Colors.transparent,
                        height: heightimg,
                        width: widthimg,
                        fit: BoxFit.fitHeight,
                        borderradius: 50,
                      )
                  ),
                hSizedBox,
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                        child: ParagraphText(text: text,
                          fontSize: headingfontsize,
                          fontFamily: headingfontfamily,
                          color: Color(0xFF273240),
                        ),
                      ),py3,
                      if(subtextpad==true)
                        Padding(
                          padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                          child: ParagraphText(
                            text: subtext,
                            fontSize: fontSize,
                            fontFamily: fontFamily,
                            color: color,
                          ),
                        ),
                      py3,
                      if(viewbtn)
                        Row(
                          children: [
                            Padding(
                              padding: usericon==true? EdgeInsets.all(0.0) : EdgeInsets.only(left: 0),
                              child: ParagraphText(
                                text: viewbtntext,
                                fontSize: 9,
                                fontFamily: fontFamily,
                                color:viewbtncolor,
                                underlined: true,
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
          if(popupmenu)
            Flexible(
              flex: 1,
              child:PopupMenuButton(
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
                      title: Text('Upload Photo'),
                    ),
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('Remove Photo'),
                    ),
                  ),
                ],
              ),
            ),
          if(deleteicon)
            Flexible(
              flex: 3,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: (){
                        // showDialog<void>(context: context, builder: (context) => dialog1);
                      },
                      child: Column(
                        children: [
                          Image.asset(MyImages.Message, height: 20, fit: BoxFit.contain,),
                        ],
                      )
                  ),
                  hSizedBox,
                  GestureDetector(
                      onTap: (){
                        // showDialog<void>(context: context, builder: (context) => dialog1);
                      },
                      child: Column(
                        children: [
                          Image.asset(MyImages.Call, height: 20,),
                        ],
                      )
                  ),
                ],
              ),
            ),
          if(button)
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    RoundEdgedButton(
                      textColor: btntextcolor,
                      color: btncolor,
                      fontSize: btnfontsize,
                      borderRadius: btnradius,
                      text: btntext,
                      width: 99,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      height: 20,
                      fontfamily: 'regular',
                      letterspace: 0,
                    ),
                  ],
                )
            ),

        ],
      ),
    );
  }
}