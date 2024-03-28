import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Screens/Cart/cart_page.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';

class OrderProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  String _resMessageError = '';
  String _resMessageSuccess = '';
  String get resMessageError => _resMessageError;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void createOrder({String? note, required BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/orders';
    final token = await UserDataProvider().getToken();
    final body = {
      "note": note,
    };

    try {
      http.Response req = await http.post(
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
        // Dùng shared_preferences để lưu lại cho tôi rằng đã đặt hàng thành công

        if (_resMessageSuccess.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageSuccess);
        }

        notifyListeners();

        // ignore: use_build_context_synchronously
        PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
      } else {
        final res = jsonDecode(req.body);

        _isLoading = false;
        if (req.statusCode == 401) {
          _resMessageError = res['data']['message'];
        }
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
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

  Future<dynamic> getAllOrder({required BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/orders';
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
        return res['data']['orders'];
      } else {
        final res = jsonDecode(req.body);

        _isLoading = false;
        if (req.statusCode == 401) {
          _resMessageError = res['data']['message'];
        }
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
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

  Future<dynamic> getAllOrderById(
      {required int id, required BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/orders/$id';
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

        return res['data'];
      } else {
        final res = jsonDecode(req.body);

        _isLoading = false;

        if (req.statusCode == 401) {
          _resMessageError = res['data']['message'];
        }
        _resMessageError = res['data']['message'];

        if (_resMessageError.isNotEmpty) {
          // ignore: use_build_context_synchronously
          errorMessage(context: context!, message: _resMessageError);
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

  void clear() {
    _resMessageSuccess = '';
    _resMessageError = '';
    notifyListeners();
  }
}
