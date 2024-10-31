import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/ui/bookmarks_page.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/ui/restaurant_list_page.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/ui/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

enum BottomNavItem { home, favorites, settings }

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const BookmarksPage(),
    const SettingsPage()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}