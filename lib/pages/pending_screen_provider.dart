import 'dart:async';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/pages/welcome.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:flutter/material.dart';

class PendingScreen extends StatefulWidget {
  final bool? is_provider;
  const PendingScreen({Key? key,this.is_provider}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {

  Timer? timer;
  checkStatus()async{
   try{
     timer =  Timer.periodic(Duration(seconds: 3), (timer) {
       Webservices.getMap(ApiUrls.get_verification_status + userData!['id'],).then((value)async{
         print('the status is ${value} and ${value['status']==1}');
         if(value['status']==1){
           if(widget.is_provider==false&&value['email_verified'].toString()=='1'){
             // user part
             updateSharedPreferences(userData!['id']);
             pushReplacement(context: context, screen: TabsPage());
             timer.cancel();
           } else if(value['email_verified'].toString()=='1'&&value['approved_by_admin'].toString()=='1') {
             // provider part
             updateSharedPreferences(userData!['id']);
             pushReplacement(context: context, screen: Tabs_Provider_Page());
             timer.cancel();
           }
         }
         if(value['status']==2){
           await logout();
           pushReplacement(context: context, screen: WelcomePage());
           timer.cancel();
         }
       });
     });
   }catch(e){
     print('Error in catch block 232 $e');
     pushReplacement(context: context, screen: WelcomePage());
   }
  }
  @override
  void initState() {
    // TODO: implement initState

    checkStatus();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    if(timer!=null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          color: MyColors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // vSizedBox4
              MainHeadingText(text: 'Thankyou!', color: Colors.white,),
              vSizedBox2,
              ParagraphText(text: 'Your profile have been submitted successfully.', color: Colors.white,),
              ParagraphText(text: 'It is under review and generally takes 3-4 business days.', color: Colors.white,),
              vSizedBox2,
              RoundEdgedButton(
                isSolid: false,
                horizontalMargin: 40,
                text: 'Logout',
                  onTap: (){
                    sharedPreferences.clear();
                    pushReplacement(context: context, screen: WelcomePage());
                  },
              )
            ],
          )
        ),
      ),
    );
  }
}
