import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_ui/Models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String _token = '';
  String _name = '';
  String _phone = '';

  String get token => _token;
  String get name => _name;
  String get phone => _phone;

  void runTimeProfile({String? name, String? phone}) {
    _name = name ?? _name;
    _phone = phone ?? _phone;
    notifyListeners();
  }

  void saveToken(String token) async {
    final SharedPreferences pref = await _pref;
    pref.setString('token', token);
    notifyListeners();
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  // Check login
  Future<bool> isLogin() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('token')) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveEmail(String data) async {
    final SharedPreferences pref = await _pref;
    pref.setString('email', data); // Sử dụng toJson của UserModel
    notifyListeners();
  }

  Future<String> getEmail() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('email')) {
      String data = value.getString('email')!;
      notifyListeners();
      return data;
    } else {
      notifyListeners();
      return '';
    }
  }

  Future<void> saveProfile(UserModel data) async {
    final SharedPreferences pref = await _pref;
    pref.setString(
        'profile', jsonEncode(data.toJson())); // Sử dụng toJson của UserModel
    notifyListeners();
  }

  Future<UserModel> getProfile() async {
    final SharedPreferences pref = await _pref;
    String? userDataString = pref.getString('profile');

    if (userDataString != null && userDataString.isNotEmpty) {
      Map<String, dynamic> userDataJson = jsonDecode(userDataString);
      return UserModel.fromJson(
          userDataJson); // Chuyển đổi dữ liệu từ JSON thành UserModel
    } else {
      return UserModel(); // Trả về một UserModel mặc định nếu không có dữ liệu được lưu trữ
    }
  }
}
