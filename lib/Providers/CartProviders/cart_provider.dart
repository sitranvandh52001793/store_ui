import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Utils/notify.dart';

class CartProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  String _resMessageError = '';
  String _resMessageSuccess = '';
  String get resMessageError => _resMessageError;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _totalCart = 0;
  int get totalCart => _totalCart;
  CartProvider() {
    // Gọi phương thức getCart() để lấy danh sách sản phẩm trong giỏ hàng
    getCart().then((data) {
      // Nếu có dữ liệu trả về
      if (data != null) {
        // Gán giá trị cho _totalCart là độ dài của danh sách sản phẩm
        _totalCart = data.length;
        // Thông báo cho listeners về sự thay đổi
        notifyListeners();
      }
    });
  }
  void setTotalCart(int total) {
    _totalCart = total;
    notifyListeners();
  }

  void addProductToCart(
      {required String productId,
      required String quantity,
      required BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/carts';
    final token = await UserDataProvider().getToken();
    final body = {
      "productId": productId,
      "quantity": quantity,
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
        _totalCart = res['data']['totalNumber'];
        notifyListeners();
        if (_resMessageSuccess.isNotEmpty) {
          // ignore: use_build_context_synchronously
          successMessage(context: context!, message: _resMessageSuccess);
        }
        notifyListeners();
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

  Future<dynamic> getCart({BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    String url = '$requestUrl/carts';
    final token = await UserDataProvider().getToken();

    try {
      http.Response req = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);
        _isLoading = false;
        notifyListeners();
        return res['data'];
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
