import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/pages/search_result.dart';
import 'package:calltofix/pages/select_service.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constans.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';

class Category_Page extends StatefulWidget {
  static const String id="Category_Page";
  final String categoryId;
  const Category_Page({Key? key,required this.categoryId}) : super(key: key);

  @override
  State<Category_Page> createState() => _Category_PageState();
}


class _Category_PageState extends State<Category_Page> {
  List subCategory=[];
  bool load=false;
  @override
  void initState() {
    // TODO: implement initState
    print("categoryy iddd"+widget.categoryId.toString());
    subcategory();
    super.initState();
  }
  subcategory()async{
    Map<String , dynamic>request={
      "category_id":widget.categoryId
    };
    setState(() {
      load = true;
    });
    subCategory=await Webservices.getListFromRequestParameters(ApiUrls.get_sub_catagory_list, request);
    print("subCategorysubCategory"+subCategory.toString());
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Colors.g,
        // extendBodyBehindAppBar: true,
        appBar: appBar(context: context, title: 'Appliance Services',appBarColor: Color(0xFFF1F4F8),
        actions: [
          IconButton(onPressed: (){},
              icon: Image.asset(MyImages.Notification, width: 17,)
          )
        ]
        ),
        body:load?CustomLoader():Container(
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

          child: subCategory.length==0?
          Center(

          child:Text('No Sub Category Found'),):GridView.count(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            clipBehavior: Clip.none,
            childAspectRatio: 1.1,
            padding: EdgeInsets.symmetric(vertical: 16),

            children: [





              for (var i = 0; i < subCategory.length; i++)
              GestureDetector(
                onTap: (){
                  print("onnnnnn"+subCategory[i]['id'].toString());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>
                  //       Select_Service_Page(categoryId:widget.categoryId,subCategoryId:subCategory[i]['id'])),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        searchResultPage(categoryId:widget.categoryId,subCategoryId:subCategory[i]['id'])),
                  );
                   // Navigator.pushNamed(context, Select_Service_Page.id);
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
                        child: Image.network(
                         subCategory[i]['cat_icon'],
                          width: MediaQuery.of(context).size.width,
                          height: 108,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        child: ParagraphText(
                          text: subCategory[i]['title'],
                          fontSize: 12,
                          textAlign: TextAlign.center, fontFamily: 'medium',
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
