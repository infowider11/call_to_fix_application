import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/pages/product_detail_page.dart';
import 'package:calltofix/pages/select_service.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/customtextfield.dart';

class Product_Category_Page extends StatefulWidget {
  static const String id="Product_Category_Page";
  const Product_Category_Page({Key? key}) : super(key: key);

  @override
  State<Product_Category_Page> createState() => _Product_Category_PageState();
}

class _Product_Category_PageState extends State<Product_Category_Page> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: appBar(context: context, title: 'Home Applience',appBarColor: Color(0xFFF1F4F8),
        actions: [
          IconButton(onPressed: (){},
              icon: Image.asset(MyImages.Notification, width: 17,)
          )
        ]
        ),
        body: SingleChildScrollView(
          child: Container(
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
               children: [
                 vSizedBox,
                 CustomTextField(controller: search, hintText: 'Search',
                   prefixIcon: MyImages.search,
                   left: 0,
                 ),
                 vSizedBox2,
                 GridView.count(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   crossAxisSpacing: 16,
                   mainAxisSpacing: 16,
                   crossAxisCount: 2,
                   clipBehavior: Clip.none,
                   childAspectRatio: 1.1,

                   children: [
                     for (var i = 0; i < 10; i++)
                     GestureDetector(
                       onTap: (){
                          Navigator.pushNamed(context, Product_Detail_Page.id);
                       },
                       child: Container(
                         decoration: BoxDecoration(
                             color:Colors.white,
                             borderRadius: BorderRadius.circular(15),
                             boxShadow:[
                               boxShadow
                             ]
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(15),
                               child: Image.asset(
                                 MyImages.refridgerator,
                                 width: MediaQuery.of(context).size.width,
                                 // height: 108,
                                 fit: BoxFit.fitWidth,
                               ),
                             ),
                             SizedBox(height: 5,),
                             Padding(
                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                               child: ParagraphText(
                                 text: 'Refridgerator',
                                 fontSize: 12,textAlign: TextAlign.center, fontFamily: 'medium',
                                 color: Colors.black,
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
            ),
          ),
        ),
      ),
    );
  }
}
