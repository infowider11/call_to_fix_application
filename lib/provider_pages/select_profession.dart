import 'package:calltofix/constants/error_constants.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/provider_pages/add_service.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../widgets/appbar.dart';

// enum SingingCharacter { one, two, three, four, five, six, seven, }

class Select_Profession_Page extends StatefulWidget {
  static const String id="Select_Profession_Page";
  Map? workCategory;
  Select_Profession_Page({Key? key, required this.workCategory}) : super(key: key);

  @override
  State<Select_Profession_Page> createState() => _Select_Profession_PageState();
}

class _Select_Profession_PageState extends State<Select_Profession_Page> {
  TextEditingController namecontroller = TextEditingController();
  // SingingCharacter? _character = SingingCharacter.one;
  // bool isChecked = false;

  bool load = false;
  getProfessions()async{
    setState(() {
      load = true;
    });


    if(widget.workCategory!=null){
      professions.forEach((element) {
        if(element['id']==widget.workCategory!['id']){
          widget.workCategory= element;
        }
      });
    }
    setState(() {
      load = false;
    });
  }

  initializeValue()async{

  }


  @override
  void initState() {
    // TODO: implement initState
getProfessions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Personal Informations', appBarColor: MyColors.appbarcolor),
      body:
      // load? CustomLoader():
      Stack(
        children: [
          Container(
            padding: pad_horizontal,
            width: MediaQuery.of(context).size.width,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText(text: 'What work do you do?', fontSize: 20, fontFamily: 'medium',),
                  ParagraphText(text: 'Select your profession', fontFamily: 'regular',fontSize: 16,color: MyColors.textcolor,),
                  vSizedBox4,
                  for(int i = 0;i<professions.length;i++)
                  Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            boxShadow
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 12,
                            child: Row(
                              children: [
                                Flexible(
                                    child: CustomCircularImage(
                                      imageUrl: professions[i]['cat_icon'],
                                      height: 55,
                                      width: 55,
                                    )
                                ),
                                hSizedBox,
                                Flexible(
                                  child: ParagraphText(
                                    text: professions[i]['title'],
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'semibold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                              child:  Radio<Map>(
                                value: professions[i],
                                groupValue: widget.workCategory,
                                onChanged: (Map? value) {
                                  setState(() {
                                    widget.workCategory = value;
                                  });
                                },
                              ),
                          ),
                        ],
                      )
                  ),
                  vSizedBox,
                  // Container(
                  //     padding: EdgeInsets.all(16),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           boxShadow
                  //         ]
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //           flex: 12,
                  //           child: Row(
                  //             children: [
                  //               Flexible(
                  //                   child: CircleAvatarcustom(
                  //                     image: MyImages.plumb,
                  //                     height: 55,
                  //                     width: 55,
                  //                   )
                  //               ),
                  //               hSizedBox,
                  //               Flexible(
                  //                 child: ParagraphText(
                  //                   text: 'Maid Services',
                  //                   fontSize: 14,
                  //                   color: Colors.black,
                  //                   fontFamily: 'semibold',
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child:  Radio<SingingCharacter>(
                  //             value: SingingCharacter.two,
                  //             groupValue: _character,
                  //             onChanged: (SingingCharacter? value) {
                  //               setState(() {
                  //                 _character = value;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),

                  vSizedBox6
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: RoundEdgedButton(
                text: 'CONTINUE',
                textColor: Colors.white,
                  onTap: (){
                  if(widget.workCategory!=null) {
                    push(context: context,
                        screen: Add_Service_Page(
                            categoryId: widget.workCategory!['id'], category: widget.workCategory,));
                  }
                  else{
                    showSnackbar(MyErrorConstants.invalidselectCategory);
                  }
                  },
              ),
            ),
          ),
          if(load)
            CustomFullPageLoader()
        ],
      ),
    );
  }
}
