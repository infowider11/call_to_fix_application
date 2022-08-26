import 'dart:developer';

import 'package:calltofix/constants/error_constants.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/provider_pages/select_city.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../widgets/appbar.dart';


class ChangePasswordPage extends StatefulWidget {
  static const String id="Edit_Profile_Page";
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool load = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Change Password', appBarColor: MyColors.appbarcolor),
      body:
      // load?CustomLoader():
      Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: pad_horizontal,
              width: MediaQuery.of(context).size.width,
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
                  vSizedBox,
                  headingText(text: 'Old Password', fontSize: 16, fontFamily: 'medium',),
                  vSizedBox,
                  CustomTextField(
                    controller: oldPasswordController,
                    hintText: 'Enter your old password here',
                    hintcolor: Colors.black,
                    obscureText: true,
                    fontsize: 13,
                  ),
                  vSizedBox2,
                  headingText(text: 'New Password', fontSize: 16, fontFamily: 'medium',),
                  vSizedBox,
                  CustomTextField(
                    controller: newPasswordController,
                    hintText: 'Enter your new password here',
                    hintcolor: Colors.black,
                    obscureText: true,
                    fontsize: 13,
                  ),
                  vSizedBox2,
                  headingText(text: 'Confirm Password', fontSize: 16, fontFamily: 'medium',),
                  vSizedBox,
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Retype your new password',
                    hintcolor: Colors.black,
                    obscureText: true,
                    fontsize: 13,
                  ),
                  vSizedBox4,

                  RoundEdgedButton(text: 'UPDATE', textColor: Colors.white,
                    onTap: ()async{

                    if(oldPasswordController.text==''){
                      showSnackbar('Please Type your old password');
                    }else if(newPasswordController.text.length<6){
                      showSnackbar(MyErrorConstants.passwordTooShort);
                    }  else if(newPasswordController.text!=confirmPasswordController.text){
                      showSnackbar('Please type the same password');
                    }else{

                      setState(() {
                        load = true;
                      });
                      var request = {
                        'email': userData!['email'],
                        'old_password': oldPasswordController.text,
                        'new_password': newPasswordController.text
                      };

                      var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.changePassword, body: request, context: context, showSuccessMessage: true);
                      setState(() {
                        load = false;
                      });
                    }


                      await updateSharedPreferences(userData!['id']);
                      setState(() {
                        newPasswordController.clear();
                        oldPasswordController.clear();
                        confirmPasswordController.clear();

                        load = false;
                      });

                    },
                  ),
                  vSizedBox2,
                ],
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
