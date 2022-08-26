import 'dart:io';

import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/global_keys.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/pages/pending_screen_provider.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../functions/image_picker.dart';
import '../widgets/appbar.dart';


class Certification_Page extends StatefulWidget {
  // static const String id="Certification_Page";
  final Map<String,dynamic> request;
  Map<String,dynamic> files;
  Certification_Page({Key? key, required this.request, required this.files}) : super(key: key);

  @override
  State<Certification_Page> createState() => _Certification_PageState();
}

class _Certification_PageState extends State<Certification_Page> {
  TextEditingController namecontroller = TextEditingController();
  File? certificate;
  bool hasCertificate = true;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Personal Informations', appBarColor: MyColors.appbarcolor),
      body:
      // load?CustomLoader():
      Stack(
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
                  headingText(text: 'Do u have any certification or traning regarding profession?', fontSize: 20, fontFamily: 'medium',),
                  vSizedBox4,
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
                                            text: 'Yes',
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
                                      child:  Radio<bool>(
                                        value: true,
                                        groupValue: hasCertificate,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            hasCertificate = value??false;
                                          });
                                        },
                                      ),
                                  ),
                                ],
                              ),
                              Divider(color: MyColors.textcolor,height: 5,)
                            ],
                          ),
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
                                            text: 'No',
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
                                    child:  Radio<bool>(
                                      value: false,
                                      groupValue: hasCertificate,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          hasCertificate = value??false;
                                          if(hasCertificate ==false){
                                            certificate = null;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  vSizedBox4,
                  if(hasCertificate)
                  ParagraphText(text: 'Upload your Certificate document', fontFamily: 'medium',fontSize: 15,
                    color: Colors.black,),
                  vSizedBox,
                  if(hasCertificate)
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
                                                    certificate = file;
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
                                                    certificate = file;
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

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: ParagraphText(
                                            text: 'Upload certificate',
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
                                        certificate!=null?
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
                  if(certificate==null && hasCertificate){
                    showSnackbar('Please upload your certificate');
                  }else{
                    setState(() {
                      load = true;
                    });

                    if(certificate!=null){
                      widget.files['profession_certificate']= certificate;
                    }
                    /*var files = {
                      'profession_certificate': certificate
                    }*/
                    var jsonResponse = await Webservices.postDataWithImageFunction(body: widget.request, files: widget.files, context: context, apiUrl: ApiUrls.signup_final_step);
                    if(jsonResponse['status'].toString()=='1'){
                      updateSharedPreferences(userData!['id']);
                      Navigator.popUntil(context, (route) => route.isFirst);
                      await pushReplacement(context: MyGlobalKeys.navigatorKey.currentContext!, screen: PendingScreen());
                    }else{
                      showSnackbar('Eroor ${jsonResponse['status']} and ${jsonResponse['message']}');
                      setState(() {
                        load = false;
                      });
                    }


                  }
                  // Navigator.pushNamed(context, Tabs_Provider_Page.id);
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
