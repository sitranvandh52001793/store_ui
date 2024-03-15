import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Layouts/main_layout.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Screens/Auth/verify_page.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';

class AuthProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  bool _isLoading = false;
  String _resMessageSuccess = '';
  String _resMessageError = '';
  bool get isLoading => _isLoading;
  String get resMessageSuccess => _resMessageSuccess;
  String get resMessageError => _resMessageError;

  void register({
    required String name,
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
    String url = '$requestUrl/auth/register';
    final body = {
      'name': name,
      'email': email,
      'password': password,
    };
    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
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
        PageNavigator(ctx: context).nextPage(page: const VerifyPage());
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        if (req.statusCode == 400) {
          _resMessageError = res['data']['email'];
        } else {
          _resMessageError = res['data']['message'];
        }
        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
        }
        notifyListeners();
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

  void login({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
    UserDataProvider userDataProvider = UserDataProvider();

    String url = '$requestUrl/auth/login';

    final body = {
      "email": email,
      "password": password,
    };

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
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

        // save and navigate to the home page
        final token = res['data']['token'];
        // UserModel user = res['data']['user'];

        userDataProvider.saveToken(token);
        final getMe = await UserProvider().getMe();
        await userDataProvider.saveProfile(getMe);

        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPageOnly(page: const MainLayout());
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        if (req.statusCode == 401) {
          userDataProvider.saveEmail(email);
          // ignore: use_build_context_synchronously
          PageNavigator(ctx: context).nextPage(page: const VerifyPage());
        }
        if (req.statusCode == 400 || req.statusCode == 401) {
          // Kiểm tra có tồn tại key 'email' trong res['data'] không
          if (res['data'].containsKey('email')) {
            _resMessageError = res['data']['email'];
          } else if (res['data'].containsKey('password')) {
            _resMessageError = res['data']['password'];
          }
        } else {
          _resMessageError = res['data']['message'];
        }
        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
        }
        notifyListeners();
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

  void verify({
    required String email,
    required String otp,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/auth/verify';

    final body = {
      "email": email,
      "otp": otp,
    };

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
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

        if (req.statusCode == 404 || req.statusCode == 401) {
          // Kiểm tra có tồn tại key 'email' trong res['data'] không
          if (res['data'].containsKey('email')) {
            _resMessageError = res['data']['email'];
          } else if (res['data'].containsKey('password')) {
            _resMessageError = res['data']['password'];
          }
        } else {
          _resMessageError = res['data']['message'];
        }
        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
        }
        notifyListeners();
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

  void resendOtp({
    required String email,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/auth/resend-otp';

    final body = {
      "email": email,
    };

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
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
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;

        _resMessageError = res['data']['message'];
        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
        }
        notifyListeners();
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

  void clear() {
    _resMessageSuccess = '';
    _resMessageError = '';
    notifyListeners();
  }
}
