import 'package:flutter/material.dart';

import '../model/userModel.dart';

class UserProvider with ChangeNotifier {
  UserModel _userModel = UserModel(uid: '', phoneNumber: '');

  UserModel get userModel => _userModel;

  void setUID(String uid) {
    _userModel = UserModel(uid: uid, phoneNumber: '');
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _userModel = UserModel(uid: _userModel.uid, phoneNumber: phoneNumber);
    notifyListeners();
  }
}
