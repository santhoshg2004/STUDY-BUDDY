import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';



class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPage({super.key});

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
                const SizedBox(height: 20),
                const Text(
                  "Study Buddy",
                  style: TextStyle(
                      fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                buildTextField(emailController, 'Email'),
                const SizedBox(height: 20),
                buildTextField(passwordController, 'Password', obscure: true),
                const SizedBox(height: 30),
                buildLoginButton(context),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
                  child: const Text("Forgot password?", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignupPage())),
                  child: const Text("Sign up", style: TextStyle(color: Colors.white)),
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

  Widget buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 115, 145, 142),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        shape: const StadiumBorder(),
      ),
      child: const Text("Login", style: TextStyle(fontSize: 18)),
      onPressed: () async {
        try {
          final UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          if (userCredential.user != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          }
        } on FirebaseAuthException catch (e) {
          String message = 'Login failed';
          if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            message = 'Wrong password provided.';
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
    );
  }
}
