// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simply_poem/utils/constants/pallete.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';
import 'package:simply_poem/widgets/toast.dart';

import '../../provider/user_provider.dart';
import '../../screens/login_and_authentication/user_preferences_screen.dart';

class PhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        await _storeUserData(context);
        print('authentication success');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserPreferences()));
      },
      verificationFailed: (FirebaseAuthException e) {
        showToastShort('Verification failed: ${e.message}', Pallete.red);
      },
      codeSent: (String verificationId, int? resendToken) {
        _showOtpDialog(context, verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        showToastShort('Auto retrieval timeout', Pallete.red);
      },
    );
  }

  Future<void> _showOtpDialog(
      BuildContext context, String verificationId) async {
    String otp = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Enter OTP',
            style:
                StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
          ),
          content: TextField(
            style:
                StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
            onChanged: (value) {
              otp = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otp,
                  );
                  await _auth.signInWithCredential(credential);
                  await _storeUserData(context);
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const UserPreferences()));
                } catch (e) {
                  showToastShort(
                      'Error signing in with credential: $e', Pallete.red);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _storeUserData(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'phone_number': user.phoneNumber,
        'username': null,
        'birthday': null,
        'gender': null,
        'profile': null,
        'location': null,
        'age': null,
        'weight': null,
        'createdAt': DateTime.now(),
      });
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('uid', user.uid);
      Provider.of<UserProvider>(context, listen: false).setUID(user.uid);
      Provider.of<UserProvider>(context, listen: false)
          .setPhoneNumber(user.phoneNumber ?? '');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserPreferences()));
    }
  }
}
