import 'dart:convert';
import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/pages/pending_screen_provider.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/pages/welcome.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/firebase_push_notifications.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/image_urls.dart';
import '../provider_pages/provider_otppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/category.dart';

class SplashScreenPage extends StatefulWidget {
  static const String id="splash";
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

initializeData()async{
  CatList=await Webservices.getList(ApiUrls.getProfessions);
  Map <String ,dynamic>request={
    "is_featured":"1"
  };
  sixCatList=await Webservices.getListFromRequestParameters(ApiUrls.getProfessions, request);
  bannerList=await Webservices.getList(ApiUrls.bannerList);
  log(CatList.toString());
}
  navigateToSpecificPage()async{
    await initializeData();
    sharedPreferences = await SharedPreferences.getInstance();


    if (sharedPreferences.getString('user_data') != null) {
      print("-------1---------${sharedPreferences.getString('user_data')}");
      userData = jsonDecode(sharedPreferences.getString('user_data')!);
      String? token = await FirebasePushNotifications.getToken();
      if(token!=null){
        await Webservices.updateDeviceToken(userId: userData!['id'], token: token);
      }

      if (userData!['user_type'].toString() == '1') {
        currentUserType = UserType.user;
      } else if (userData!['user_type'].toString() == '2') {
        currentUserType = UserType.provider;
      }
    }
    else{
      Navigator.pushReplacementNamed(context, WelcomePage.id);
    }
    cities = await Webservices.getList(ApiUrls.getCities);
    professions = await Webservices.getList(ApiUrls.getProfessions);
    sourcesOfIncomeList = await Webservices.getList(ApiUrls.getSourcesOfIncome);
    try{
      print("-------2---------");
      if(currentUserType==UserType.provider) {
        if (sharedPreferences.getString('user_data') != null) {
          userData = jsonDecode(sharedPreferences.getString('user_data')!);
          if (userData != null)
            await updateSharedPreferences(userData!['id']);

          if (userData!['driving_license'] == '') {
            print('Driving license is pending');
            pushReplacement(context: context, screen: About_Work_Page());
          }
          else if (userData!['approved_by_admin'].toString() == '1') {
            pushReplacement(context: context, screen: Tabs_Provider_Page());
          } else {
            print('Inside elseeee $userData');
            pushReplacement(context: context, screen: PendingScreen());
          }
        }
        else {
          print('the shared preference is null');
          Navigator.pushReplacementNamed(context, WelcomePage.id);
        }
      }
      else if(currentUserType==UserType.user){
        // if (sharedPreferences.getString('user_data') != null) {
        //   userData = jsonDecode(sharedPreferences.getString('user_data')!);
          if (userData != null)
            await updateSharedPreferences(userData!['id']);
          print("-------3---------");

          if (sharedPreferences.getString('user_data') != null) {
            print("-------4---------");

            await Navigator.of(context)
                .pushNamedAndRemoveUntil(
                TabsPage.id, (Route<dynamic> route) => false);
          }
        }
        else{
          Navigator.pushReplacementNamed(context, WelcomePage.id);
        }

      // }
    }catch(e){
      print('Error in catch block navigation 11');
      Navigator.pushReplacementNamed(context, WelcomePage.id);
    }

  }

  @override
  void initState() {
    super.initState();

    navigateToSpecificPage();
    // Future.delayed(const Duration(seconds: 3)).then((value){
    //   Navigator.pushNamed(context, WelcomePage.id);
    // });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.leaf_top),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(MyImages.leaf_bottom),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomLeft
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(MyImages.logo, height: 157,fit: BoxFit.fitHeight,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
