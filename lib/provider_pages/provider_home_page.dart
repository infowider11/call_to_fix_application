import 'dart:developer';

import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/modals/videos_modal.dart';
import 'package:calltofix/pages/bookingInformationPage.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/video_player_page.dart';
import 'package:calltofix/provider_pages/menu_page.dart';
import 'package:calltofix/provider_pages/provider_notification_page.dart';
import 'package:calltofix/provider_pages/training_videos_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:calltofix/widgets/new_jobs_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/CustomTexts.dart';
import '../widgets/avatar.dart';
import '../widgets/customLoader.dart';
import '../widgets/video_popup_player.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:intl/intl.dart';
class Provider_home_pageState extends State<Provider_home_page> {
  List<Map<String, dynamic>> imgList = [
    {
      "url": 'assets/images/slider.png',
    },
    {
      "url": 'assets/images/welcome_back.png',
    },
    {
      "url": 'assets/images/slider.png',
    }
  ];
  int _currentIndex = 0;

  bool load = false;
  bool trainingVideosLoad = false;
  List<VideoModal> videos = [];

  List newJobs = [];
  bool newJobsLoad = false; 

  getHomePageData() async {
    setState(() {
      trainingVideosLoad = true;
      newJobsLoad = true;
    });
    var request = {
      'limit': '2',
      'user_id': userData!['id'],
    };
    List temp = await Webservices.getListFromRequestParameters(
        ApiUrls.getTrainingVideos, request);
    videos = [];
    temp.forEach((element) {
      videos.add(VideoModal.fromJson(element));
    });
    setState(() {
      trainingVideosLoad = false;
    });
    
    
    newJobs = (await Webservices.getList(ApiUrls.myBookingList + '?user_id=${userData!['id']}&user_type=2&status=0&limit=3'));
    
    setState(() {
      newJobsLoad = false;
    });
  }

  TextEditingController search = TextEditingController();

  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  bool pressAttention5 = false;

