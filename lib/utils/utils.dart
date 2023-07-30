import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late UserCredential globalUserCredential;

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 3),
    ),
  );
}