import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/resources/firebase_auth.dart';
import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  final String loginWith;
  const HomeScreen({
    super.key,
    required this.loginWith,
  });

  void signOut() async {
    if (loginWith == 'google') {
      await AuthMethods().signOutWithGoogle();
    } else if (loginWith == 'facebook') {
      await AuthMethods().signOutWithFacebook();
    } else if (loginWith == 'github') {
      await AuthMethods().signOutWithGitHub();
    } else if (loginWith == 'phone') {
      await AuthMethods().signOutWithPhone();
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: loginWith != 'phone'
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            auth.currentUser!.photoURL.toString(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Text(
                              'Name: ${auth.currentUser!.displayName}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            loginWith == 'github' ? Text(
                              'Email: ${globalUserCredential.user!.email}',
                              style: const TextStyle(fontSize: 17),
                            ): Text(
                              'Email: ${globalUserCredential.additionalUserInfo!.profile?['email']}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Login with: $loginWith',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset('assets/icons/phoneIcon.svg'),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Text(
                              'Phone: ${auth.currentUser!.phoneNumber}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Login with: $loginWith',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
