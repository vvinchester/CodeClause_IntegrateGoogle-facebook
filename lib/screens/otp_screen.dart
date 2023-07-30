import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/resources/firebase_auth.dart';
import 'package:firebase_authentication/screens/home_screen.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  static String verificationId = '';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<FocusNode> digitFocusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> digitControllers =
      List.generate(6, (index) => TextEditingController());
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    digitFocusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      digitFocusNodes[i].dispose();
      digitControllers[i].dispose();
    }

    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        digitFocusNodes[index + 1].requestFocus();
      } else {
        digitFocusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        digitFocusNodes[index - 1].requestFocus();
      }
    }
  }

  String getOtp() {
    String otp = '';
    for (int i = 0; i < 6; i++) {
      otp += digitControllers[i].text;
    }
    return otp;
  }

  void onClick(BuildContext context) async {
    String otp = getOtp();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: OtpScreen.verificationId, smsCode: otp);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      globalUserCredential = userCredential;
      if (userCredential.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(loginWith: 'phone'),
            ),
            (route) => false);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void onRequestOtp(BuildContext context) async {
    await AuthMethods().signInWithPhone(widget.phoneNumber, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 36,
                color: Colors.black,
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Verify Phone",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          // width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "Code is sent to your ${widget.phoneNumber}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 300,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              6,
                              (index) => Container(
                                color: Colors.blue[50],
                                height: 45.0,
                                width: 45.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: TextField(
                                    controller: digitControllers[index],
                                    focusNode: digitFocusNodes[index],
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20.0),
                                    onTap: () {
                                      print('tapped');
                                    },
                                    onChanged: (value) =>
                                        _onDigitChanged(index, value),
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive the code? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(106, 108, 123, 1),
                                ),
                              ),
                              InkWell(
                                onTap: () => onRequestOtp(context),
                                child: const Text(
                                  "Request Again",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(6, 29, 40, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          onClick(context);
                        },
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
