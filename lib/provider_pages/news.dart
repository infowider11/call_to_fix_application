import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/dummyData.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/global_functions.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/trending_news_page.dart';
import 'package:calltofix/provider_pages/news_detail.dart';
import 'package:calltofix/provider_pages/provider_notification_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../modals/news_modal.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/avatar.dart';
import 'menu_page.dart';

class News_Page extends StatefulWidget {
  static const String id="News_Page";
  const News_Page({Key? key}) : super(key: key);

  @override
  State<News_Page> createState() => _News_PageState();
}

class _News_PageState extends State<News_Page> {


  String selectedNewsCategory = newsCategory[0];


  List<NewsModal> trendingNews = [];
  List<NewsModal> recentlyAdded = [];
  List<NewsModal> jobRelatedList = [];
  bool load = false;



  List<Map<String, dynamic>> imgList= [
    {
      "url":'assets/images/slider.png', },
    {
      "url":'assets/images/welcome_back.png',},
    {
      "url":'assets/images/slider.png', }
  ];
  int _currentIndex = 0;
  TextEditingController search = TextEditingController();
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  bool pressAttention5 = false;



  getNews()async{
    setState(() {
      load = true;
    });

    trendingNews = [];
    jobRelatedList = [];
    recentlyAdded = [];
    print('Calling get news');
    List temp = [];

    for(int i = 0;i<3;i++){
      var request = {
        'news_category': (newsCategory.indexOf(selectedNewsCategory)+1).toString(),
        'news_type':'${i+1}',
      };
      temp = await Webservices.getListFromRequestParameters(ApiUrls.getNews, request);
      if(i==0) {
        temp.forEach((element) {
          trendingNews.add(NewsModal.fromJson(element));
        });
      }else if(i==1){
        temp.forEach((element) {
          recentlyAdded.add(NewsModal.fromJson(element));
        });
      }else{
        temp.forEach((element) {
          jobRelatedList.add(NewsModal.fromJson(element));
        });
      }
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
   getNews();
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
        backgroundColor: Colors.transparent,
        appBar: appBar(
          context: context,
          leading: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Menu_Page.id);
            },
            child: Icon(
              Icons.menu_outlined, color: Colors.black,
            ),
          ),
          implyLeading: false,
          title: 'News',
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, Provider_Notification_page.id);
            },
                icon: Image.asset(MyImages.Notification, width: 17,)
            )
          ]

        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.transparent,
                  height: 50.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          for(int i = 0;i<newsCategory.length;i++)
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                            child: ActionChip(
                                backgroundColor:newsCategory[i]==selectedNewsCategory? MyColors.primaryColor: MyColors.primaryColor.withOpacity(0.5),
                                labelPadding: EdgeInsets.only(left: 15, right: 15),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                label: Text(newsCategory[i], style: TextStyle(color: newsCategory[i]==selectedNewsCategory? Colors.white:Colors.black, fontSize: 11, fontFamily: 'medium' ),),
                                onPressed: () {
                                  selectedNewsCategory = newsCategory[i];
                                  getNews();

                                  // update board with selection
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 10, right: 16),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Trending', textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'medium',
                              fontSize: 17,
                            ),),
                            Text('Breaking News', textAlign: TextAlign.left, style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'regular',
                                fontSize: 13,
                            ),),
                          ],
                        ),


                      ),
                      InkWell(
                        onTap: (){
                          push(context: context, screen: TrendingNewsPage(newsCategory: (newsCategory.indexOf(selectedNewsCategory)+1).toString(),));
                        },
                        child: Text('See More', textAlign: TextAlign.left, style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 13,
                            decoration: TextDecoration.underline,

                        ),),
                      ),
                    ],
                  ),





                ),
                Container(
                  height: 130,
                  child:
                      load?CustomLoader():
                          trendingNews.length==0?Center(child: ParagraphText(text: 'No Data found',),):
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Column(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: (){
                      //         Navigator.pushNamed(context, News_Detail_Page.id);
                      //       },
                      //       child: Container(
                      //           margin: EdgeInsets.only(top: 15, left: 10),
                      //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //           width: MediaQuery.of(context).size.width - 100,
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(15),
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 boxShadow
                      //               ]
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Flexible(
                      //                   flex: 3,
                      //                   child: Stack(
                      //                     children: [
                      //                       CircleAvatarcustom(
                      //                         image: MyImages.plumb,
                      //                         bgcolor: Colors.transparent,
                      //                         height: 70,
                      //                         width: 61,
                      //                         fit: BoxFit.fitHeight,
                      //                         borderradius: 15,
                      //                       ),
                      //                       Container(
                      //                         height: 70,
                      //                         width: 61,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(15),
                      //                           color: Colors.black.withOpacity(0.3),
                      //                         ),
                      //                         child: Column(
                      //                           crossAxisAlignment: CrossAxisAlignment.center,
                      //                           mainAxisAlignment: MainAxisAlignment.center,
                      //                           children: [
                      //                             Image.asset(MyImages.Play, width: 24,height: 24,)
                      //                           ],
                      //
                      //                         ),
                      //                       )
                      //                     ],
                      //                   )
                      //               ),
                      //               hSizedBox,
                      //               Flexible(
                      //                 flex: 9,
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     Padding(
                      //                       padding: EdgeInsets.only(left: 0),
                      //                       child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing',
                      //                         fontSize: 13,
                      //                         fontFamily: 'regular',
                      //                         color: Colors.black,
                      //                       ),
                      //                     ),
                      //                     py3,
                      //                     Row(
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(left: 0),
                      //                           child: ParagraphText(
                      //                             text: 'India 9 hr ago',
                      //                             fontSize: 9,
                      //                             fontFamily: 'regular',
                      //                             color:MyColors.textcolor,
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      for(int i = 0;i<trendingNews.length;i++)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              // Navigator.pushNamed(context, News_Detail_Page.id);
                              push(context: context, screen: News_Detail_Page(newsDetail: trendingNews[i]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              width: MediaQuery.of(context).size.width - 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    boxShadow
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CustomCircularImage(
                                            imageUrl: trendingNews[i].fileType==NewsFileType.video?trendingNews[i].thumbnail:trendingNews[i].file,
                                            height: 70,
                                            width: 61,
                                          ),
                                          if(trendingNews[i].fileType==NewsFileType.video)
                                          Container(
                                            height: 70,
                                            width: 61,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(MyImages.Play, width: 24,height: 24,)
                                              ],

                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  hSizedBox,
                                  Flexible(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: ParagraphText(text: trendingNews[i].title,
                                            fontSize: 13,
                                            fontFamily: 'regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        py3,
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: ParagraphText(
                                                text: '${trendingNews[i].location} ${timeAgo(trendingNews[i].createdAt)}',
                                                fontSize: 9,
                                                fontFamily: 'regular',
                                                color:MyColors.textcolor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 10, right: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recently Added', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'medium',
                        fontSize: 17,
                      ),),
                      Text('Top News', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'regular',
                        fontSize: 13,
                      ),),
                    ],
                  ),





                ),
                Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width - 16,
                  child:
                  load?CustomLoader():
                  recentlyAdded.length==0?Center(child: ParagraphText(text: 'No Data found',),):
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for(int i = 0;i<recentlyAdded.length;i++)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              push(context: context, screen: News_Detail_Page(newsDetail: recentlyAdded[i]));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                padding: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      boxShadow
                                    ]
                                  // border: Border.all(color: Colors.grey)
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        child: Image.network(
                                          recentlyAdded[i].fileType==NewsFileType.video?recentlyAdded[i].thumbnail:recentlyAdded[i].file,
                                          fit: BoxFit.fitWidth,
                                          width: MediaQuery.of(context).size.width - 32,
                                          height: 170,
                                        ),
                                      ),
                                      vSizedBox,
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: ParagraphText(text: recentlyAdded[i].title,
                                          fontSize: 13,
                                          fontFamily: 'regular',
                                          color: Colors.black,
                                        ),
                                      ),
                                      vSizedBox,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: ParagraphText(
                                          text: '${recentlyAdded[i].location} ${timeAgo(recentlyAdded[i].createdAt)}',
                                          fontSize: 9,
                                          fontFamily: 'regular',
                                          color:MyColors.textcolor,
                                        ),
                                      ),

                                    ]
                                )
                            ),
                          )

                        ],

                      ),
                      // Column(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: (){
                      //         Navigator.pushNamed(context, News_Detail_Page.id);
                      //       },
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //           padding: EdgeInsets.only(bottom: 16),
                      //           decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(15),
                      //               boxShadow: [
                      //                 boxShadow
                      //               ]
                      //             // border: Border.all(color: Colors.grey)
                      //           ),
                      //           child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children:[
                      //                 ClipRRect(
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(15),
                      //                     topRight: Radius.circular(15),
                      //                     bottomLeft: Radius.circular(0),
                      //                     bottomRight: Radius.circular(0),
                      //                   ),
                      //                   child: Image.asset(
                      //                     MyImages.plumb,
                      //                     fit: BoxFit.fitWidth,
                      //                     width: MediaQuery.of(context).size.width - 32,
                      //                     height: 170,
                      //                   ),
                      //                 ),
                      //                 vSizedBox,
                      //                 Padding(
                      //                   padding: EdgeInsets.symmetric(horizontal: 16),
                      //                   child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing',
                      //                     fontSize: 13,
                      //                     fontFamily: 'regular',
                      //                     color: Colors.black,
                      //                   ),
                      //                 ),
                      //                 vSizedBox,
                      //                 Padding(
                      //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //                   child: ParagraphText(
                      //                     text: 'India 9 hr ago',
                      //                     fontSize: 9,
                      //                     fontFamily: 'regular',
                      //                     color:MyColors.textcolor,
                      //                   ),
                      //                 ),
                      //
                      //               ]
                      //           )
                      //       ),
                      //     )
                      //
                      //   ],
                      //
                      // ),
                    ],
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Job Releated News', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'medium',
                    fontSize: 17,
                  ),),
                ),
                Container(
                  height: 130,

                  child:load?CustomLoader():
                  jobRelatedList.length==0?Center(child: ParagraphText(text: 'No Data found',),):
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for(int i = 0;i<jobRelatedList.length;i++)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                             // Navigator.pushNamed(context, News_Detail_Page.id);
                              push(context: context, screen: News_Detail_Page(newsDetail: jobRelatedList[i]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15, left: 10),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              width: MediaQuery.of(context).size.width - 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    boxShadow
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: ParagraphText(text: jobRelatedList[i].title,
                                            fontSize: 13,
                                            fontFamily: 'regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        py3,
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: ParagraphText(
                                                text:'${jobRelatedList[i].location} ${timeAgo(jobRelatedList[i].createdAt)}',
                                                fontSize: 9,
                                                fontFamily: 'regular',
                                                color:MyColors.textcolor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  vSizedBox,
                                  Flexible(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CustomCircularImage(
                                            imageUrl:jobRelatedList[i].fileType==NewsFileType.video?jobRelatedList[i].thumbnail:jobRelatedList[i].file,
                                            height: 70,
                                            width: 61,
                                          ),
                                          Container(
                                            height: 70,
                                            width: 61,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(MyImages.Play, width: 24,height: 24,)
                                              ],

                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
