import 'package:calltofix/constants/error_constants.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/pages/privacy.dart';
import 'package:calltofix/pages/terms.dart';
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../widgets/appbar.dart';


class Personal_Information_Page extends StatefulWidget {
  static const String id="Personal_Information_Page";
  final Map<String, dynamic> request;
  const Personal_Information_Page({Key? key, required this.request}) : super(key: key);

  @override
  State<Personal_Information_Page> createState() => _Personal_Information_PageState();
}

class _Personal_Information_PageState extends State<Personal_Information_Page> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Map? workCategory;
  List workSubCategories = [];
  String? workingHours;
  String? serviceFees;
  String? videoConsultFee;


  Map? city;
  String? work;

  Map? workInformation;


  bool isChecked = false;
  bool load = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Personal Information', appBarColor: MyColors.appbarcolor),
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
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16,top: 0,right: 16,bottom: 50),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         headingText(text: 'Tell us about yourself!', fontSize: 20, fontFamily: 'medium',),
                         ParagraphText(text: 'Enter your details', fontFamily: 'regular',fontSize: 16,),
                         vSizedBox4,
                         headingText(text: 'Full Name', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         CustomTextField(controller: namecontroller, hintText: 'Type your full name here'),
                         vSizedBox2,
                         headingText(text: 'Email', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         CustomTextField(controller: emailController, hintText: 'Type your email here'),
                         vSizedBox2,
                         headingText(text: 'Username', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         CustomTextField(controller: usernameController, hintText: 'Type your username here'),
                         vSizedBox2,
                         headingText(text: 'Password', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         CustomTextField(controller: passwordController, hintText: 'Type your password here', obscureText: true,),
                         vSizedBox2,
                         headingText(text: 'What work do you do?', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         GestureDetector(
                           onTap: ()async{
                             FocusScope.of(context).requestFocus(new FocusNode());
                             // Navigator.pushNamed(context, Select_Profession_Page.id);
                             Map? tempRequest = await push(context: context, screen: Select_Profession_Page(workCategory: workCategory,));
                             print('the ruuuuuuuuu is ');

                             if(tempRequest!=null){
                               workInformation = tempRequest;
                             }
                           },
                           child: Container(
                             height: 50,
                             padding: EdgeInsets.all(16),
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
                                 Flexible(
                                     child:
                                         workInformation!=null?ParagraphText(text: '${workInformation!['category']['title']}'):
                                     ParagraphText(text: 'Select Work',fontSize: 13, color: MyColors.textcolor,),
                                 ),
                                 Flexible(
                                     child: Image.asset(MyImages.arrow_down, height: 20,)
                                 ),
                               ],
                             )
                           ),
                         ),
                         vSizedBox2,
                         headingText(text: 'Select your city', fontSize: 16, fontFamily: 'medium',),
                         vSizedBox,
                         GestureDetector(
                           onTap: ()async{
                             FocusScope.of(context).requestFocus(new FocusNode());
                             // Navigator.pushNamed(context, Select_City_Page.id);
                             Map? tempcity = await push(context: context, screen: Select_City_Page(selectedCity: city));
                             print('the selected city is $tempcity');
                             if(tempcity!=null){
                               city = tempcity;
                               setState(() {

                               });
                             }

                           },
                           child: Container(
                               height: 50,
                               padding: EdgeInsets.all(16),
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
                                   Flexible(
                                     child:
                                     city!=null? ParagraphText(text: city!['name']):
                                     ParagraphText(text: 'Select City',fontSize: 13, color: MyColors.textcolor,),
                                   ),
                                   Flexible(
                                       child: Image.asset(MyImages.arrow_down, height: 20,)
                                   ),
                                 ],
                               )
                           ),
                         ),

                         vSizedBox4,
                         Row(
                           children: [
                             Expanded(
                                 flex: 1,
                                 child: Checkbox(
                                   checkColor: Colors.white,
                                   fillColor: MaterialStateProperty.all(MyColors.primaryColor),
                                   value: isChecked,
                                   onChanged: (bool? value) {
                                     setState(() {
                                       isChecked = value!;
                                     });
                                   },
                                 )
                             ),
                             Expanded(
                               flex: 7,
                               child: RichText(
                                 text: TextSpan(
                                   text: 'By proceeding, you agree to our \n',
                                   style: TextStyle(
                                       color: MyColors.textcolor,
                                       fontSize: 14,
                                       height: 1.5
                                   ),
                                   children:  <TextSpan>[
                                     TextSpan(text: 'Terms & Conditions', style: TextStyle(fontFamily: 'regular', color: MyColors.primaryColor), recognizer: TapGestureRecognizer()..onTap = (){
                                       FocusScope.of(context).requestFocus(new FocusNode());
                                       push(context: context, screen: Terms_Page());
                                     }),
                                     TextSpan(text: ' and ', style: TextStyle(fontFamily: 'regular',)),
                                     TextSpan(text: 'privacy policy', style: TextStyle(fontFamily: 'regular', color: MyColors.primaryColor), recognizer: TapGestureRecognizer()..onTap = (){
                                       FocusScope.of(context).requestFocus(new FocusNode());
                                       push(context: context, screen: Privacy_Page());
                                     }),

                                   ],
                                 ),
                               ),
                             )
                           ],
                         ),
                         // vSizedBox2,

                         vSizedBox2,
                         RoundEdgedButton(text: 'CONTINUE', textColor: Colors.white,
                           onTap: ()async{
                             FocusScope.of(context).requestFocus(new FocusNode());

                             if(namecontroller.text ==''){
                               showSnackbar(MyErrorConstants.invalidName);
                             }else if (emailController.text == '') {
                               showSnackbar( 'Please Enter your email');
                             }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
                               showSnackbar(MyErrorConstants.invalidEmailAddress);
                             }else if(usernameController.text==''){
                               showSnackbar(MyErrorConstants.invalidUserName);
                             }else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(usernameController.text)){
                               showSnackbar('Username can only contain numbers and alphabets');
                             }else if(passwordController.text==''){
                               showSnackbar( 'Please type your password');
                             }else if(passwordController.text.length<6){
                               showSnackbar(MyErrorConstants.passwordTooShort);
                             }else if(workInformation==null){
                               showSnackbar('Please enter your work information');
                             }else if(city==null){
                               showSnackbar('please select your city.');
                             }else if(!isChecked){
                               showSnackbar('please accept terms and conditions');
                             }else{

                               setState(() {
                                 load =true;
                               });

                               Map request = {
                                 "full_name": namecontroller.text,
                                 "user_name": usernameController.text,
                                 "email": emailController.text,
                                 "city": city!['id'],
                                 "phone_code": widget.request['phone_code'],
                                 "phone_number": widget.request['phone_number'],
                                 "password": passwordController.text,
                                 "user_type": '2',
                               };
                               request.addAll(workInformation!);
                               request.remove('category');
                               var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.signup_step_1, body: request, context: context);
                               if(jsonResponse['status']==1){
                                 await updateSharedPreferences(jsonResponse['data']['id']);
                                 await pushReplacement(context: context, screen: About_Work_Page());
                                 setState(() {
                                   load = false;
                                 });
                                 // Navigator.pushNamed(context, About_Work_Page.id);
                               }else{
                                 setState(() {
                                   load = false;
                                 });
                               }


                             }

                           },
                         ),
                         vSizedBox4,
                         vSizedBox,
                       ],
                ),
              ),
            ),
          ),

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: EdgeInsets.all(16),
          //     child:   Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //
          //         RoundEdgedButton(text: 'CONTINUE', textColor: Colors.white,
          //           onTap: ()async{
          //           FocusScope.of(context).requestFocus(new FocusNode());
          //
          //           if(namecontroller.text ==''){
          //             showSnackbar(MyErrorConstants.invalidName);
          //           }else if (emailController.text == '') {
          //             showSnackbar( 'Please Enter your email');
          //           }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
          //             showSnackbar(MyErrorConstants.invalidEmailAddress);
          //           }else if(usernameController.text==''){
          //             showSnackbar(MyErrorConstants.invalidUserName);
          //           }else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(usernameController.text)){
          //             showSnackbar('Username can only contain numbers and alphabets');
          //           }else if(passwordController.text==''){
          //             showSnackbar( 'Please type your password');
          //           }else if(passwordController.text.length<6){
          //             showSnackbar(MyErrorConstants.passwordTooShort);
          //           }else if(workInformation==null){
          //             showSnackbar('Please enter your work information');
          //           }else if(city==null){
          //             showSnackbar('please select your city.');
          //           }else if(!isChecked){
          //             showSnackbar('please accept terms and conditions');
          //           }else{
          //
          //             setState(() {
          //               load =true;
          //             });
          //
          //             Map request = {
          //               "full_name": namecontroller.text,
          //               "user_name": usernameController.text,
          //               "email": emailController.text,
          //               "city": city!['id'],
          //               "phone_code": widget.request['phone_code'],
          //               "phone_number": widget.request['phone_number'],
          //               "password": passwordController.text,
          //               "user_type": '2',
          //             };
          //             request.addAll(workInformation!);
          //             request.remove('category');
          //             var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.signup_step_1, body: request, context: context);
          //             if(jsonResponse['status']==1){
          //               await updateSharedPreferences(jsonResponse['data']['id']);
          //               await pushReplacement(context: context, screen: About_Work_Page());
          //               setState(() {
          //                 load = false;
          //               });
          //               // Navigator.pushNamed(context, About_Work_Page.id);
          //             }else{
          //               setState(() {
          //                 load = false;
          //               });
          //             }
          //
          //
          //           }
          //
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(load)
            CustomFullPageLoader()
        ],
      ),
    );
  }
}
