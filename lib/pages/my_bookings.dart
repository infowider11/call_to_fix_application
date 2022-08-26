import 'package:calltofix/constants/colors.dart';
import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/constants/image_urls.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/bookingInformationPage.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/videocall.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:calltofix/widgets/custom_full_page_loader.dart';
import 'package:calltofix/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/global_data.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import 'package:intl/intl.dart';
class My_Bookings_page extends StatefulWidget {
  static const String id = "My_Bookings_page";
  const My_Bookings_page({Key? key}) : super(key: key);

  @override
  State<My_Bookings_page> createState() => _My_Bookings_pageState();
}

class _My_Bookings_pageState extends State<My_Bookings_page> {
  bool load = false;

  List bookings = [];
  getHomePageData() async {
    setState(() {
      load = true;
    });



    bookings = (await Webservices.getList(ApiUrls.myBookingList + '?user_id=${userData!['id']}&user_type=1'));

    setState(() {
      load = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    getHomePageData();
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
        backgroundColor: Colors.white,
        appBar: appBar(
            implyLeading: false,
            context: context,
            title: 'My bookings',
            appBarColor: MyColors.appbarcolor,
            actions: [
              IconButton(
                  visualDensity: VisualDensity(horizontal: -4),
                  onPressed: () {
                    Navigator.pushNamed(context, Shop_Page.id);
                  },
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    MyImages.bag,
                    width: 22,
                    height: 22,
                  )),
              IconButton(
                  visualDensity: VisualDensity(horizontal: 0),
                  onPressed: () {
                    Navigator.pushNamed(context, Notification_page.id);
                  },
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    MyImages.Notification,
                    width: 17,
                  ))
            ]),
        body:Stack(
          children: [
            Container(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(bookings.length==0)
                      Center(
                        child: ParagraphText(text: 'No Bookings Found'),
                      ),
                    for(int i = 0;i<bookings.length;i++)
                    GestureDetector(
                      onTap: () {
                        push(context: context, screen: BookingInformationPage(bookingDetails: bookings[i]));
                        // Navigator.pushNamed(context, Provider_list_page.id);
                      },
                      child: Booking_List(
                        text: '${bookings[i]['items'][0]['title']}',
                        subtext: '${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.parse(bookings[i]['dateTime'] ?? DateTime.now().toString()))}',
                        horizontalpadding: 0,
                        color: Color(0xFF2C3A4B).withOpacity(0.50),
                        fontSize: 9,
                        fontFamily: 'regular',
                        image: bookings[i]['items'][0]['cover_image'],
                        heightimg: 55,
                        widthimg: 55,
                        button: true,
                        btntext:bookings[i]['status']=='0'?'Pending': 'Completed${bookings[i]['status']}',
                        btntextcolor: bookings[i]['status']=='0'? MyColors.primaryColor: Color(0xFF34A853),
                        btnradius: 5,
                        btncolor: bookings[i]['status']=='0'?MyColors.primaryColor.withOpacity(0.34):Color(0xFF34A853).withOpacity(0.34),
                        btnfontsize: 10,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, VideoCall_Page.id);
                    //   },
                    //   child: Booking_List(
                    //     text: 'Ac Service',
                    //     subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                    //     horizontalpadding: 0,
                    //     color: Color(0xFF2C3A4B).withOpacity(0.50),
                    //     fontSize: 9,
                    //     fontFamily: 'regular',
                    //     image: MyImages.plumb,
                    //     heightimg: 55,
                    //     widthimg: 55,
                    //     button: true,
                    //     btntext: 'Pending',
                    //     btntextcolor: MyColors.primaryColor,
                    //     btnradius: 5,
                    //     btncolor: MyColors.primaryColor.withOpacity(0.34),
                    //     btnfontsize: 10,
                    //     videobtn: true,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigator.pushNamed(context, Provider_list_page.id);
                    //   },
                    //   child: Booking_List(
                    //     text: 'Ac Service',
                    //     subtext: 'Sat, 23 Apr,  2022  at  10:30 AM',
                    //     horizontalpadding: 0,
                    //     color: Color(0xFF2C3A4B).withOpacity(0.50),
                    //     fontSize: 9,
                    //     fontFamily: 'regular',
                    //     image: MyImages.plumb,
                    //     heightimg: 55,
                    //     widthimg: 55,
                    //     button: true,
                    //     btntext: 'Payment Failed',
                    //     btntextcolor: Colors.red,
                    //     btnradius: 5,
                    //     btncolor: Colors.red.withOpacity(0.34),
                    //     btnfontsize: 10,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            if(load)
              CustomFullPageLoader()
          ],
        ),
      ),
    );
  }
}
