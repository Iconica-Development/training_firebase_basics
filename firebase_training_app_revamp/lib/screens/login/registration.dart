import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_training_app_revamp/screens/user/home.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({
    Key? key,
  }) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerRepeat =
      TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                controller: _emailController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Repeat password',
                ),
                controller: _passwordControllerRepeat,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  signUp(_emailController.text, _passwordController.text,
                      _passwordControllerRepeat.text);
                },
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password, String passwordRepeat) async {
    try {
      if (password == passwordRepeat) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        setState(() {
          errorMessage = '';
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          errorMessage = 'Passwords do not match';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An unknown error occurred';
      });
    }
  }
}