  @override
  void initState() {
    // TODO: implement initState
    getHomePageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
          appBarColor: MyColors.appbarcolor,
          context: context,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Menu_Page.id);
            },
            child: Icon(
              Icons.menu_outlined,
              color: Colors.black,
            ),
          ),
          implyLeading: false,
          title: 'Home',
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Provider_Notification_page.id);
                },
                icon: Image.asset(
                  MyImages.Notification,
                  width: 17,
                ))
          ]),
      body: trainingVideosLoad
          ? CustomLoader()
          : SingleChildScrollView(
              child: Container(
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox,
                    Row(
                      children: [
                        Flexible(
                            child: Column(
                          children: [
                            CustomCircularImage(
                              imageUrl: userData!['image'],
                              height: 35,
                              width: 35,
                            ),
                          ],
                        )),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ParagraphText(
                                  text: userData!['full_name'],
                                  fontSize: 14,
                                  fontFamily: 'medium',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      MyImages.Location,
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ParagraphText(
                                      text: '${userData!['city']['name']}',
                                      fontSize: 12,
                                      fontFamily: 'medium',
                                      color: MyColors.subtext,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    vSizedBox4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headingText(
                          text: 'Training Videos',
                          fontSize: 18,
                          fontFamily: 'medium',
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            push(context: context, screen: TrainingVideosPage());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ParagraphText(
                              text: 'View More',
                              fontFamily: 'regular',
                              fontSize: 9,
                              color: MyColors.primaryColor,
                              underlined: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox2,
                    Column(
                      children: [
                        // trainingVideosLoad?CustomLoader():
                        if (videos.length == 0)
                          Center(
                              child: ParagraphText(
                            text: 'No Training Videos Found',
                            textAlign: TextAlign.center,
                          )),
                        for (int i = 0; i < videos.length; i++)
                          GestureDetector(
                            // onTap: () {
                            //   push(
                            //       context: context,
                            //       screen: VideoPlayerPage(
                            //        videoModal:  videos[i],
                            //       ));
                            // },
                            onTap: ()async{
                              print('klsdhflksdhflkdhjasfklhdaslfkjdskldjasfkljasdfkljasfkas');
                              VlcPlayerController videoPlayerController =VlcPlayerController.network(
                                videos[i].file,
                                hwAcc: HwAcc.full,
                                autoPlay: true,
                                options: VlcPlayerOptions(),
                              );
                              bool isPlaying = false;
                              videoPlayerController.addListener(() async {
                                isPlaying = (await videoPlayerController.isPlaying()) ?? false;
                                try{
                                  setState(() {});
                                }catch(e){
                                  print('Error in catch block95634 $e');
                                }
                              });
                              // Navigator.pushNamed(context, News_Detail_Page.id);
                              // push(context: context, screen: VideoPlayerPage(videoModal: trainingVideos[i]));
                              showDialog(context: context, builder: (context){
                                return CustomVideoPlayerPopUp(videoPlayerController: videoPlayerController, isPlaying: isPlaying,);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [boxShadow]
                                  // border: Border.all(color: Colors.grey)
                                  ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CustomCircularImage(
                                            imageUrl: videos[i].thumbnail,
                                            height: 70,
                                            width: 61,
                                            fit: BoxFit.fitHeight,
                                            borderRadius: 15,
                                          ),
                                          Container(
                                            height: 70,
                                            width: 61,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  MyImages.Play,
                                                  width: 24,
                                                  height: 24,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                  hSizedBox,
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: ParagraphText(
                                            text: videos[i].title,
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
                                                text: 'Watch Now',
                                                fontSize: 9,
                                                fontFamily: 'regular',
                                                color: MyColors.primaryColor,
                                                underlined: true,
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
                          ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(15),
                        //       boxShadow: [
                        //         boxShadow
                        //       ]
                        //     // border: Border.all(color: Colors.grey)
                        //   ),
                        //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        //   child: Row(
                        //     children: [
                        //       Flexible(
                        //           flex: 3,
                        //           child: Stack(
                        //             children: [
                        //               CircleAvatarcustom(
                        //                 image: MyImages.plumb,
                        //                 bgcolor: Colors.transparent,
                        //                 height: 70,
                        //                 width: 61,
                        //                 fit: BoxFit.fitHeight,
                        //                 borderradius: 15,
                        //               ),
                        //               Container(
                        //                 height: 70,
                        //                 width: 61,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(15),
                        //                   color: Colors.black.withOpacity(0.3),
                        //                 ),
                        //                 child: Column(
                        //                   crossAxisAlignment: CrossAxisAlignment.center,
                        //                   mainAxisAlignment: MainAxisAlignment.center,
                        //                   children: [
                        //                     Image.asset(MyImages.Play, width: 24,height: 24,)
                        //                   ],
                        //
                        //                 ),
                        //               )
                        //             ],
                        //           )
                        //       ),
                        //       hSizedBox,
                        //       Flexible(
                        //         flex: 6,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 0),
                        //               child: ParagraphText(text: 'Lorem Ipsum is simply dummy text of the printing',
                        //                 fontSize: 13,
                        //                 fontFamily: 'regular',
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //             py3,
                        //             Row(
                        //               children: [
                        //                 Padding(
                        //                   padding: EdgeInsets.only(left: 0),
                        //                   child: ParagraphText(
                        //                     text: 'Watch Now',
                        //                     fontSize: 9,
                        //                     fontFamily: 'regular',
                        //                     color:MyColors.primaryColor,
                        //                     underlined: true,
                        //                   ),
                        //                 ),
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headingText(
                          text: 'New jobs',
                          fontSize: 18,
                          fontFamily: 'View More',
                        ),
                        ParagraphText(
                          text: 'View More',
                          fontFamily: 'regular',
                          fontSize: 9,
                          color: MyColors.primaryColor,
                          underlined: true,
                        ),
                      ],
                    ),
                    vSizedBox,
                    for (var i = 0; i < newJobs.length; i++)
                      GestureDetector(
                        child: NewJobsCard(jobData: newJobs[i],),
                      ),
                    // for (var i = 0; i < newJobs.length; i++)
                    //   GestureDetector(
                    //     onTap: (){
                    //       push(context: context, screen: BookingInformationPage(bookingDetails: newJobs[i]));
                    //     },
                    //     child: Booking_List(
                    //       text: newJobs[i]['booked_by']['user_name']??'',
                    //       subtext:  '${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.parse(newJobs[i]['dateTime'] ?? DateTime.now().toString()))}',
                    //       horizontalpadding: 0,
                    //       color: Color(0xFF2C3A4B).withOpacity(0.50),
                    //       fontSize: 9,
                    //       fontFamily: 'regular',
                    //       image: newJobs[i]['booked_by']['image'],
                    //       heightimg: 55,
                    //       widthimg: 55,
                    //       button: false,
                    //       btntext: 'Completed',
                    //       btntextcolor: Color(0xFF34A853),
                    //       btnradius: 5,
                    //       btncolor: Color(0xFF34A853).withOpacity(0.34),
                    //       btnfontsize: 10,
                    //       viewbtn: false,
                    //       requestbtn: true,
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Provider_home_page extends StatefulWidget {
  static const String id = "Provider_home_page";
  const Provider_home_page({required Key key}) : super(key: key);

  @override
  State<Provider_home_page> createState() => Provider_home_pageState();
}
