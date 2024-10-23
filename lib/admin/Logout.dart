import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unlimited_shopping/admin/login.dart';
import 'package:unlimited_shopping/user/login.dart';

class Logout extends StatelessWidget {
 @override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text('Settings', style: TextStyle(color: Colors.white)),
    backgroundColor: Color(0xFFFF3B30), 
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView( 
      children: [
      
        SizedBox(height: 20),
        Text(
          'User Settings',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFF3B30), 
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
         
          },
          child: Text('Edit Profile', style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFF3B30), 
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
           
          },
          child: Text('Account Security', style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFF3B30), 
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login()), 
            );
          },
          child: Text('Logout', style: TextStyle(fontSize: 18)),
        ),
      ],
    ),
  ),
);


}
}