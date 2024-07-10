import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simply_poem/utils/app_text.dart';
import 'package:simply_poem/utils/constants/pallete.dart';
import 'package:simply_poem/widgets/phone_input_field.dart';

import '../../services/authentication_services/phone_authentication.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final PhoneAuth _phoneAuth = PhoneAuth();
  String phoneNumber = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.phoneAuth),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: <Widget>[
            PhoneNumberInput(
              onPhoneNumberChanged: (number) {
                phoneNumber = number;
              },
            ),
            SizedBox(height: 20.h),
            isLoading
                ? const CircularProgressIndicator(
                    color: Pallete.black,
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (phoneNumber.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        _phoneAuth
                            .signInWithPhoneNumber(phoneNumber, context)
                            .then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(AppText.enterValidNumberError)),
                        );
                      }
                    },
                    child: const Text(AppText.signIn),
                  ),
          ],
        ),
      ),
    );
  }
}
