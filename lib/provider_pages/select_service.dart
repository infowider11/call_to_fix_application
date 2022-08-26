import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/avatar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../widgets/appbar.dart';

enum SingingCharacter { one, two, three, four, five, six, seven, }

class Select_Services_Page extends StatefulWidget {
  static const String id="Select_Services_Page";
  final List service ;
  final List selectedSubCategories;
  Select_Services_Page({Key? key,required this.service,required this.selectedSubCategories}) : super(key: key);

  @override
  State<Select_Services_Page> createState() => _Select_Services_PageState();
}

class _Select_Services_PageState extends State<Select_Services_Page> {
  TextEditingController namecontroller = TextEditingController();

  // bool isChecked = false;
  // bool isChecked1 = false;
  // bool isChecked2 = false;
  // bool isChecked3 = false;
  // bool isChecked4 = false;
  // bool isChecked5 = false;

  List selectedValues = [];

  @override
  void initState() {
    print("subCategories subCategories"+widget.service.toString());
    // TODO: implement initState
    try{
      selectedValues = widget.selectedSubCategories;
      print('the selected values are $selectedValues');
      print('all values ${widget.service}');


      widget.service.forEach((element) {
        for(int i=0;i<widget.selectedSubCategories.length;i++){
          if(element['id']==widget.selectedSubCategories[i]['id']){
            print('value updated');
            widget.selectedSubCategories[i] = element;
          }
        }
      });
    }catch(e){
      print('error in catch block 33 $e');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: 'Select Services', appBarColor: MyColors.appbarcolor),
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
                  vSizedBox2,

                  if(widget.service.length==0)
                    Center(
                      child: ParagraphText(text:'No Sub Service Found'),
                    ),
                  if(widget.service.length>0)
                  for(int i = 0;i<widget.service.length;i++)
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
                                  // CustomCircularImage(imageUrl: widget.subCategories[i]['cat_icon']),
                                  Flexible(
                                    child: ParagraphText(
                                      // text: "fgh",
                                      text: '${widget.service[i]['title']}',
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
                              child:  Checkbox(
                                visualDensity: VisualDensity(vertical: 0),
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.all(MyColors.primaryColor),
                                value: selectedValues.contains(widget.service[i]),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if(selectedValues.contains(widget.service[i])){
                                      selectedValues.remove(widget.service[i]);
                                    }else{
                                      selectedValues.add(widget.service[i]);
                                    }
                                    setState(() {

                                    });
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
                  //                 child: ParagraphText(
                  //                   text: 'Gas Feeling',
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
                  //           child:  Checkbox(
                  //             checkColor: Colors.white,
                  //             fillColor: MaterialStateProperty.resolveWith(getColor),
                  //             value: isChecked1,
                  //             onChanged: (bool? value) {
                  //               setState(() {
                  //                 isChecked1 = value!;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),
                  // vSizedBox,
                  vSizedBox4,

                  vSizedBox6
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RoundEdgedButton(text: 'CONTINUE', textColor: Colors.white,
                onTap: (){
                  Navigator.pop(context, );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

// {id: 6, title: test, cat_icon: https://www.webwiders.com/WEB01/Call-Tofix/assets/cat_icon/3589286291653307248.jpg, parent: 1}
// {id: 6, title: test, cat_icon: https://www.webwiders.com/WEB01/Call-Tofix/assets/cat_icon/3589286291653307248.jpg, parent: 1}