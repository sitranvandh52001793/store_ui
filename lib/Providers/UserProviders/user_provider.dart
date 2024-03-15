import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Models/user_model.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';

class UserProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  bool _isLoading = false;
  String _resMessageSuccess = '';
  String _resMessageError = '';
  bool get isLoading => _isLoading;
  String get resMessageSuccess => _resMessageSuccess;
  String get resMessageError => _resMessageError;

  // Get me
  Future<UserModel> getMe() async {
    _isLoading = true;
    notifyListeners();
    String url = '$requestUrl/users/me';
    final token = await UserDataProvider().getToken();
    try {
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        notifyListeners();

        return UserModel.fromJson(res['data']);
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageError = res['data']['message'];
        notifyListeners();
        return UserModel();
      }
    } on SocketException {
      _isLoading = false;
      _resMessageError = 'Lỗi kết nối mạng';
      notifyListeners();
      return UserModel();
    } catch (e) {
      _isLoading = false;
      _resMessageError = 'Lỗi không xác định';
      notifyListeners();
      return UserModel();
    }
  }

  void changePassword({
    required String oldPassword,
    required String newPassword,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/users/update-password';
    final token = await UserDataProvider().getToken();

    final body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };

    try {
      http.Response req = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageSuccess = res['data']['message'];

        if (_resMessageSuccess.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageSuccess);
        }
        notifyListeners();
        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageError);
          notifyListeners();
        }
      }
    } on SocketException {
      _isLoading = false;
      _resMessageError = 'Lỗi kết nối mạng';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessageError = 'Lỗi không xác định';
      notifyListeners();
    } finally {
      clear();
    }
  }

  void updateMe({
    String? name,
    String? phone,
    String? province,
    String? district,
    String? village,
    String? shortDescription,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/users/update';
    final token = await UserDataProvider().getToken();
    final body = {
      "name": name,
      "phone": phone,
      "province": province,
      "district": district,
      "village": village,
      "shortDescription": shortDescription,
    };

    try {
      http.Response req = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageSuccess = res['data']['message'];

        if (_resMessageSuccess.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageSuccess);
        }
        // Set lại profile
        final me = await getMe();
        UserDataProvider userDataProvider = UserDataProvider();
        userDataProvider.saveProfile(me);

        notifyListeners();

        // ignore: use_build_context_synchronously
        Navigator.of(context!).pop();
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageError);
          notifyListeners();
        }
      }
    } on SocketException {
      _isLoading = false;
      _resMessageError = 'Lỗi kết nối mạng';
      if (_resMessageError.isNotEmpty) {
        // ignore: use_build_context_synchronously
        errorMessage(context: context!, message: _resMessageError);
      }
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessageError = 'Lỗi không xác định';
      if (_resMessageError.isNotEmpty) {
        // ignore: use_build_context_synchronously
        errorMessage(context: context!, message: _resMessageError);
      }
      notifyListeners();
    } finally {
      clear();
    }
  }

  void logout({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/users/logout';
    final token = await UserDataProvider().getToken();

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageSuccess = res['data']['message'];

        if (_resMessageSuccess.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context, message: _resMessageSuccess);
        }
        notifyListeners();

        pref.remove('token');
        pref.remove('profile');
        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context, message: _resMessageError);
          notifyListeners();
        }
      }
    } on SocketException {
      _isLoading = false;
      _resMessageError = 'Lỗi kết nối mạng';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessageError = 'Lỗi không xác định';
      notifyListeners();
    } finally {
      clear();
    }
  }

  void clear() {
    _resMessageSuccess = '';
    _resMessageError = '';
    notifyListeners();
  }
}
