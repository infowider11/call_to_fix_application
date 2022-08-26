import 'package:calltofix/constants/global_keys.dart';
import 'package:flutter/material.dart';

showSnackbar(String text){
  ScaffoldMessenger.of(MyGlobalKeys.navigatorKey.currentContext!).showSnackBar(
    SnackBar(content: Text(text),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      behavior: SnackBarBehavior.floating,
    )
  );
}