import 'package:calltofix/constants/global_keys.dart';
import 'package:calltofix/constants/sized_box.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/widgets/CustomTexts.dart';
import 'package:calltofix/widgets/buttons.dart';
import 'package:calltofix/widgets/custom_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewJobsCard extends StatelessWidget {
  final Map jobData;
  const NewJobsCard({Key? key, required this.jobData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCircularImage(imageUrl: jobData['booked_by']['image']),
          hSizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubHeadingText(
                  text: jobData['booked_by']['user_name'] ?? '',
                  fontWeight: FontWeight.bold,
                ),
                vSizedBox05,
                ParagraphText(
                  text:
                      '${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.parse(jobData['dateTime'] ?? DateTime.now().toString()))}',
                  fontSize: 10,
                  color: Colors.black54,
                ),
                vSizedBox05,
                Row(
                  children: [
                    RoundEdgedButton(
                      textColor: Colors.green,
                      color: Color(0xFF34A853).withOpacity(0.34),
                      fontSize: 12,
                      borderRadius: 6,
                      text: 'Accept',
                      width: 99,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      height: 20,
                      fontfamily: 'regular',
                      letterspace: 0,
                      onTap: ()async{
                        var request = {
                          'booking_id': jobData['id'],
                          'status': '1'
                        };
                        var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.accept_reject, body: request, context: context, showSuccessMessage: true);
                        if(jsonResponse['status']==1){
                          try{
                            MyGlobalKeys.providerHomePageKey.currentState!.getHomePageData();
                          }catch(e){
                            print('Error in catch block 345 $e');
                          }
                        }
                      },
                    ),
                    hSizedBox,
                    RoundEdgedButton(
                      textColor: Colors.red,
                      color: Colors.red.withOpacity(0.34),
                      fontSize: 12,
                      borderRadius: 6,
                      text: 'Reject',
                      width: 99,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      height: 20,
                      fontfamily: 'regular',
                      letterspace: 0,
                      onTap: ()async{
                        var request = {
                          'booking_id': jobData['id'],
                          'status': '2'
                        };
                        var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.accept_reject, body: request, context: context, showSuccessMessage: true);
                        if(jsonResponse['status']==1){
                          try{
                            MyGlobalKeys.providerHomePageKey.currentState!.getHomePageData();
                          }catch(e){
                            print('Error in catch block 345 $e');
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
