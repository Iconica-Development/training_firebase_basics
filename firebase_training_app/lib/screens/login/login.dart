import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_training/screens/login/registration.dart';
import 'package:firebase_training/screens/user/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Fast skip login
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'niels@iconica.nl', password: 'test123');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    });
  }

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
                  login(_emailController.text, _passwordController.text);
                },
                child: const Text('Sign in'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Registration(),
                    ),
                  );
                },
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        errorMessage = '';
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An unknown error occurred';
      });
    }
  }
}
