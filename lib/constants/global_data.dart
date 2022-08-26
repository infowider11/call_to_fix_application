import 'package:calltofix/modals/user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

List cities = [];
List professions = [];
List sourcesOfIncomeList = [
  // 'Personal Call',
  // 'Spare Part Shop',
  // 'Service Center',
];

late String secret_key;
late String publishable_key;
late Map<String, dynamic> headers;
const List newsCategory = [
  'Latest News',
  'Today',
  'Jobs',
];

late SharedPreferences sharedPreferences;
Map? userData;
// UserModal? userData;