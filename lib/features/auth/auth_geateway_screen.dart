import 'package:dauys_remote/core/constants/app_image.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'email_login_screen.dart'; // Import the gateway screen

class AuthGeatewayScreen extends StatefulWidget {
  const AuthGeatewayScreen({super.key});

  @override
  _AuthGeatewayScreenState createState() => _AuthGeatewayScreenState();
}

class _AuthGeatewayScreenState extends State<AuthGeatewayScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (error) {
      print(error);
    }
    print('googleUser');
    print(googleUser);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    print('googleAuth');
    print(googleAuth?.accessToken);
    print(googleAuth?.idToken);
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if(loginResult.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    print('loginResult');
    print(loginResult.status);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            const SizedBox(width: double.infinity),
            Image.asset(
              AppImage.icon,
              height: 50,
              width: 48,
            ),
            const SizedBox(height: 20),
            Text(
              'Миллионы треков.\nВместе с Dauys.',
              style: AppStyles.magistral24w500.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 150),
            AppButton(
              title: 'Войти через Google',
              iconAsset: AppImage.google,
              type: AppButtonType.outlined,
              onTap: () {
                signInWithGoogle();
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              title: 'Войти через Facebook',
              iconAsset: AppImage.facebook,
              type: AppButtonType.outlined,
              onTap: () {
                signInWithFacebook();
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              title: 'Войти',
              type: AppButtonType.text,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailLoginScreen()),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
