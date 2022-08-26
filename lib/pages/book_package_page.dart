import 'package:calltofix/constants/global_data.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/functions/showSnackbar.dart';
import 'package:calltofix/pages/thankyou_package_booking_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/new_stripe_services.dart';
import 'package:calltofix/services/stripe_response_modal.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_full_page_loader.dart';

class BookPackagePage extends StatefulWidget {

  final Map packageInfo;
  const BookPackagePage({Key? key, required this.packageInfo}) : super(key: key);

  @override
  _BookPackagePageState createState() => _BookPackagePageState();
}

class _BookPackagePageState extends State<BookPackagePage> {
  bool isOnlineSelected = true;
  TextEditingController dateTimeController = TextEditingController();

  bool termsAccepted = true;
  bool load = false;
  DateTime? selectedDateTime;
  @override
  Widget build(BuildContext context) {
    print(widget.packageInfo);
    print('used ${userData!['id']}');
    return Scaffold(
      appBar: appBar(context: context, title: 'Booking Summary'),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   vSizedBox4,
                   SubHeadingText(text: 'Select your booking type'),
                   vSizedBox2,
                   Row(
                     children: [
                       Expanded(
                         child: RoundEdgedButton(
                           text: 'In Person',
                           isSolid: !isOnlineSelected,
                           onTap: () {
                             isOnlineSelected = false;
                             setState(() {});
                           },
                         ),
                       ),
                       hSizedBox2,
                       Expanded(
                         child: RoundEdgedButton(
                           text: 'Online',
                           // color: Colors.green,
                           isSolid: isOnlineSelected,
                           onTap: () {
                             isOnlineSelected = true;
                             setState(() {});
                           },
                         ),
                       ),
                     ],
                   ),
                   vSizedBox2,
                   SubHeadingText(text: 'You will be charged USD${isOnlineSelected?widget.packageInfo['video_consult_fee']:widget.packageInfo['service_fee']}.'),
                   vSizedBox,
                   CustomDivider(),
                   vSizedBox2,
                   SubHeadingText(text: 'Select Date & Time'),
                   vSizedBox,
                   GestureDetector(
                     onTap: () async {
                       DateTime? date = await showDatePicker(
                         context: context,
                         initialDate: selectedDateTime ?? DateTime.now(),
                         firstDate: DateTime.now(),
                         lastDate: DateTime.now().add(Duration(days: 365)),
                       );
                       if (date != null) {
                         TimeOfDay? time = await showTimePicker(
                             context: context,
                             initialTime: TimeOfDay(hour: 6, minute: 0));
                         if (time != null) {
                           selectedDateTime = DateTime(
                             date.year,
                             date.month,
                             date.day,
                             time.hour,
                             time.minute,
                           );
                           dateTimeController.text = DateFormat.yMMMMEEEEd()
                               .add_jm()
                               .format(selectedDateTime!);
                         }

                         print('the selected date time is $selectedDateTime');

                         setState(() {});
                       }
                     },
                     child: CustomTextField(
                       controller: dateTimeController,
                       hintText: 'Select Date & Time',
                       enabled: false,
                     ),
                   ),
                   vSizedBox,
                 ],
               ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: termsAccepted, onChanged: (val){
                          termsAccepted = !termsAccepted;
                          setState(() {

                          });
                        }),
                        hSizedBox2,
                        Expanded(child: ParagraphText(text: "I accept Terms & Conditions",))
                      ],
                    ),
                    // vSizedBox2,
                    RoundEdgedButton(
                      verticalMargin: 20,
                      text: 'Confirm & pay',
                      onTap: ()async{

                         if(selectedDateTime==null){
                          showSnackbar('Please select date and time.');
                        }else if(!termsAccepted){
                           showSnackbar('Please Accept terms and conditions.');
                         }else{
                           setState(() {
                             load = true;
                           });
                          StripeResponseModal? stripeResponse= await NewStripeServices.makePayment(context: context, emailId: userData!['email'], amount: isOnlineSelected?widget.packageInfo['video_consult_fee']:widget.packageInfo['service_fee']);
                          if(stripeResponse!=null){
                            //{booked_by: 48, provider_id: 69, booking_type: Offline, service_items_type: package, items_id: 15, amount: 2555.00, transaction_id: pi_3LG0cHLEGsv8VYZL0C3LYaJj_secret_1IhzoscvltFEvXO62eHXsbPaw, dateTime: 2022-06-30 16:00:00.000}
                            var request = {
                              'booked_by': userData!['id'],
                              'provider_id': widget.packageInfo['user_id'],
                              'booking_type': isOnlineSelected?'Online':'Offline',
                              'service_items_type': 'package',
                              'items_id': widget.packageInfo['id'],
                              'amount': isOnlineSelected?widget.packageInfo['video_consult_fee']:widget.packageInfo['service_fee'],
                              'transaction_id': stripeResponse.clientSecret,
                              'dateTime': selectedDateTime.toString(),
                            };
                            var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.addBooking, body: request, context: context, showSuccessMessage: true);
                            if(jsonResponse['status'].toString()=='1'){
                              pushReplacement(context: context, screen: ThankyouPagePackageBooking(bookingDetails: jsonResponse['data']??{},));
                            }
                          }else{
                            setState(() {

                              load = false;
                            });
                          }
                        }


                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          if(load)
            CustomFullPageLoader()
        ],
      ),
    );
  }
}
