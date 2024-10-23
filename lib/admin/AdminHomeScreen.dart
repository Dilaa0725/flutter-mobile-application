import 'package:flutter/material.dart';
import 'package:unlimited_shopping/admin/AddCategoryScreen.dart';
import 'package:unlimited_shopping/admin/AddProductScreen.dart';
import 'package:unlimited_shopping/admin/DeleteCategoryScreen.dart';
import 'package:unlimited_shopping/admin/Logout.dart';
import 'package:unlimited_shopping/admin/ViewAllOrdersPage.dart';


class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _adminScreens = [
    AddProductScreen(),
    AddCategoryScreen(),
    ViewAllOrdersPage(),
    DeleteCategoryScreen(),
    Logout()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }@override
Widget build(BuildContext context) {
  return Scaffold(
    body: IndexedStack(
      index: _selectedIndex,
      children: _adminScreens, 
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Product',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Add Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete),
          label: 'Delete Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFFF3B30), 
      unselectedItemColor: Colors.grey, 
      onTap: _onItemTapped, 
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white, 
      showUnselectedLabels: true, 
      selectedFontSize: 14.0,
      unselectedFontSize: 12.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600), 
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600), 
    ),
  );
}


}
