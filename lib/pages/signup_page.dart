import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';


class SignupPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.school, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text("Study Buddy",
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                buildTextField(nameController, 'Name'),
                SizedBox(height: 20),
                buildTextField(emailController, 'Email'),
                SizedBox(height: 20),
                buildTextField(passwordController, 'Password', obscure: true),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: StadiumBorder(),
                  ),
                  child: Text("Sign up", style: TextStyle(fontSize: 18)),
                  onPressed: () => signup(context),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Already have an account?", style: TextStyle(color: Colors.white))
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void signup(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // On successful signup, go back to login page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));

      // Optional: you can also show a toast/snackbar here confirming signup success
    } on FirebaseAuthException catch (e) {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Signup Failed'),
          content: Text(e.message ?? 'An error occurred'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
