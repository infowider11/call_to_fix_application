import 'dart:io';

import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/image_picker.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../widgets/appbar.dart';
import 'certification.dart';



class About_Work_Page extends StatefulWidget {
  static const String id="About_Work_Page";
  final Map? prefilledWorkInformation;
  const About_Work_Page({Key? key, this.prefilledWorkInformation}) : super(key: key);

  @override
  State<About_Work_Page> createState() => _About_Work_PageState();
}

class _About_Work_PageState extends State<About_Work_Page> {
  TextEditingController namecontroller = TextEditingController();

  File? idProof;
  File? drivingLicense;

  Map? selectedSourceOfIncome;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Personal Informations', appBarColor: MyColors.appbarcolor),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText(text: 'Tell us about your work!', fontSize: 20, fontFamily: 'medium',),
                  vSizedBox4,
                  ParagraphText(text: 'What is your source of income?', fontFamily: 'medium',fontSize: 15,
                    color: Colors.black,),
                  vSizedBox,
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            boxShadow
                          ]
                      ),
                      child: Column(
                        children: [
                          for(int i = 0;i<sourcesOfIncomeList.length;i++)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: ParagraphText(
                                            text: sourcesOfIncomeList[i]['title'],
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: 'regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                      child:  Radio<Map?>(
                                        value: sourcesOfIncomeList[i],
                                        groupValue: selectedSourceOfIncome,
                                        onChanged: (Map? value) {
                                          setState(() {
                                            selectedSourceOfIncome = value;
                                          });
                                        },
                                      ),
                                  ),
                                ],
                              ),
                              if(i!=sourcesOfIncomeList.length-1)
                              Divider(color: MyColors.textcolor,height: 5,)
                            ],
                          ),

                        ],
                      )
                  ),
                  vSizedBox4,
                  ParagraphText(text: 'Upload your Identity document', fontFamily: 'medium',fontSize: 15,
                    color: Colors.black,),
                  vSizedBox,
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            boxShadow
                          ]
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: ()async{
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      height: 150,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Please Choose:',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          vSizedBox4,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  File? file = await pickImage(false);

                                                  if(file!=null){
                                                    idProof = file;
                                                    setState(() {

                                                    });
                                                  }

                                                },
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                              hSizedBox8,
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  File? file = await pickImage(true);

                                                  if(file!=null){
                                                    idProof = file;
                                                    setState(() {

                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });

                              setState(() {

                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: ParagraphText(
                                                text: 'Upload ID proof',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'regular',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            idProof!=null?
                                            RoundEdgedButton(
                                              text: 'Uploaded',
                                              width: 60,
                                              height: 20,
                                              verticalPadding: 0,
                                              horizontalPadding: 0,
                                              textColor: Colors.white,
                                              color:Colors.green,
                                              fontSize: 9,
                                              letterspace: 0,
                                            ):
                                            RoundEdgedButton(
                                              text: 'Upload',
                                              width: 50,
                                              height: 20,
                                              verticalPadding: 0,
                                              horizontalPadding: 0,
                                              textColor: Colors.black,
                                              color: Color(0xFFEC8E15).withOpacity(0.5),
                                              fontSize: 9,
                                              letterspace: 0,
                                            ),
                                          ],
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: MyColors.textcolor,height: 5,)
                              ],
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: ()async{
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      height: 150,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Please Choose:',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          vSizedBox4,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  File? file = await pickImage(false);

                                                  if(file!=null){
                                                    drivingLicense = file;
                                                    setState(() {

                                                    });
                                                  }

                                                },
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                              hSizedBox8,
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  File? file = await pickImage(true);

                                                  if(file!=null){
                                                    drivingLicense = file;
                                                    setState(() {

                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });

                              setState(() {

                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: ParagraphText(
                                                text: 'Upload driving license',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'regular',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              drivingLicense!=null?
                                              RoundEdgedButton(
                                                text: 'Uploaded',
                                                width: 60,
                                                height: 20,
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                textColor: Colors.white,
                                                color:Colors.green,
                                                fontSize: 9,
                                                letterspace: 0,
                                              ):
                                              RoundEdgedButton(
                                                text: 'Upload',
                                                width: 50,
                                                height: 20,
                                                verticalPadding: 0,
                                                horizontalPadding: 0,
                                                textColor: Colors.black,
                                                color: Color(0xFFEC8E15).withOpacity(0.5),
                                                fontSize: 9,
                                                letterspace: 0,
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  vSizedBox6
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundEdgedButton(
                text: 'Continue',
                textColor: Colors.white,
                onTap: ()async{
                  if(selectedSourceOfIncome==null){
                    showSnackbar('Please select source of income.');

                  }else if(idProof==null){
                    showSnackbar('Please upload your ID proof.');
                  }else if(drivingLicense==null){
                    showSnackbar('Please upload your driving license.');
                  } else{
                    var request = {
                      "user_id": userData!['id'],
                      "source_of_income": selectedSourceOfIncome!['id'],
                    };
                    var files = {
                      "id_proof": idProof,
                      "driving_license": drivingLicense,
                      // "profession_certificate": "",
                    };
                    push(
                        context: context,
                        screen: Certification_Page(
                          files: files,
                          request: request,
                        ));
                  }

                  // Navigator.pushNamed(context, Certification_Page.id);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
