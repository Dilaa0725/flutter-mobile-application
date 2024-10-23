import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unlimited_shopping/user/ChangePasswordScreen%20.dart';
import 'package:unlimited_shopping/user/login.dart';

class SettingsPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final String email = user?.email ?? 'Not logged in';

    final String appVersion = '1.0.0';

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFFD32F2F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [







            userCard(email),
            SizedBox(height: 20),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock_outline, color: Color(0xFFD32F2F)),
             onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
  );
},

            ),
         
            Divider(color: Color(0xFFD32F2F)),
            ListTile(
              title: Text('App Version'),
              subtitle: Text(appVersion),
              leading: Icon(Icons.info_outline, color: Color(0xFFD32F2F)),
              onTap: () {
            
              },
            ),
            logoutButton(context),
          ],
        ),
      ),
    );
  }

  Card userCard(String email) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD32F2F),
                ),
              ),
              Divider(color: Color(0xFFD32F2F)),
              Text(
                'Email: $email',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFD32F2F),
                ),
              ),
            ],
          ),
        ),
      );

  ElevatedButton logoutButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFD32F2F),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () => _logout(context),
        child: Text('Logout', style: TextStyle(fontSize: 18)),
      );
}
