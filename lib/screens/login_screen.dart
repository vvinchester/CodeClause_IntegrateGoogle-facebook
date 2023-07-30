import 'package:firebase_authentication/widgets/facebook_sign_in_button.dart';
import 'package:firebase_authentication/widgets/github_sign_in_button.dart';
import 'package:firebase_authentication/widgets/google_sign_in_button.dart';
import 'package:firebase_authentication/widgets/phone_sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: const Center(
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GoogleSignInButton(),
                FacebookSignInButton(),
                GithubSignInButton(),
                PhoneSignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
