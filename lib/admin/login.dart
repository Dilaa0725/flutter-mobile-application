import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unlimited_shopping/OnboardingScreen.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == "admin@gmail.com" && password == "admin123") {
      /*Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );*/
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFFF3B30),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Unlimited Shopping',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8), 
                Text(
                  'Online Shopping',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: 16.0, 
                  ),
                ),
                SizedBox(height: 48), 
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Color(0xFFFF3B30)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), 
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password', 
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFFF3B30)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), 
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, 
                    onPrimary: Color(0xFFFF3B30), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), 
                    ),
                  ),
                  onPressed: _login,
                ),
                SizedBox(height: 15),
                TextButton(
                  child: Text('Forgot Password'), 
                  onPressed: () {
                  
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white, 
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Don’t have account? Sign up now.', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

}
