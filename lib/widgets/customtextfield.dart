import 'package:calltofix/constants/constans.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'CustomTexts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final double horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double suffixheight;
  final double height;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextAlign textAlign;
  final double paddingsuffix;
  final TextInputType? keyboardType;
  final bool boxshadow;
  final Color textColor;
  bool enabled;
  final Function(String)? onChanged;
  final Function(String)? onSubmited;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = 0,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.inputbordercolor = Colors.transparent,
    this.hintcolor = MyColors.textcolor,
    this.verticalPadding = 0,
    this.fontsize = 13,
    this.left = 16,
    this.suffixheight = 10,
    this.height = 50,
    this.borderradius = 15,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 12,
    this.boxshadow=false,
    this.textColor = Colors.black,
     this.keyboardType,
    this.enabled = true,
    this.onChanged,
    this.onSubmited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              // border: InputBorder.none,
              color: bgColor,
              border: border?? Border.all(color: Colors.transparent),
              // border: Border,
              borderRadius: BorderRadius.circular(borderradius),
              boxShadow:[
                shadow
              ]
          ),
          padding: EdgeInsets.only(left: left),
          child: TextField(
            onSubmitted: onSubmited,
            onChanged:onChanged,
            style: TextStyle(color: textColor, fontSize: fontsize, fontFamily: 'regular'),
            maxLines: maxLines ?? 1,
            enabled: enabled,
            controller: controller,
            obscureText: obscureText,
            textAlign: textAlign,
            keyboardType: keyboardType,
            decoration: InputDecoration(

              hintText: hintText,
              hintStyle: TextStyle(fontSize: fontsize, color: hintcolor, fontFamily: 'regular'),
              border: InputBorder.none ,
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: inputbordercolor)
              // ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: inputbordercolor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: inputbordercolor),
              ),
              // focusedBorder: InputBorder.none,
              // border: UnderlineInputBorder(
              //   borderSide: BorderSide(color: inputbordercolor),
              // ),

              prefixIcon:prefixIcon==null?null:
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 15.0,bottom: 15.0),
                child: Image.asset(
                  prefixIcon!,
                  width: 10,
                  height: 10,
                  fit: BoxFit.fitHeight,
                ),
              ),
              suffixIcon: suffixIcon==null?null:
              Padding(
                padding: EdgeInsets.all(paddingsuffix),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      suffixIcon!,
                      // color: Colors.black,
                      // width: 10,
                      height: suffixheight,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


      ],
    );
  }
}

class CustomTextFieldwithoutshadow extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextAlign textAlign;
  final double paddingsuffix;
  CustomTextFieldwithoutshadow({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.inputbordercolor = Colors.transparent,
    this.hintcolor = Colors.black,
    this.verticalPadding = 0,
    this.fontsize = 16,
    this.left = 16,
    this.borderradius = 8,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 45,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 1, left: 5,right: 5),
          decoration: BoxDecoration(
              // color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(borderradius)
          ),
        ),
        Container(
          // height: 50,
          margin: EdgeInsets.symmetric(horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
          decoration: BoxDecoration(
            color: bgColor,
            border: border?? Border.all(color: Colors.transparent),
            // border: Border,
            borderRadius: BorderRadius.circular(borderradius),

          ),
          padding: EdgeInsets.only(left: left),
          child: TextField(
            style: TextStyle(color: Colors.black, fontSize: fontsize, fontFamily: 'av_book'),
            maxLines: maxLines ?? 1,
            controller: controller,
            obscureText: obscureText,
            textAlign: textAlign,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: fontsize, color: hintcolor,),
              // border: InputBorder.none ,
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: inputbordercolor)
              // ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: inputbordercolor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: inputbordercolor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: inputbordercolor),
              ),

              prefixIcon:prefixIcon==null?null:
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0,bottom: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF97989A),
                            offset: Offset(0,4.0),
                            spreadRadius: 0.0,
                            blurRadius: 4.0
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Image.asset(
                    prefixIcon!,
                    width: 10,
                    height: 10,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              suffixIcon: suffixIcon==null?null:
              Padding(
                padding: EdgeInsets.all(paddingsuffix),
                child: Image.asset(
                  suffixIcon!,
                  // color: Colors.black,
                  width: 10,
                  height: 10,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),


      ],
    );
  }
}

class CustomTextFieldapply extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final double verticalPadding;
  final String? prefixIcon;
  final TextAlign textAlign;
  CustomTextFieldapply({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.verticalPadding = 4,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: MyColors.primaryColor),
            // border: Border,
            borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: TextField(

                maxLines: maxLines ?? 1,
                controller: controller,
                obscureText: obscureText,
                textAlign: textAlign,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 16),
                  border: InputBorder.none,
                  prefixIcon:prefixIcon==null?null:
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      prefixIcon!,
                      width: 10,
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(onPressed: (){},
                child: Text('apply',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                )
            )
          ],
        )


    );
  }
}


class CustomTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final double verticalPadding;
  final String? prefixIcon;
  const CustomTextFields({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.verticalPadding = 8,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: MyColors.primaryColor),
          // border: Border,
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(left: 10),
      child: TextField(
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 13),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Image.asset(
              'assets/images/user.png',
              width: 10,
              height: 10,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldEditProfile extends StatelessWidget {
  final TextEditingController controller;
  final String headingText;
  final String hintText;
  const CustomTextFieldEditProfile({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.headingText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeadingText(text: headingText),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                )
            ),
          )
        ],
      ),
    );
  }
}
