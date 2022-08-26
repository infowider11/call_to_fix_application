import 'dart:convert';
import 'dart:developer';

import 'package:calltofix/functions/navigation_functions.dart';
import 'package:calltofix/pages/aboutus.dart';
import 'package:calltofix/pages/bookingInformationPage.dart';
import 'package:calltofix/pages/cart.dart';
import 'package:calltofix/pages/category.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:calltofix/services/firebase_push_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/loginpage.dart';
import 'package:calltofix/pages/manage_payment_method.dart';
import 'package:calltofix/pages/manageaddress.dart';
import 'package:calltofix/pages/my_bookings.dart';
import 'package:calltofix/pages/my_wallet.dart';
import 'package:calltofix/pages/notification_page.dart';
import 'package:calltofix/pages/otppage.dart';
import 'package:calltofix/pages/paymentmethod.dart';
import 'package:calltofix/pages/privacy.dart';
import 'package:calltofix/pages/product_category.dart';
import 'package:calltofix/pages/product_detail_page.dart';
import 'package:calltofix/pages/product_list.dart';
import 'package:calltofix/pages/profile_page.dart';
import 'package:calltofix/pages/provider-detail.dart';
import 'package:calltofix/pages/provider_list.dart';
import 'package:calltofix/pages/search_result.dart';
import 'package:calltofix/pages/select_service.dart';
import 'package:calltofix/pages/service_provider_detail_page.dart';
import 'package:calltofix/pages/shop.dart';
import 'package:calltofix/pages/signinpage.dart';
import 'package:calltofix/pages/signupuser.dart';
import 'package:calltofix/pages/tab.dart';
import 'package:calltofix/pages/tab_provider.dart';
import 'package:calltofix/pages/terms.dart';
import 'package:calltofix/pages/videocall.dart';
import 'package:calltofix/pages/welcome.dart';
import 'package:calltofix/provider_pages/about_work_page.dart';
import 'package:calltofix/provider_pages/add_new_package.dart';

import 'package:calltofix/provider_pages/add_service.dart';
import 'package:calltofix/provider_pages/certification.dart';
import 'package:calltofix/provider_pages/customer_review.dart';
import 'package:calltofix/provider_pages/edit_profile.dart';
import 'package:calltofix/provider_pages/edit_service.dart';
import 'package:calltofix/provider_pages/edit_user_profile.dart';
import 'package:calltofix/provider_pages/job_history_page.dart';
import 'package:calltofix/provider_pages/menu_page.dart';
import 'package:calltofix/provider_pages/my_wallet_provider.dart';
import 'package:calltofix/provider_pages/news.dart';
import 'package:calltofix/provider_pages/news_detail.dart';
import 'package:calltofix/provider_pages/package_managment_page.dart';
import 'package:calltofix/provider_pages/personal_information_page.dart';
import 'package:calltofix/provider_pages/provider_home_page.dart';
import 'package:calltofix/provider_pages/provider_myprofilepage.dart';
import 'package:calltofix/provider_pages/provider_notification_page.dart';
import 'package:calltofix/provider_pages/provider_otppage.dart';
import 'package:calltofix/provider_pages/select_city.dart';
import 'package:calltofix/provider_pages/select_profession.dart';
import 'package:calltofix/provider_pages/select_service.dart';
import 'package:calltofix/provider_pages/select_subcategory.dart';
import 'package:calltofix/provider_pages/service_managment_page.dart';
import 'package:calltofix/services/api_urls.dart';
import 'package:calltofix/services/webservices.dart';
import 'package:calltofix/splash.dart';
import 'package:flutter/material.dart';

