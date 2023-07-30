import 'package:firebase_authentication/screens/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneSignInButton extends StatelessWidget {
  const PhoneSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PhoneNumberScreen(),
              ),
            );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 7,
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/phoneIcon.svg', height: 30),
            const Expanded(
              child: Center(
                child: Text(
                  'Sign in with Phone',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
