import 'dart:convert';

import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/pages/package_detail.dart';
import 'package:calltofix/pages/service_detail.dart';
import 'package:calltofix/pages/service_provider_detail_page.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/buttons.dart';
import '../widgets/customLoader.dart';
import '../widgets/custom_circular_image.dart';
import '../widgets/lists.dart';
import 'package:http/http.dart' as http;

import 'notification_page.dart';
import 'package:badges/badges.dart';

enum SingingCharacter { lafayette, jefferson}

class Provider_Detail_Page extends StatefulWidget {
  static const String id="Provider_Detail_Page";
  final String providerId;
   Provider_Detail_Page({Key? key ,required this.providerId}) : super(key: key);

  @override
  State<Provider_Detail_Page> createState() => _Provider_Detail_PageState();
}

class _Provider_Detail_PageState extends State<Provider_Detail_Page> {
  List? serviceList=[];
  Map provider_info={};

  bool load=false;
  getServiceList(String id)async{
    Map<String,dynamic>request={
      'user_id':id,
    };

    serviceList = await Webservices.getListFromRequestParameters(ApiUrls.serviceList, request);

    print("service list ---------44444"+serviceList.toString());
    setState(() {

    });
  }
  get_provider_info(String id)async{
    setState(() {
      load = true;
    });
    // Map<String,dynamic>request={
    //   'user_id':id,
    // };
    http.Response response =
    await Webservices.getData(ApiUrls.getUserDetails + id);
    setState(() {
      load = false;
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      provider_info=jsonResponse['data'];
      setState(() {

      });
      print('provider info---$provider_info');
    }
  }

  void initState(){
    get_provider_info(widget.providerId);
    getServiceList(widget.providerId);
  }

  TextEditingController house = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          implyLeading: false,
          context: context,
          title: 'Detail',
          appBarColor: MyColors.appbarcolor,
          leading: IconButton(
            visualDensity: VisualDensity(horizontal: -4),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                visualDensity: VisualDensity(horizontal: 0),
                onPressed: () {
                  Navigator.pushNamed(context, Notification_page.id);
                },
                padding: EdgeInsets.all(0),
                icon: Image.asset(
                  MyImages.Notification,
                  width: 17,
                )),
          ]),
      backgroundColor: Colors.white,
      body:load?CustomLoader(): SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            vSizedBox4,
            Transform.translate(
              offset: Offset(0,-40),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                // height: MediaQuery.of(context).size.height - 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 14,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            CustomCircularImage(
                                              imageUrl: provider_info['image'],
                                              height: 95,
                                              width: 95,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: ParagraphText(text: '${provider_info['full_name']}',
                                                fontSize: 14,
                                                fontFamily: 'medium',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(MyImages.Location, height: 15,),
                                                  SizedBox(width: 5,),
                                                  ParagraphText(text: '${provider_info['city']['name']}',fontSize: 12,
                                                    fontFamily: 'medium', color: MyColors.subtext,),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: MyColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star_rounded, color: Colors.white, size: 15,
                                                    ),
                                                    px2,
                                                    ParagraphText(text:'${provider_info['avg_rate']}(${provider_info['avg_rate_count']})',color: Colors.white, fontSize: 10,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      thickness: 0.1,
                      color: MyColors.textcolor,
                    ),
                    vSizedBox,
                    headingText(text:'Personal Details',fontSize: 18,),
                    vSizedBox,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            boxShadow
                          ]
                      ),
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSizedBox2,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          headingText(text: 'Mobile no.', fontSize: 15, fontFamily: 'semibold',),
                                          ParagraphText(text: '${provider_info['phone_with_code']}',
                                            color: MyColors.textcolor,fontSize: 9,),
                                          vSizedBox,
                                        ]
                                    )
                                ),
                                Expanded(
                                  flex: 1,
                                  // child: Image.asset(MyImages.edit, height: 15,)
                                  child: vSizedBox,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            color: MyColors.textcolor.withOpacity(0.5),
                          ),
                          vSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          headingText(text: 'About Us', fontSize: 15, fontFamily: 'semibold',),
                                          ParagraphText(text: '${provider_info['about']}',
                                            color: MyColors.textcolor,fontSize: 9,),
                                          vSizedBox,
                                        ]
                                    )
                                ),
                                Expanded(
                                  flex: 1,
                                  // child: Image.asset(MyImages.edit, height: 15,)
                                  child: vSizedBox,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            color: MyColors.textcolor.withOpacity(0.5),
                          ),
                          vSizedBox,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          headingText(text: 'City', fontSize: 15, fontFamily: 'semibold',),
                                          ParagraphText(text: '${provider_info['city']['name']}',
                                            color: MyColors.textcolor,fontSize: 9,),
                                          vSizedBox,
                                        ]
                                    )
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   // child: Image.asset(MyImages.edit, height: 15,)
                                //   child: vSizedBox,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox2,
                    headingText(text: 'Skill\s',fontSize: 18,),
                    vSizedBox2,
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for(int i=0;i<provider_info['skills'].length;i++)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: MyColors.primaryColor,
                                onPrimary: Colors.white,
                                shadowColor: MyColors.primaryColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: Size(100, 40), //////// HERE
                              ),
                              onPressed: () {},
                              child: Text('${provider_info['skills'][i]['title']}'),
                            ),
                          if(provider_info['skills'].length==0)
                          Center(
                            child: new Text('No data found'),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox2,
                    headingText(text: 'Certificates',fontSize: 18,),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:provider_info['profession_certificate']==''?Center(child: ParagraphText(text: 'No Training Certificate Uploaded',),): Image.network(
                        provider_info['profession_certificate'],
                        width: 200,
                      ),
                    ),
                    vSizedBox2,
                    headingText(text: 'Services', fontSize: 18,),
                    // vSizedBox,
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i=0; i< serviceList!.length; i++)
                            GestureDetector(
                              onTap: () async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => (
                                    Service_detail(service_id: serviceList![i]['id'],)
                                )));
                                print('working---');
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 32,
                                height: 100,
                                // margin: EdgeInsets.only(left:0,top:0,right:0,bottom: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      boxShadow
                                    ]
                                ),

                                child:
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomCircularImage(
                                      imageUrl:serviceList![i]!['cover_image'],
                                      fileType:CustomFileType.network,
                                      // imageUrl: MyImages.plumb,
                                      height: 55,
                                      width: 55,
                                    ),
                                    hSizedBox,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ParagraphText(
                                          // text:'ttle',
                                          text: serviceList![i]['title']==''?serviceList![i]['category_data']['title'] :serviceList![i]['title'],
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'semibold',
                                        ),
                                        ParagraphText(
                                          // text:'description hjh',

                                          text: serviceList![i]['description'],
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: 'regular',
                                        ),
                                        py3,
                                        ParagraphText(
                                          // text: '\$200',
                                          text: '\$'+serviceList![i]['service_fee'],
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'semibold',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            ),
                        ],
                      ),
                    ),

                    headingText(text: 'Packages', fontSize: 18,),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i=0; i< provider_info['packages'].length; i++)
                            GestureDetector (
                              onTap: () async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => (
                                    Package_detail(package_id:  provider_info['packages']![i]['id'],))));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 32,
                                height: 100,
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
                                          Flexible(
                                              child: CustomCircularImage(
                                                imageUrl:provider_info['packages'][i]!['cover_image'],
                                                fileType:CustomFileType.network,
                                                // imageUrl: MyImages.plumb,
                                                height: 55,
                                                width: 55,
                                              )
                                          ),
                                          hSizedBox,
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ParagraphText(
                                                  // text:'ttle',
                                                  text: provider_info['packages'][i]['title']==''?provider_info['packages']![i]['category_data']['title'] :provider_info['packages']![i]['title'],
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontFamily: 'semibold',
                                                ),
                                                ParagraphText(
                                                  // text:'description hjh',

                                                  text: provider_info['packages']![i]['description'],
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontFamily: 'regular',
                                                ),
                                                py3,
                                                ParagraphText(
                                                  // text: '\$200',
                                                  text: '\$'+provider_info['packages']![i]['service_fee'],
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'semibold',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Expanded(
                                    //     flex: 2,
                                    //     child: RoundEdgedButton(
                                    //       textColor: Colors.white,
                                    //       text: 'Edit',
                                    //       verticalPadding: 0,
                                    //       horizontalPadding: 0,
                                    //       height: 20,
                                    //       fontSize: 10,
                                    //       letterspace: 0,
                                    //       borderRadius: 5,
                                    //       onTap: () async {
                                    //         print("dataaaa----"+serviceList![i].toString());
                                    //         await Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(builder: (context) =>  Edit_Service_Page(data: serviceList![i])),
                                    //
                                    //         );
                                    //         setState(() async {
                                    //           await getServiceList();
                                    //         });
                                    //
                                    //
                                    //         // Navigator.pushNamed(context, Edit_Service_Page.id);
                                    //       },
                                    //     )
                                    //
                                    // ),
                                    // hSizedBox,
                                    // if(serviceList![i]['is_first'].toString()!="1")
                                    //   Expanded(
                                    //       flex: 2,
                                    //       child: RoundEdgedButton(
                                    //         textColor: Colors.white,
                                    //         text: 'Delete',
                                    //         verticalPadding: 0,
                                    //         horizontalPadding: 0,
                                    //         height: 20,
                                    //         fontSize: 10,
                                    //         letterspace: 0,
                                    //         borderRadius: 5,
                                    //         onTap: (){
                                    //           _showMyDialog(serviceList![i]['id']);
                                    //           // print("dataaaa----"+serviceList![i].toString());
                                    //           // Navigator.push(
                                    //           //   context,
                                    //           //   MaterialPageRoute(builder: (context) =>  Edit_Service_Page(data: serviceList![i])),
                                    //           // );
                                    //           // Navigator.pushNamed(context, Edit_Service_Page.id);
                                    //         },
                                    //       )
                                    //
                                    //   ),
                                  ],
                                ),

                              ),
                            ),
                          if(provider_info['packages'].length==0)
                            Center(
                              child: new Text('No data found.'),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
