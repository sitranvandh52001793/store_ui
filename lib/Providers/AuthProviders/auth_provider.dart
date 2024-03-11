import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:toastification/toastification.dart';

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
        body: json.encode(body),
      );
      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessageSuccess = res['data']['message'];
        if (_resMessageSuccess.isNotEmpty) {
          showCustomToast(
            // ignore: use_build_context_synchronously
            context: context!,
            msg: _resMessageSuccess,
            type: ToastificationType.success,
            iconData: Icons.check,
          );
        }
        notifyListeners();
        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPage(page: const LoginPage());
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        if (req.statusCode == 400) {
          _resMessageError = res['data']['email'];
        } else {
          _resMessageError = res['data']['message'];
        }
        if (_resMessageError.isNotEmpty) {
          showCustomToast(
            // ignore: use_build_context_synchronously
            context: context!,
            msg: _resMessageError,
            type: ToastificationType.error,
            iconData: Icons.error,
          );
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
      _resMessageSuccess = '';
      _resMessageError = '';
      notifyListeners();
    }
  }
}
