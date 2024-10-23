import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unlimited_shopping/admin/AdminHomeScreen.dart';
import 'package:unlimited_shopping/admin/login.dart';
import 'package:unlimited_shopping/user/MainScreen.dart';
import 'package:unlimited_shopping/user/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {


    if (_emailController.text == "admin@gmail.com" && _passwordController.text == "admin123") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );
    }


else{
  

    try {




      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {  

         Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during login';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    }
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
                    hintText: 'Email', 
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
            


 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have account?',
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                      child: Text(' Sign up now'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => RegisterScreen()), 
                        );
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ],
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
