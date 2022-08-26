import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/category.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/provider_pages/provider_notification_page.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/global_data.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/avatar.dart';
import 'menu_page.dart';

class Job_History_page extends StatefulWidget {
  static const String id="Job_History_page";
  const Job_History_page({Key? key}) : super(key: key);

  @override
  State<Job_History_page> createState() => _Job_History_pageState();
}

class _Job_History_pageState extends State<Job_History_page> {
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



  bool load = false;
  List onGoingJobs = [];
  List completedJobs = [];
  getJobs()async{
    setState(() {
      load = true;
    });
    onGoingJobs = (await Webservices.getList(ApiUrls.myBookingList + '?user_id=${userData!['id']}&user_type=2&status=1'));
    completedJobs = (await Webservices.getList(ApiUrls.myBookingList + '?user_id=${userData!['id']}&user_type=2&status=2,3'));
    setState(() {
      load = false;
    });
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
          title: 'Ongoing jobs',
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTabController(
                  length: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        vSizedBox,
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: MyColors.primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            // indicatorColor: Color(0xFE567FFF),
                            padding: EdgeInsets.all(0),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.primaryColor,
                            ),

                            tabs: [
                              Tab(
                                child: Text('New', style: TextStyle(fontSize: 11),),
                              ),
                              Tab(
                                child: Text('Completed', style: TextStyle(fontSize: 11),),
                              ),
                            ],
                          ),
                        ),
                        vSizedBox2,
                        Container(
                          child: Expanded(
                            child: TabBarView(
                              children: [
                               Container(
                                 child: Column(
                                   children: [
                                     for (var i=0; i<onGoingJobs.length; i++)
                                       Job(
                                         text: '${onGoingJobs[i]['id']}',
                                         subtext: 'Navlakha , Indore',
                                         viewbtntext: 'View Details',
                                         viewbtncolor: MyColors.primaryColor,
                                         horizontalpadding: 0,
                                         color: Color(0xFF2C3A4B).withOpacity(0.50),
                                         fontSize: 9,
                                         fontFamily: 'regular',
                                         image: MyImages.plumb,
                                         headingfontsize: 15,
                                         heightimg: 55,
                                         widthimg: 55,
                                         button:false,
                                         btntext: 'Completed',
                                         btntextcolor: Color(0xFF34A853),
                                         btnradius: 5,
                                         btncolor: Color(0xFF34A853).withOpacity(0.34),
                                         btnfontsize: 10,
                                         viewbtn: true,
                                         deleteicon: true,
                                       ),
                                   ],
                                 ),
                               ),
                               Container(
                                 child: Column(
                                   children: [
                                       Job(
                                         text: 'John Smith',
                                         subtext: 'Navlkkha , indore',
                                         viewbtntext: 'Delete',
                                         viewbtncolor: Colors.red,
                                         horizontalpadding: 0,
                                         color: Color(0xFF2C3A4B).withOpacity(0.50),
                                         fontSize: 9,
                                         fontFamily: 'regular',
                                         image: MyImages.plumb,
                                         headingfontsize: 15,
                                         heightimg: 55,
                                         widthimg: 55,
                                         button:true,
                                         btntext: 'Completed',
                                         btntextcolor: Color(0xFF34A853),
                                         btnradius: 5,
                                         btncolor: Color(0xFF34A853).withOpacity(0.34),
                                         btnfontsize: 10,
                                         viewbtn: true,
                                         deleteicon: false,
                                       ),
                                       Job(
                                         text: 'John Smith',
                                         subtext: 'Navlkkha , indore',
                                         viewbtntext: 'Mark as Completed',
                                         viewbtncolor: MyColors.primaryColor,
                                         horizontalpadding: 0,
                                         color: Color(0xFF2C3A4B).withOpacity(0.50),
                                         fontSize: 9,
                                         fontFamily: 'regular',
                                         image: MyImages.plumb,
                                         headingfontsize: 15,
                                         heightimg: 55,
                                         widthimg: 55,
                                         button:true,
                                         btntext: 'Pending',
                                         btntextcolor: MyColors.primaryColor,
                                         btnradius: 5,
                                         btncolor: MyColors.primaryColor.withOpacity(0.34),
                                         btnfontsize: 10,
                                         viewbtn: true,
                                         deleteicon: false,
                                       ),
                                       Job(
                                         text: 'John Smith',
                                         subtext: 'Navlkkha , indore',
                                         viewbtntext: 'Mark as Completed',
                                         viewbtncolor: MyColors.primaryColor,
                                         horizontalpadding: 0,
                                         color: Color(0xFF2C3A4B).withOpacity(0.50),
                                         fontSize: 9,
                                         fontFamily: 'regular',
                                         image: MyImages.plumb,
                                         headingfontsize: 15,
                                         heightimg: 55,
                                         widthimg: 55,
                                         button:true,
                                         btntext: 'Canceled',
                                         btntextcolor: Colors.red,
                                         btnradius: 5,
                                         btncolor: Colors.red.withOpacity(0.34),
                                         btnfontsize: 10,
                                         viewbtn: false,
                                         deleteicon: false,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
