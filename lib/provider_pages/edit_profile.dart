import 'dart:developer';

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


class Edit_Profile_Page extends StatefulWidget {
  static const String id="Edit_Profile_Page";
  const Edit_Profile_Page({Key? key}) : super(key: key);

  @override
  State<Edit_Profile_Page> createState() => _Edit_Profile_PageState();
}

class _Edit_Profile_PageState extends State<Edit_Profile_Page> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  Map? workCategory;
  Map? workInformation;
  Map? city;
 Map? selectedSourceOfIncome;
 bool load = false;

  initializeValues()async{
    log(userData.toString());
    nameController.text = userData!['full_name'];
    aboutController.text = userData!['about'];
    workCategory = userData!['work_category'];

    print('the work category is ${workCategory}');

    sourcesOfIncomeList.forEach((element) {
      if(element['id']==userData!['source_of_income']['id']){
        selectedSourceOfIncome = element;
        print('the data is ${userData!['source_of_income']}');
        setState(() {

        });
      }

    });

    print('the data is ${userData!['source_of_income']}');
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeValues();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Edit Profile', appBarColor: MyColors.appbarcolor),
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
                       headingText(text: 'Full Name', fontSize: 16, fontFamily: 'medium',),
                       vSizedBox,
                       CustomTextField(
                         controller: nameController,
                         hintText: 'Enter your name here',
                         hintcolor: Colors.black,
                         fontsize: 13,
                       ),
                       vSizedBox2,
                       // headingText(text: 'Username', fontSize: 16, fontFamily: 'medium',),
                       // vSizedBox,
                       // CustomTextField(
                       //   controller: usernameController,
                       //   hintText: 'Enter your username here',
                       //   hintcolor: Colors.black,
                       //   fontsize: 13,
                       // ),
                       // vSizedBox2,
                       // headingText(text: 'What work do you do?', fontSize: 16, fontFamily: 'medium',),
                       // vSizedBox,
                       // GestureDetector(
                       //   onTap: ()async{
                       //     FocusScope.of(context).requestFocus(new FocusNode());
                       //     // Navigator.pushNamed(context, Select_Profession_Page.id);
                       //     Map? tempRequest = await push(context: context, screen: Select_Profession_Page(workCategory: workCategory,));
                       //     print('the ruuuuuuuuu is ');
                       //
                       //     if(tempRequest!=null){
                       //       workInformation = tempRequest;
                       //       setState(() {
                       //
                       //       });
                       //     }
                       //   },
                       //   child: Container(
                       //     height: 50,
                       //     padding: EdgeInsets.all(16),
                       //     decoration: BoxDecoration(
                       //       borderRadius: BorderRadius.circular(15),
                       //       color: Colors.white,
                       //       boxShadow: [
                       //         boxShadow
                       //       ]
                       //     ),
                       //     child: Row(
                       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //       children: [
                       //         // Flexible(
                       //         //     child:
                       //         //     workInformation!=null?ParagraphText(text: '${workInformation!['category']['title']}'):
                       //         //     ParagraphText(text: '${userData!['work_category']['title']}',fontSize: 13, color: Colors.black,),
                       //         // ),
                       //         Flexible(
                       //             child: Image.asset(MyImages.arrow_down, height: 20,)
                       //         ),
                       //       ],
                       //     )
                       //   ),
                       // ),
                       // vSizedBox2,
                       headingText(text: 'Source of income', fontSize: 16, fontFamily: 'medium',),
                       vSizedBox,
                       Container(
                         height: 160,
                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white,
                               boxShadow: [
                                 boxShadow
                               ]
                           ),
                           child: SingleChildScrollView(
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
                             ),
                           )
                       ),
                       // GestureDetector(
                       //   onTap: (){
                       //
                       //     // Navigator.pushNamed(context, Select_City_Page.id);
                       //   },
                       //   child: Container(
                       //       height: 50,
                       //       padding: EdgeInsets.all(16),
                       //       decoration: BoxDecoration(
                       //           borderRadius: BorderRadius.circular(15),
                       //           color: Colors.white,
                       //           boxShadow: [
                       //             boxShadow
                       //           ]
                       //       ),
                       //       child: Row(
                       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //         children: [
                       //           Flexible(
                       //             child: ParagraphText(text: 'Spare part shop',fontSize: 13, color: Colors.black,),
                       //           ),
                       //           Flexible(
                       //               child: Image.asset(MyImages.arrow_down, height: 20,)
                       //           ),
                       //         ],
                       //       )
                       //   ),
                       // ),
                       vSizedBox2,
                       headingText(text: 'Select your city', fontSize: 16, fontFamily: 'medium',),
                       vSizedBox,
                       GestureDetector(
                         onTap: ()async{
                           FocusScope.of(context).requestFocus(new FocusNode());
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
                                   ParagraphText(text: '${userData!['city']['name']}',fontSize: 13, color: Colors.black,),
                                 ),
                                 Flexible(
                                     child: Image.asset(MyImages.arrow_down, height: 20,)
                                 ),
                               ],
                             )
                         ),
                       ),
                       vSizedBox2,
                       headingText(text: 'About Us', fontSize: 16, fontFamily: 'medium',),
                       vSizedBox,
                       CustomTextField(
                          // maxlength: 10,
                         // maxLines: 5,
                         // expand: true,
                         controller: aboutController,
                         hintText: 'About Us....',
                         hintcolor: Colors.black,
                         fontsize: 13,
                       ),
                       vSizedBox2,
                       // headingText(text: 'Change Working Hours', fontSize: 16, fontFamily: 'medium',),
                       // vSizedBox,
                       // GestureDetector(
                       //   onTap: (){
                       //     // Navigator.pushNamed(context, Select_City_Page.id);
                       //   },
                       //   child: Container(
                       //       height: 50,
                       //       padding: EdgeInsets.all(16),
                       //       decoration: BoxDecoration(
                       //           borderRadius: BorderRadius.circular(15),
                       //           color: Colors.white,
                       //           boxShadow: [
                       //             boxShadow
                       //           ]
                       //       ),
                       //       child: Row(
                       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //         children: [
                       //           Flexible(
                       //             child: ParagraphText(text: '4 hours',fontSize: 13, color: Colors.black,),
                       //           ),
                       //           Flexible(
                       //               child: Image.asset(MyImages.arrow_down, height: 20,)
                       //           ),
                       //         ],
                       //       )
                       //   ),
                       // ),
                       // vSizedBox2,
                       RoundEdgedButton(text: 'UPDATE', textColor: Colors.white,
                       onTap: ()async{
                         FocusScope.of(context).requestFocus(new FocusNode());
                         Map request = {
                           "user_id": userData!['id'],
                           // "user_name": usernameController.text,
                           // "full_name": nameController.text,
                           // "city": city!['id'],
                           // "phone_code": widget.request['phone_code'],
                           // "phone_number": widget.request['phone_number'],
                           // "password": passwordController.text,
                           // "user_type": '2',
                         };
                         // if(usernameController.text!=''){
                         //   request['user_name'] = usernameController.text;
                         // }
                         if(nameController.text!=''){
                           request['full_name'] = nameController.text;
                         }
                         if(aboutController.text!=''){
                          request['about']=aboutController.text;
                         }

                         if(workInformation!=null){
                           request.addAll(workInformation!);
                           request.remove('category');
                         }
                         if(city!=null){
                           request['city'] = city!['id'];
                         }

                         if(selectedSourceOfIncome!=null){
                           request['source_of_income'] = selectedSourceOfIncome!['id'];
                         }
                         setState(() {
                           load = true;
                         });

                         await Webservices.postData(apiUrl: ApiUrls.editProfile, body: request, context: context);
                         await updateSharedPreferences(userData!['id']);
                         setState(() {
                           showSnackbar('Profile Updated!');
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
