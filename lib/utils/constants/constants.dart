import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants._();
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );
  static RegExp contactRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  static const invalidEmailError = 'Please enter a valid email address';
  static const emptyPasswordInputError = 'Please enter your password';
  static const emptyConfirmPasswordInputError =
      'Please enter a confirm password';
  static const passwordgreaterthansix =
      'Password must be greater than 8 character';
  static const emptyEmailInputError = 'Please enter your email';
  static const nameInputEmptyError = "Please enter your name";
  static const confirmPasswordNotMatched = "Confirm password do not match";

  static const String hostUrl = 'http://51.20.184.13/api';
  static const String googleAPIKey = 'apikey';
  static String somethingWentWrong = 'Something went wrong';
  static String noInternet = 'No internet connection';
  static String otpNotVerifiedCaseText =
      'Your account is pending an OTP approval';
  static int listingChoice = 1;
}
