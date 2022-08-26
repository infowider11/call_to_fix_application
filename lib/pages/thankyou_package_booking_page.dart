import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/appbar.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThankyouPagePackageBooking extends StatefulWidget {
  final Map bookingDetails;
  const ThankyouPagePackageBooking({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  _ThankyouPagePackageBookingState createState() =>
      _ThankyouPagePackageBookingState();
}

class _ThankyouPagePackageBookingState
    extends State<ThankyouPagePackageBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context: context, title: ''),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox8,
                Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 120,
                  ),
                ),
                vSizedBox2,
                Center(
                    child: MainHeadingText(
                  text: 'Thankyou for Booking this service',
                  textAlign: TextAlign.center,
                  color: Colors.green,
                )),
                vSizedBox6,
                MainHeadingText(
                  text: 'Booking Details',
                  color: Colors.black54,
                ),
                vSizedBox2,
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SubHeadingText(text: 'Booking Id')),
                          SubHeadingText(text: ' : '),
                          Expanded(
                              child: SubHeadingText(
                            text: '${widget.bookingDetails['id']}',
                          ))
                        ],
                      ),
                      // vSizedBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //         child: SubHeadingText(text: 'Provider Name')),
                      //     SubHeadingText(text: ' : '),
                      //     Expanded(
                      //         child: SubHeadingText(
                      //       text: '${widget.bookingDetails}',
                      //     ))
                      //   ],
                      // ),
                      vSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            text: '${widget.bookingDetails['amount']}',
                          ))
                        ],
                      ),
                      vSizedBox,
                    ],
                  ),
                )
              ],
            ),
            RoundEdgedButton(
              text: 'Go Back',
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
