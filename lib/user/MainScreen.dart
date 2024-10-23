import 'package:flutter/material.dart';
import 'package:unlimited_shopping/user/ViewOrdersScreen.dart';
import 'package:unlimited_shopping/user/home.dart';
import 'package:unlimited_shopping/user/setting.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ViewOrdersScreen(),
    SettingsPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _children[_currentIndex], 
    bottomNavigationBar: BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white, 
      unselectedItemColor: Color.fromARGB(179, 255, 255, 255),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      backgroundColor: Color(0xFFD32F2F), 
    ),
  );
}

}
