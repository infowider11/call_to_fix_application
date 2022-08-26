import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/pages/my_bookings.dart';
import 'package:calltofix/pages/profile_page.dart';
import 'package:calltofix/provider_pages/job_history_page.dart';
import 'package:calltofix/provider_pages/my_wallet_provider.dart';
import 'package:calltofix/provider_pages/news.dart';
import 'package:calltofix/provider_pages/provider_home_page.dart';
import 'package:calltofix/provider_pages/provider_myprofilepage.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/global_keys.dart';
import '../constants/image_urls.dart';

/// This is the stateful widget that the main application instantiates.
class Tabs_Provider_Page extends StatefulWidget {
  static const String id="tab2";
  const Tabs_Provider_Page({Key? key}) : super(key: key);

  @override
  State<Tabs_Provider_Page> createState() => _Tabs_Provider_PageState();
}

/// This is the private State class that goes with Tabs_Provider_Page.
class _Tabs_Provider_PageState extends State<Tabs_Provider_Page> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  static  List<Widget> _widgetOptions = <Widget>[

    Provider_home_page(key: MyGlobalKeys.providerHomePageKey,),
    Job_History_page(),
    News_Page(),
    Provider_MyProfilePage(),
    My_Wallet_Provider_Page(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            boxShadowtop
          ]
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 9,
          elevation: 0,
          unselectedFontSize: 9,
          selectedLabelStyle: TextStyle(fontFamily: 'medium'),
          unselectedLabelStyle: TextStyle(fontFamily: 'medium'),
          unselectedItemColor: MyColors.textcolor,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(MyImages.home),
                color: MyColors.textcolor,
                size: 24,
              ),
              activeIcon:ImageIcon(
                AssetImage(MyImages.home),
                 color: MyColors.primaryColor,
                size: 24,
              ),
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                label: 'Job History',
                // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              icon: Stack(
                children: [
                  ImageIcon(
                    AssetImage(MyImages.document),
                    color: MyColors.textcolor,
                    size: 24,
                  ),
                ],
              ),
              activeIcon: Stack(
                  children: <Widget>[
                    // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
                    ImageIcon(
                      AssetImage(MyImages.document),
                      color: MyColors.primaryColor,
                      size: 24,
                    ),
                  ],
                ),
            ),
            BottomNavigationBarItem(
              label: 'News',
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              icon: Stack(
                children: [
                  ImageIcon(
                    AssetImage(MyImages.work),
                    color: MyColors.textcolor,
                    size: 24,
                  ),
                ],
              ),
              activeIcon: Stack(
                children: <Widget>[
                  // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
                  ImageIcon(
                    AssetImage(MyImages.work),
                    color: MyColors.primaryColor,
                    size: 24,
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.school, size: 30, color: Colors.black,),
              icon: ImageIcon(
                AssetImage(MyImages.profile),
                color: MyColors.textcolor,
                size: 24,
              ),
              activeIcon: ImageIcon(
                AssetImage(MyImages.profile),
                color: MyColors.primaryColor,
                size: 24,
              ),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              label: 'Wallet',
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              icon: Stack(
                children: [
                  ImageIcon(
                    AssetImage(MyImages.wallet),
                    color: MyColors.textcolor,
                    size: 24,
                  ),
                ],
              ),
              activeIcon: Stack(
                children: <Widget>[
                  // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
                  ImageIcon(
                    AssetImage(MyImages.wallet),
                    color: MyColors.primaryColor,
                    size: 24,
                  ),
                ],
              ),
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