import 'constants/category.dart';
import 'constants/global_data.dart';
import 'constants/global_keys.dart';
import 'provider_pages/service_manage_add.dart';
List<String>? myList ;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  print('firebase is initialized');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print('firebase is initialized2');
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload)async{
        print('the notification is selected $payload');
        // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
        if(payload!=null){
          try{
            Map data = jsonDecode(payload);
            if(data['screen']=='booking'){
              Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingInformation + '?user_id=${userData!['id']}&user_type=${userData!['user_type']}&booking_id=${data['booking_id']}');
              push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingDetails: bookingInformation));
              // Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${data['booking_id']}');
              // push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
            }
          }catch(e){
            print('Error in catch block 332 $e');
          }

        }
      }
  );
  print('firebase is initialized3 d');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String? payload= notificationAppLaunchDetails!.payload;
  print('the payload is ${payload}');

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebasePushNotifications.firebaseSetup();

  var response = await Webservices.getData(ApiUrls.getStripeKey);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 1) {
      publishable_key = jsonResponse['data']['stripe_pk'];
      secret_key = jsonResponse['data']['stripe_sk'];
      headers = {
        'Authorization': 'Bearer ${jsonResponse['secret_key']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
    } else {
      print(
          '_________________________________________invalid keys___________________________________________');
    }
  }
  Stripe.publishableKey = publishable_key;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALLTOFIX',
      navigatorKey: MyGlobalKeys.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'regular',
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
      routes: {
       WelcomePage.id: (contaxt) =>WelcomePage(),
       LoginPage.id: (contaxt) =>LoginPage(),
       Otp_Page.id: (contaxt) =>Otp_Page(),
       HomePage.id: (contaxt) =>HomePage(),
       Category_Page.id: (contaxt) =>Category_Page(categoryId: '',),
       TabsPage.id: (contaxt) =>TabsPage(),
        Select_Service_Page.id: (contaxt) =>Select_Service_Page(),
        Provider_list_page.id: (contaxt) =>Provider_list_page(),
        Service_Provider_Detail_Page.id: (contaxt) =>Service_Provider_Detail_Page(),
        Cart_Page.id: (contaxt) =>Cart_Page(),
        PaymentMethod_Page.id: (contaxt) =>PaymentMethod_Page(),
        Notification_page.id: (contaxt) =>Notification_page(),
        Shop_Page.id: (contaxt) =>Shop_Page(),
        Product_list_page.id: (contaxt) =>Product_list_page(),
        Product_Category_Page.id: (contaxt) =>Product_Category_Page(),
        Product_Detail_Page.id: (contaxt) =>Product_Detail_Page(),
        My_Bookings_page.id: (contaxt) =>My_Bookings_page(),
        My_Wallet_Page.id: (contaxt) =>My_Wallet_Page(),
        Profile_Page.id: (contaxt) =>Profile_Page(),
        Manage_address_page.id: (contaxt) =>Manage_address_page(),
        Manage_Payment_Method_Page.id: (contaxt) =>Manage_Payment_Method_Page(),
        About_Us_Page.id: (contaxt) =>About_Us_Page(),
        Terms_Page.id: (contaxt) =>Terms_Page(),
        Privacy_Page.id: (contaxt) =>Privacy_Page(),


        //Provider_Pagfes
        // Personal_Information_Page.id: (context) => Personal_Information_Page(),
        // Select_Profession_Page.id: (contaxt) =>Select_Profession_Page(),
        // Select_City_Page.id: (contaxt) =>Select_City_Page(),
        About_Work_Page.id: (contaxt) =>About_Work_Page(),
        // Certification_Page.id: (contaxt) =>Certification_Page(),
        Tabs_Provider_Page.id: (contaxt) =>Tabs_Provider_Page(),
        Provider_home_page.id: (contaxt) =>Provider_home_page(key: MyGlobalKeys.providerHomePageKey,),
        Job_History_page.id: (contaxt) =>Job_History_page(),
        My_Wallet_Provider_Page.id: (contaxt) =>My_Wallet_Provider_Page(),
        Provider_Notification_page.id: (contaxt) =>Provider_Notification_page(),
        Provider_MyProfilePage.id: (contaxt) =>Provider_MyProfilePage(),
        Edit_Profile_Page.id: (contaxt) =>Edit_Profile_Page(),
        News_Page.id: (contaxt) =>News_Page(),
        // News_Detail_Page.id: (contaxt) =>News_Detail_Page(),
        Menu_Page.id: (contaxt) =>Menu_Page(),
        Customer_Review_Page.id: (contaxt) =>Customer_Review_Page(),
        // Provider_Otp_Page.id: (contaxt) =>Provider_Otp_Page(),
        Service_managment_Page.id: (contaxt) =>Service_managment_Page(),
        Edit_Service_Page.id: (contaxt) =>Edit_Service_Page(data: {},),
        Services_Add_Page.id: (contaxt) =>Services_Add_Page(),
        // Select_Subcategory_Page.id: (contaxt) =>Select_Subcategory_Page(),
        // Add_Service_Page.id: (contaxt) =>Add_Service_Page(),
        Package_Managment_Page.id: (contaxt) =>Package_Managment_Page(),
        SignIn_Page.id: (contaxt) =>SignIn_Page(),
        SignUp_Page.id: (contaxt) =>SignUp_Page(data: {},),
        VideoCall_Page.id: (contaxt) =>VideoCall_Page(),
        Add_Package_Page.id:(contaxt) =>Add_Package_Page(),
        Select_Services_Page.id:(context) =>Select_Services_Page(service: [], selectedSubCategories: [],),
        Edit_User_Profile_Page.id:(context) =>Edit_User_Profile_Page(),
        searchResultPage.id:(context) =>searchResultPage(),
        Provider_Detail_Page.id:(context) =>Provider_Detail_Page(providerId: '',)
      },
    );
  }

}

