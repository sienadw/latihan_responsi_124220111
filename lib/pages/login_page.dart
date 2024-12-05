import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../pages/home_page.dart';
import '../pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool isVisible = true;

  // Navigate to Home Page
  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          username: username,
          password: password,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Hi There!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please Input Your Username and Password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            usernameField(),
            passwordField(),
            const SizedBox(height: 20),
            loginButton(),
            const SizedBox(height: 10),
            registerText(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      onChanged: (value) {
        username = value;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        obscureText: isVisible,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () async {
        bool isLoginSuccess = await authServices.login(username, password);
        if (isLoginSuccess) {
          navigateToHome();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid username or password')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget registerText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Register here',
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
