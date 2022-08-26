import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../widgets/appbar.dart';


class Select_City_Page extends StatefulWidget {
  static const String id="Select_City_Page";
  final Map? selectedCity;
  const Select_City_Page({Key? key, required this.selectedCity}) : super(key: key);

  @override
  State<Select_City_Page> createState() => _Select_City_PageState();
}

class _Select_City_PageState extends State<Select_City_Page> {
  TextEditingController namecontroller = TextEditingController();


  Map? selectedCity;


  initializeCity()async{
    selectedCity = widget.selectedCity;
    print('the selected city is $selectedCity');
    print('the cities are $cities');
    cities.forEach((element) {
      if(element['id']==selectedCity!['id']){
        print('hello');
        selectedCity = element;
        print(element);
      }
      else{
        print('hi $element');
      }
    });
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeCity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Personal Informations', appBarColor: MyColors.appbarcolor),
      body: Container(
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
              headingText(text: 'Where do you live?', fontSize: 20, fontFamily: 'medium',),
              ParagraphText(text: 'Select your City', fontFamily: 'regular',fontSize: 16, color: MyColors.textcolor,),
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
                      for(int i = 0;i<cities.length;i++)
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
                                        text: '${cities[i]['name']}',
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
                                  child:  Radio<Map>(
                                    value: cities[i],
                                    groupValue: selectedCity,
                                    onChanged: (Map? value) {
                                      setState(() {
                                        selectedCity = value;
                                      });
                                      Navigator.pop(context, selectedCity);
                                    },
                                  ),
                              ),
                            ],
                          ),
                          if(i!=cities.length-1)
                          Divider(color: MyColors.textcolor,height: 5,)
                        ],
                      ),

                    ],
                  )
              ),
              vSizedBox6
            ],
          ),
        ),
      ),
    );
  }
}
