import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:school/auth/profile.dart';
import 'package:school/home/home.dart';
import 'package:school/notifications.dart/notification.dart';
import 'package:school/search/search.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  int _selectedIndex = 0;


  void onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  List<Widget> listOfWidget = <Widget>[
    const Home(),
    const Search(),
    const Notifications(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: const Color.fromARGB(255, 197, 196, 196)!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.red,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration:const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(255, 243, 229, 229)!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.bell,
                  text: 'Notification',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  _goBranch(_selectedIndex);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
