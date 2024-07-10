// user_preferences_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simply_poem/screens/login_and_authentication/set_profile_screen.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

import '../../services/user_preference_services/user_preference_services.dart';
import '../../utils/app_text.dart';
import '../../utils/constants/pallete.dart';
import '../../widgets/authTextField.dart';
import '../../widgets/toast.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({Key? key}) : super(key: key);

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  bool checkedValue = false;
  var isMale;
  TextEditingController username = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(1900), // Earliest date selectable
      lastDate: DateTime.now(), // Latest date selectable
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () async {
          if (username.text.isNotEmpty &&
              _dateController.text.isNotEmpty &&
              isMale != '') {
            await UserPreferencesService()
                .getLocationAndSaveToFirebase(
                  username.text.trim(),
                  _dateController.text,
                  isMale,
                )
                .whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProfileImagePicker())));
          } else {
            showToastShort(AppText.fillFieldsError, Pallete.red);
          }
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.verticalSpace,
              Text(
                AppText.userPreferences,
                style: StyleConstants.headerTextStyle
                    .copyWith(fontSize: 20.sp, color: Pallete.black),
              ),
              20.verticalSpace,
              AuthTextField(
                controller: username,
                obsecureText: false,
                text: AppText.username,
              ),
              20.verticalSpace,
              SizedBox(
                height: 60.h,
                width: 318.w,
                child: TextField(
                  controller: _dateController,
                  style: StyleConstants.headerTextStyle
                      .copyWith(color: Pallete.black),
                  decoration: InputDecoration(
                    hintText: AppText.selectYourBirthday,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 15.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.gender,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Pallete.black,
                      ),
                    ),
                  ],
                ),
              ),
              5.verticalSpace,
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = AppText.male;
                  });
                },
                child: Container(
                  height: 54.h,
                  width: 330.w,
                  margin: EdgeInsets.symmetric(horizontal: 23.w),
                  decoration: BoxDecoration(
                      color:
                          isMale == AppText.male ? Pallete.blue : Pallete.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          AppText.male,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: isMale == AppText.male
                                ? Pallete.white
                                : Pallete.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              5.verticalSpace,
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = AppText.female;
                  });
                },
                child: Container(
                  height: 54.h,
                  width: 330.w,
                  margin: EdgeInsets.symmetric(horizontal: 23.w),
                  decoration: BoxDecoration(
                      color: isMale == AppText.female
                          ? Pallete.black
                          : Pallete.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          AppText.female,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: isMale == AppText.female
                                ? Pallete.white
                                : Pallete.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
