import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screens/otp_screen.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signInWithPhone(
      String phoneNumber, BuildContext context) async {
    String result = 'success';
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('$verificationId: Phone number verification timeout');
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          OtpScreen.verificationId = verificationId;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return OtpScreen(
                phoneNumber: phoneNumber,
              );
            }),
          );
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
      );
    } catch (e) {
      result = e.toString();
      debugPrint(result);
    }
    return result;
  }

  Future<void> signOutWithPhone() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> signInWithGoogle() async {
    String result = 'success';
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      globalUserCredential = userCredential;
      debugPrint('email : ${userCredential.user?.email}');
      debugPrint('displayName : ${userCredential.user?.displayName}');
      debugPrint('photoURL : ${userCredential.user?.photoURL}');
      debugPrint('phoneNumber : ${userCredential.user?.phoneNumber}');
      debugPrint('uid : ${userCredential.additionalUserInfo!.profile?['email']}');
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<String> signInWithFacebook() async {
    String result = 'success';
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      globalUserCredential = userCredential;
      
      debugPrint('email : ${userCredential.user?.email}');
      debugPrint('displayName : ${userCredential.user?.displayName}');
      debugPrint('photoURL : ${userCredential.user?.photoURL}');
      debugPrint('phoneNumber : ${userCredential.user?.phoneNumber}');
      debugPrint('uid : ${userCredential.additionalUserInfo!.profile?['email']}');
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<String> signInWithGitHub() async {
    String result = 'success';
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);
      globalUserCredential = userCredential;
      
      debugPrint('email : ${userCredential.user?.email}');
      debugPrint('displayName : ${userCredential.user?.displayName}');
      debugPrint('photoURL : ${userCredential.user?.photoURL}');
      debugPrint('phoneNumber : ${userCredential.user?.phoneNumber}');
      debugPrint('uid : ${userCredential.additionalUserInfo!.profile?['email']}');
    } catch (e) {
      result = e.toString();
      debugPrint(result);
    }
    return result;
  }

  Future<void> signOutWithGitHub() async {
    await FirebaseAuth.instance.signOut();
  }
}
