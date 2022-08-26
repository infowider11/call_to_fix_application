import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/widgets/customLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/lists.dart';

class Provider_Notification_page extends StatefulWidget {
  static const String id="Provider_Notification_page";
  const Provider_Notification_page({Key? key}) : super(key: key);

  @override
  State<Provider_Notification_page> createState() => _Provider_Notification_pageState();
}

class _Provider_Notification_pageState extends State<Provider_Notification_page> {
  bool load = false;



  List notifications = [];
  getNotifications()async{
    setState(() {
      load = true;
    });
    notifications = await Webservices.getList(ApiUrls.getNotifications + '${userData!['id']}');
    setState(() {
      load = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: 'Notifications',
          appBarColor: MyColors.appbarcolor,
          actions: [
            TextButton(
                onPressed: (){},
                child: ParagraphText(text: 'Clear', color: Colors.red,
                  fontSize: 14,
                )
            )
          ]
      ),
      body:load?CustomLoader(): RefreshIndicator(
        onRefresh: ()async{
          await getNotifications();
        },
        child: Container(
          padding: pad_horizontal,
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
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                for(var i=0; i<notifications.length; i++)
                StaffList(
                  text: notifications[i]['message'],
                  subtext: 'View',
                  horizontalpadding: 0,
                  color: MyColors.primaryColor,
                  fontSize: 10,
                  headingfontsize: 10,
                  fontFamily: 'regular',
                  image: MyImages.plumb,
                  deleteicon: false,
                  heightimg: 50,
                  widthimg: 50,
                  underlined: true,
                  subtextpad: false,
                  underlinedtext: true,
                  chosseoption: true,
                ),
                // StaffList(
                //   text: 'Payment Done \$100 to Service provider',
                //   subtext: 'Go to wallet',
                //   horizontalpadding: 0,
                //   color: MyColors.primaryColor,
                //   fontSize: 10,
                //   headingfontsize: 11,
                //   fontFamily: 'regular',
                //   headingfontfamily: 'regular',
                //   deleteicon: false,
                //   image: MyImages.debit_card_circle,
                //   heightimg: 50,
                //   widthimg: 50,
                //   underlined: true,
                //   subtextpad: false,
                //   underlinedtext: true,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
