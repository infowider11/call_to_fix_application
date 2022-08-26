class ApiUrls{
  static const baseUrl = 'https://www.webwiders.com/WEB01/Call-Tofix/Api/';
  static const String verifyMobile = baseUrl + 'check_mobile_send_otp';
  static const String verifyEmail = baseUrl + 'check_email';
  static const String signupUser = baseUrl + 'customer_signup';

  static const String packageDetail = baseUrl + 'singlePackageDetail?id=';
  static const String serviceDetail = baseUrl + 'singleServieDetail?id=';
  static const String signup_step_1 = baseUrl + 'update_personal_info';
  static const String signup_final_step = baseUrl + 'work_information';
  static const String getProfessions = baseUrl + 'work_catagory_list';
  static const String get_sub_catagory_list = baseUrl + 'sub_catagory_list';
  static const String getCities = baseUrl + 'city_list';
  static const String getUserDetails = baseUrl + 'get_user_details/?user_id=';
  static const String get_verification_status = baseUrl + 'get_verification_status?user_id=';
  static const String getSourcesOfIncome = baseUrl + 'get_sources_of_income';
  static const String profile_update = baseUrl + 'profile_update';
  static const String editProfile = baseUrl + 'edit_profile';
  static const String login = baseUrl + 'login';
  static const String changePassword = baseUrl + 'change_password';
  static const String forgotPassword = baseUrl + 'forgot_password';
  static const String resent_otp = baseUrl + 'resent_otp';
  static const String getNews = baseUrl + 'getNews';
  static const String getRelatedNews = baseUrl + 'getRelatedNews';
  static const String applyForJob = baseUrl + 'applyForJob';
  static const String getTrainingVideos = baseUrl + 'getTrainingVideos';
  static const String addService = baseUrl + 'AddService';
  static const String editService = baseUrl + 'editService';
  static const String deleteService = baseUrl + 'deleteService';

  static const String serviceList = baseUrl + 'getServiceList';
  static const String deletePackage = baseUrl + 'deletePackage';
  static const String packageList = baseUrl + 'myPackagesList';
  static const String addPackage = baseUrl + 'addPackage';
  static const String editPackage = baseUrl + 'editPackage';
  static const String bannerList = baseUrl + 'getBanner';
  static const String addBooking = baseUrl + 'addBooking';
  static const String myBookingList = baseUrl + 'myBookingList'; //?user_id=1&user_type=1&time=314
  static const String getBookingInformation = baseUrl + 'getBookingDetails';  //?user_id=69&user_type=2&booking_id=5
  // static const String bannerList = baseUrl + 'getBanner';




static const String searchUserServices = baseUrl + 'searchUserServices';
  static const String getNotifications = baseUrl + 'GetNotification?user_id=';
  static const String getStripeKey = baseUrl + 'getStripeKey';
  static const String getStripeIntent = baseUrl + 'CreatePaymentIntent';
  static const String setupStripeIntent = baseUrl + 'getStripeIntent';
  static const String getpaymentMethodFromSecretKey = 'https://api.stripe.com/v1/setup_intents/';
  static const String updateDeviceToken = baseUrl + 'update_device_id';
  static const String startCall = baseUrl + 'startCall';
  static const String endCall = baseUrl + 'endCall';


  static const String accept_reject = baseUrl + 'accept_reject';
  // static const String getStripeIntent = baseUrl + 'getStripeIntent';
  //


  // static const String getCities = baseUrl + 'city_list';
  //

//sub_catagory_list

}
