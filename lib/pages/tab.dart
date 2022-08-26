import 'package:calltofix/constants/constans.dart';
import 'package:calltofix/pages/homepage.dart';
import 'package:calltofix/pages/my_bookings.dart';
import 'package:calltofix/pages/my_wallet.dart';
import 'package:calltofix/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/image_urls.dart';

/// This is the stateful widget that the main application instantiates.
class TabsPage extends StatefulWidget {
  static const String id="tab";
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

/// This is the private State class that goes with TabsPage.
class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  static const List<Widget> _widgetOptions = <Widget>[

    HomePage(),
    My_Bookings_page(),
    My_Wallet_Page(),
    Profile_Page(),

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
        padding: EdgeInsets.symmetric(horizontal: 40),
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
                label: 'Bookings',
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

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
