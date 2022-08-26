import 'dart:developer';
import 'dart:io';

import 'package:calltofix/constants/category.dart';
import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/search_result.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/CustomTexts.dart';
import '../widgets/avatar.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  static const String id="homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> imgList= [
    // {
    //   "url":'assets/images/slider.png', },
    // {
    //   "url":'assets/images/welcome_back.png',},
    // {
    //   "url":'assets/images/slider.png', }
  ];
  int _currentIndex = 0;
  TextEditingController search = TextEditingController();

  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  bool pressAttention5 = false;
  File? image;
  @override
  void initState() {
    // TODO: implement initState
    print("usderataaaaaaaaa"+bannerList.toString());
    for (var i=0 ; i<bannerList.length ;i++){
      imgList.add({'url':bannerList[i]['image'],'link':bannerList[i]['link']});

      print("imageee"+imgList[i]['url'].toString());
    }
    // imgList=bannerList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox6,
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                              Flexible(

                                  child: Column(
                                    children: [
                                      CustomCircularImage(
                                        imageUrl: userData!['image'],

                                        height: 50,
                                        width: 50,
                                        fileType: image==null?CustomFileType.network:CustomFileType.file,
                                        fit: BoxFit.fitHeight,),
                                    ],
                                  )

                              ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ParagraphText(text: userData!['full_name'],
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
                                        ParagraphText(text:userData!['address'] ,fontSize: 12,
                                          fontFamily: 'medium', color: MyColors.subtext,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child:GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, Shop_Page.id);
                            },
                            child: Image.asset(MyImages.bag, height: 22,)
                          ),
                        ),
                      hSizedBox,
                      Flexible(
                        flex: 1,
                        child:GestureDetector(
                            onTap: (){
                              // showDialog<void>(context: context, builder: (context) => dialog1);
                              Navigator.pushNamed(context, Notification_page.id);
                            },
                            child: Image.asset(MyImages.Notification, height: 20,)
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox2,
                GestureDetector(
                  onTap: (){
                    Map data ={
                      'keyword':search.text
                    };
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => searchResultPage()),
                    // );
                    // Navigator.push(context, searchResultPage(data: data))
                  },
                  child: CustomTextField(controller: search, hintText: 'Search',
                  onSubmited: (value){
                    print('-----$value');
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => searchResultPage(search_val: search.text,)),
                        );
                  },
                    prefixIcon: MyImages.search,
                    left: 0,
                  ),
                ),
                vSizedBox2,
                // Container(
                //   height: 400,
                //   child: PageView.builder(
                //     itemCount: 3,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       return Image.asset(
                //         imgList[index]['url'],
                //         width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.fitWidth,
                //       );
                //     }),
                // ),
                if(imgList.length>0)
                Column(
                  children: [
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 168,
                          viewportFraction: 1,
                          initialPage: 0,
                          enlargeCenterPage: false,
                          disableCenter: true,
                          reverse: false,
                          enableInfiniteScroll: false,
                          // pauseAutoPlayOnTouch: Duration(seconds: 10),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            log('page changed ');
                            setState(
                                  () {
                                _currentIndex = index;
                              },
                            );
                          },
                        ),

                        items: imgList.map((img) {
                          return GestureDetector(
                            onTap: () {
                              print('link----${img['link']}');
                              _launchUrl(Uri.parse(img['link']));
                            },
                            child: Builder(
                              builder: (BuildContext context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  // child: CustomCircularImage(
                                  //
                                  //
                                  // imageUrl: img['url'],
                                  //
                                  //   height: 24,
                                  //   width: 24,
                                  //   fileType: image==null?CustomFileType.network:CustomFileType.file,
                                  //   fit: BoxFit.fitHeight,),
                                  child:Image.network(
                                    img['url'],

                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                    height: 168,
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      // height: 250,
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                        child:  AnimatedSmoothIndicator(
                          activeIndex: _currentIndex,
                          count:  bannerList.length,
                          effect: ExpandingDotsEffect(
                            // activeStrokeWidth: 2.6,
                            // activeDotScale: 1.3,
                            // maxVisibleDots: 5,
                            radius: 8,
                            spacing: 6,
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: MyColors.primaryColor,
                            dotColor: Color(0xFF8E9092),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                vSizedBox,
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: sixCatList.length,
                  clipBehavior: Clip.none,
                  children: [
                    for (var i = 0; i < sixCatList.length; i++)
                    GestureDetector(
                      onTap: ()async{
                        setState(() {
                          // pressAttention = !pressAttention;
                        });
                        await Future.delayed(Duration(milliseconds: 300));
                        print("category idd"+sixCatList[i]['id']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Category_Page(categoryId: sixCatList[i]['id'])),
                        );
                        // await Navigator.pushNamed(context, Category_Page.id);
                        setState(() {
                          // pressAttention = !pressAttention;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            // pressAttention?
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                            boxShadow:[
                              boxShadow
                            ]
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                           child:Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomCircularImage(
                                 imageUrl: sixCatList[i]['cat_icon'],
                                 height: 24,
                                 width: 24,
                                 fileType: image==null?CustomFileType.network:CustomFileType.file,
                                 fit: BoxFit.fitHeight,),
                               // Image.asset(MyImages.icon1, width: 24, height: 24, fit: BoxFit.fitHeight,),
                        // Image.network(
                            // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')
                               // Image.network( sixCatList[i]['image'], width: 24, height: 24, fit: BoxFit.fitHeight,)
                             ],
                           ),
                          ),
                          SizedBox(height: 5,),
                          ParagraphText(
                            text: sixCatList[i]['title'],
                            fontSize: 9,textAlign: TextAlign.center,
                            color: pressAttention? Colors.white: Colors.black.withOpacity(0.70),
                          )
                        ],
                      ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     setState(() {
                    //       pressAttention1 = !pressAttention1;
                    //     });
                    //     await Future.delayed(Duration(milliseconds: 300));
                    //     await Navigator.pushNamed(context, Category_Page.id);
                    //     setState(() {
                    //       pressAttention1 = !pressAttention1;
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color:pressAttention1? MyColors.primaryColor: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //         boxShadow:[
                    //           boxShadow
                    //         ]
                    //     ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         height: 48,
                    //         width: 48,
                    //         decoration: BoxDecoration(
                    //           color: pressAttention1? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //        child:Column(
                    //          crossAxisAlignment: CrossAxisAlignment.center,
                    //          mainAxisAlignment: MainAxisAlignment.center,
                    //          children: [
                    //            Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                    //          ],
                    //        ),
                    //       ),
                    //       SizedBox(height: 5,),
                    //       ParagraphText(
                    //         text: 'Appliance\nServices',
                    //         fontSize: 9,
                    //         textAlign: TextAlign.center,
                    //         color: pressAttention1? Colors.white: Colors.black.withOpacity(0.70),
                    //       )
                    //     ],
                    //   ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     setState(() {
                    //       pressAttention2 = !pressAttention2;
                    //     });
                    //     await Future.delayed(Duration(milliseconds: 300));
                    //     await Navigator.pushNamed(context, Category_Page.id);
                    //     setState(() {
                    //       pressAttention2 = !pressAttention2;
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color:pressAttention2? MyColors.primaryColor: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //         boxShadow:[
                    //           boxShadow
                    //         ]
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 48,
                    //           width: 48,
                    //           decoration: BoxDecoration(
                    //             color: pressAttention2? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           child:Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Image.asset(MyImages.icon3, width: 24, height: 24, fit: BoxFit.fitHeight,),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(height: 5,),
                    //         ParagraphText(
                    //           text: 'Digital\nMarketing',
                    //           fontSize: 9,
                    //           textAlign: TextAlign.center,
                    //           color: pressAttention2? Colors.white: Colors.black.withOpacity(0.70),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     setState(() {
                    //       pressAttention3 = !pressAttention3;
                    //     });
                    //     await Future.delayed(Duration(milliseconds: 300));
                    //     await Navigator.pushNamed(context, Category_Page.id);
                    //     setState(() {
                    //       pressAttention3 = !pressAttention3;
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color:pressAttention3? MyColors.primaryColor: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //         boxShadow:[
                    //           boxShadow
                    //         ]
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 48,
                    //           width: 48,
                    //           decoration: BoxDecoration(
                    //             color: pressAttention3? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           child:Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Image.asset(MyImages.icon4, width: 24, height: 24, fit: BoxFit.fitHeight,),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(height: 5,),
                    //         ParagraphText(
                    //           text: 'Maid\nServices',
                    //           fontSize: 9,
                    //           textAlign: TextAlign.center,
                    //           color: pressAttention3? Colors.white: Colors.black.withOpacity(0.70),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     setState(() {
                    //       pressAttention4 = !pressAttention4;
                    //     });
                    //     await Future.delayed(Duration(milliseconds: 300));
                    //     await Navigator.pushNamed(context, Category_Page.id);
                    //     setState(() {
                    //       pressAttention4 = !pressAttention4;
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color:pressAttention4? MyColors.primaryColor: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //         boxShadow:[
                    //           boxShadow
                    //         ]
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 48,
                    //           width: 48,
                    //           decoration: BoxDecoration(
                    //             color: pressAttention4? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           child:Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Image.asset(MyImages.icon5, width: 24, height: 24, fit: BoxFit.fitHeight,),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(height: 5,),
                    //         ParagraphText(
                    //           text: 'Towing\nservices',
                    //           fontSize: 9,
                    //           textAlign: TextAlign.center,
                    //           color: pressAttention4? Colors.white: Colors.black.withOpacity(0.70),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: ()async{
                    //     setState(() {
                    //       pressAttention5 = !pressAttention5;
                    //     });
                    //     await Future.delayed(Duration(milliseconds: 300));
                    //     await Navigator.pushNamed(context, Category_Page.id);
                    //     setState(() {
                    //       pressAttention5 = !pressAttention5;
                    //     });
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color:pressAttention5? MyColors.primaryColor: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       boxShadow:[
                    //         boxShadow
                    //       ]
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 48,
                    //           width: 48,
                    //           decoration: BoxDecoration(
                    //             color: pressAttention5? Colors.white.withOpacity(0.15):MyColors.primaryColor.withOpacity(0.15),
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           child:Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Image.asset(MyImages.icon2, width: 24, height: 24, fit: BoxFit.fitHeight,),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(height: 5,),
                    //         ParagraphText(
                    //           text: 'Snow\nremoval',
                    //           fontSize: 9,
                    //           textAlign: TextAlign.center,
                    //           color: pressAttention5? Colors.white: Colors.black.withOpacity(0.70),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                vSizedBox,
                headingText(text: 'More Categories', fontSize: 18, fontFamily: 'medium',),
                vSizedBox,
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.only(right: 26),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //            CircleAvatarcustom(
                      //              imageUrl: MyImages.category,
                      //              height: 50,
                      //              width: 50,
                      //              fit: BoxFit.fitHeight,
                      //            ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 5,),
                      //       ParagraphText(text: 'Basement\nRenovation',
                      //         fontSize: 9,
                      //         textAlign: TextAlign.center,
                      //         color: MyColors.subtext,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(right: 26),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //            CircleAvatarcustom(
                      //              imageUrl: MyImages.plumb,
                      //              height: 50,
                      //              width: 50,
                      //              fit: BoxFit.fitHeight,
                      //            ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 5,),
                      //       ParagraphText(text: 'Basement\nRenovation',
                      //         fontSize: 9,
                      //         textAlign: TextAlign.center,
                      //         color: MyColors.subtext,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      for (var i = 0; i < CatList.length; i++)
                      GestureDetector(
                        onTap: ()async{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Category_Page(categoryId: CatList[i]['id'])),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 26,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomCircularImage(
                                    imageUrl: CatList[i]['cat_icon'],

                                    height: 50,
                                    width: 50,
                                    fileType: image==null?CustomFileType.network:CustomFileType.file,
                                    fit: BoxFit.fitHeight,),
                                  // CircleAvatarcustom(
                                  //   imageUrl: CatList[i]['cat_icon'],
                                  //   height: 50,
                                  //   width: 50,
                                  //   fit: BoxFit.fitHeight,
                                  // ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              ParagraphText(text: CatList[i]['title'],
                                fontSize: 9,
                                textAlign: TextAlign.center,
                                color: MyColors.subtext,
                              )
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                vSizedBox4,
                vSizedBox4,
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

}

