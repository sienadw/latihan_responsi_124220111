import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String password = '';
  bool isVisible = true;

  final _formKey = GlobalKey<FormState>();

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
              "Register Yourself!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please Choose A Username And Password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  usernameField(),
                  passwordField(),
                  const SizedBox(height: 20),
                  registerButton(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            loginText(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username is required';
        }
        return null;
      },
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          return null;
        },
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

  Widget registerButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          authServices.simpanAkun(username, password);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
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
        'Register',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget loginText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Already have an account? ",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Login here',
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
