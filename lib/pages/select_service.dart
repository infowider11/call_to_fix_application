import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/pages/search_result.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Select_Service_Page extends StatefulWidget {
  static const String id="Select_Service_Page";
  final String? categoryId;
  final String? subCategoryId;

   Select_Service_Page({Key? key , this.categoryId,this.subCategoryId}) : super(key: key);

  @override
  State<Select_Service_Page> createState() => _Select_Service_PageState();
}

class _Select_Service_PageState extends State<Select_Service_Page> {
  @override
  void initState() {
    // TODO: implement initState
    print("onnnnnn"+widget.subCategoryId.toString());
    print("onnnnnn"+widget.categoryId.toString());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFFF1F4F8),
            Color(0xFFF1F4F8).withOpacity(0.5),
          ],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: appBar(context: context, title: 'Air Conditioner'),
        body: SingleChildScrollView(
          child: Container(
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
            padding: pad_horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox8,
                vSizedBox2,
                headingText(text: 'Ac service', fontSize: 25,),
                ParagraphText(text: 'Select your preferred service', color: MyColors.textcolor, fontSize: 16,),
                vSizedBox2,
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  searchResultPage(categoryId:widget.categoryId,subCategoryId:widget.subCategoryId,serviceType:"1")),

                      // MaterialPageRoute(builder: (context) =>  Provider_list_page(categoryId:widget.categoryId,subCategoryId:widget.subCategoryId,serviceType:"1")),
                    );
                    // this.categoryId,this.subCategoryId,this.serviceType
                    // Navigator.pushNamed(context, Provider_list_page.id);
                  },
                  child: StaffList(
                      text: 'Instent Video Consult',
                      subtext: 'Free',
                      popup: true,
                      horizontalpadding: 0,
                      color: Color(0xFF2C3A4B).withOpacity(0.50),
                      fontSize: 12,
                      fontFamily: 'regular',
                      image: MyImages.video_circle_icon,
                      heightimg: 50,
                      widthimg: 50,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Provider_list_page(categoryId:widget.categoryId,subCategoryId:widget.subCategoryId,serviceType:"2")),
                    );
                  },
                  child: StaffList(
                      text: 'In-Person Visit',
                      subtext: '\$200 onwords',
                      popup: true,
                      horizontalpadding: 0,
                      color: Color(0xFF2C3A4B).withOpacity(0.50),
                      fontSize: 12,
                      fontFamily: 'regular',
                      image: MyImages.user_icon_circle,
                      heightimg: 50,
                      widthimg: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
