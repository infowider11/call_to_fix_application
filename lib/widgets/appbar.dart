
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'CustomTexts.dart';

AppBar appBar(
    {String? title,
      Color appBarColor = Colors.transparent,
      Color titleColor = Colors.black,
      bool implyLeading = true,
      IconData backIcon = Icons.chevron_left_outlined,
      double fontsize = 16,
      double size = 25,
      double toolbarHeight = 50,
      String badge = '0',
      String fontfamily = 'medium',
      required BuildContext context,
      List<Widget>? actions, leading}) {
  return AppBar(
    toolbarHeight: toolbarHeight,
    automaticallyImplyLeading: false,
    backgroundColor: appBarColor,

    elevation: 0,
    title: title == null
        ? null
        : AppBarHeadingText(
          text: title,
          color: titleColor,
          fontSize: fontsize,
          fontFamily: fontfamily,
        ),
    leading: implyLeading
        ? IconButton(
        icon:
        Icon(
         backIcon,
          color: titleColor,
          size: size,
        ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        : leading,
    actions: actions,
  );
}