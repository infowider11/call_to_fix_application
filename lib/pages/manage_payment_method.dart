import 'package:calltofix/constants/checkbox.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/lists.dart';

class Manage_Payment_Method_Page extends StatefulWidget {
  static const String id="Manage_Payment_Method_Page";
  const Manage_Payment_Method_Page({Key? key}) : super(key: key);

  @override
  State<Manage_Payment_Method_Page> createState() => _Manage_Payment_Method_PageState();
}

class _Manage_Payment_Method_PageState extends State<Manage_Payment_Method_Page> {
  TextEditingController house = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Manage Payment Method', appBarColor: MyColors.appbarcolor),
      body: SingleChildScrollView(
        child: Container(
          padding: pad_horizontal,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              GestureDetector(
                onTap: (){
                  // Navigator.pushNamed(context, Provider_list_page.id);
                },
                child: StaffList(
                  text: 'Debit Card A/C xx0012',
                  subtext: 'Bank',
                  horizontalpadding: 0,
                  color: Color(0xFF2C3A4B).withOpacity(0.50),
                  fontSize: 12,
                  fontFamily: 'regular',
                  image: MyImages.debit_card_circle,
                  heightimg: 50,
                  widthimg: 50,
                  popupmenu: true,
                ),
              ),
              GestureDetector(
                onTap: (){
                  // Navigator.pushNamed(context, Provider_list_page.id);
                },
                child: StaffList(
                  text: 'Debit Card A/C xx0012',
                  subtext: 'Bank',
                  popupmenu: true,
                  horizontalpadding: 0,
                  color: Color(0xFF2C3A4B).withOpacity(0.50),
                  fontSize: 12,
                  fontFamily: 'regular',
                  image: MyImages.debit_card_circle,
                  heightimg: 50,
                  widthimg: 50,
                ),
              ),
              GestureDetector(
                onTap: (){
                  // Navigator.pushNamed(context, Provider_list_page.id);
                },
                child: StaffList(
                  text: 'Debit Card A/C xx0012',
                  subtext: 'Bank',
                  popupmenu: true,
                  horizontalpadding: 0,
                  color: Color(0xFF2C3A4B).withOpacity(0.50),
                  fontSize: 12,
                  fontFamily: 'regular',
                  image: MyImages.debit_card_circle,
                  heightimg: 50,
                  widthimg: 50,
                ),
              ),
              vSizedBox,
              headingText(
                text: 'New Payment Options',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vSizedBox2,
                              headingText(text: 'Enter Card Details', fontSize: 16, fontFamily: 'medium',),
                              vSizedBox2,
                              CustomTextField(
                                controller: house,
                                hintText: 'Card Number',
                                borderradius: 15,
                                suffixIcon: MyImages.debit_card_black,
                                paddingsuffix: 10,
                                fontsize: 13,
                                suffixheight: 17,
                              ),
                              vSizedBox,
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: house,
                                      hintText: 'Expiry Date',
                                      borderradius: 15,
                                      fontsize: 13,
                                    ),
                                  ),
                                  hSizedBox,
                                  Expanded(
                                    child: CustomTextField(
                                      controller: house,
                                      hintText: 'CVV',
                                      fontsize: 13,
                                      borderradius: 15,
                                    ),
                                  ),
                                ],
                              ),
                              vSizedBox,
                              CustomTextField(
                                controller: house,
                                hintText: 'Name of card holder',
                                borderradius: 15,
                                fontsize: 13,
                              ),
                              vSizedBox,
                              LabeledCheckbox(
                                label: 'Save Card',
                              ),
                              vSizedBox,
                              RoundEdgedButton(
                                text: 'Save and Proceed', textColor: Colors.white,
                                letterspace: 1,
                                onTap: (){
                                  Navigator.of(context).pop();
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
                              ),
                              vSizedBox,
                            ],
                          )
                      );
                    },
                  );
                },
                child: StaffList(
                  text: 'Add Card',
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
          ),
        ),
      ),
    );
  }
}
