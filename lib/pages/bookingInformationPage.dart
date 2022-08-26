import 'dart:developer';

import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/pages/service_detail.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constans.dart';
import '../constants/global_data.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_circular_image.dart';

class BookingInformationPage extends StatefulWidget {
  final Map bookingDetails;
  final bool isProvider;
  const BookingInformationPage({Key? key, required this.bookingDetails, this.isProvider = true}) : super(key: key);

  @override
  _BookingInformationPageState createState() => _BookingInformationPageState();
}

class _BookingInformationPageState extends State<BookingInformationPage> {


  // bool load = false;
  //
  //
  //
  // Map bookingDetail = {};
  // getBookingInformation()async{
  //   setState(() {
  //     load = true;
  //   });
  //   bookingDetail = await Webservices.getMap(ApiUrls.getBookingInformation + '${userData!['id']}');
  //   setState(() {
  //     load = false;
  //   });
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getBookingInformation();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    log(widget.bookingDetails.toString());
    return Scaffold(
      appBar: appBar(context: context, title: 'Booking Information'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.bookingDetails['items'][0]['cover_image']
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),

            ),
            Positioned(
              bottom: 0,
              top: 250,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox2,
                    MainHeadingText(
                      text: 'Booking Details',
                      color: Colors.black54,
                    ),
                    vSizedBox2,
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 42),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SubHeadingText(text: 'Booking Id')),
                              SubHeadingText(text: ' : '),
                              Expanded(
                                  child: SubHeadingText(
                                    text: '#${widget.bookingDetails['id']}',
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          vSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: SubHeadingText(text: 'Provider Name')),
                              SubHeadingText(text: ' : '),
                              Expanded(
                                  child: SubHeadingText(
                                    text: '${widget.bookingDetails['provider_id']['full_name']}',
                                  ))
                            ],
                          ),
                          vSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: SubHeadingText(text: 'Date & Time')),
                              SubHeadingText(text: ' : '),
                              Expanded(
                                  child: SubHeadingText(
                                    text:
                                    '${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.parse(widget.bookingDetails['dateTime'] ?? DateTime.now().toString()))}',
                                  ))
                            ],
                          ),
                          vSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SubHeadingText(text: 'Amount Paid')),
                              SubHeadingText(text: ' : '),
                              Expanded(
                                  child: SubHeadingText(
                                    text: '\$${widget.bookingDetails['amount']}',
                                  ))
                            ],
                          ),
                          if(userData!['user_type']=='2')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vSizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: SubHeadingText(text: 'App Commission')),
                                  SubHeadingText(text: ' : '),
                                  Expanded(
                                      child: SubHeadingText(
                                        text: '\$${widget.bookingDetails['admin_amount']}',
                                      ))
                                ],
                              ),
                              vSizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: SubHeadingText(text: 'You will earn')),
                                  SubHeadingText(text: ' : '),
                                  Expanded(
                                      child: SubHeadingText(
                                        text: '\$${widget.bookingDetails['provider_amount']}',
                                        color: Colors.green,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          vSizedBox,
                          CustomDivider(),
                          MainHeadingText(
                            text: 'Services Provided',
                            color: Colors.black54,
                          ),
                          vSizedBox2,
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                for(int i=0;i<widget.bookingDetails['items'][0]['services'].length;i++)
                                  GestureDetector(
                                    onTap:() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => (
                                          Service_detail(service_id: widget.bookingDetails['items'][0]['services']![i]['id'],)
                                      )));
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.all(8.0),
                                      margin: EdgeInsets.all(8.0),
                                      height: 80,
                                      width: 80,
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
                                                  imageUrl: widget.bookingDetails['items'][0]['services'][i]['cover_image'],
                                                  height: 24,
                                                  width: 24,
                                                  fileType: CustomFileType.network,
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
                                            text: widget.bookingDetails['items'][0]['services'][i]['title'],
                                            fontSize: 9,textAlign: TextAlign.center,
                                            color: Colors.black.withOpacity(0.70),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
