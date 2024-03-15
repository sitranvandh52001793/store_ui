import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:store_ui/Constants/url.dart';
import 'package:store_ui/Models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  final List _products = [];
  String _resMessageError = '';
  String get resMessageError => _resMessageError;
  int _page = 1;
  bool _isLoading = false;
  bool _endPage = false;
  bool get endPage => _endPage;
  int get page => _page;
  bool get isLoading => _isLoading;
  List get products => _products;

  Future<void> getAllProduct() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    String url = '$requestUrl/products?page=$_page';
    if (kDebugMode) {
      print(url);
    }
    try {
      http.Response req = await http.get(
        Uri.parse(url),
      );

      final res = jsonDecode(req.body);

      final data = res['data']['products'];
      final pagination = res['data']['pagination'];
      if (page == pagination['page_size']) {
        _endPage = true;
        notifyListeners();
      }
      _products.addAll(data);

      _page++;
      notifyListeners();
    } on SocketException {
      _isLoading = false;
      _resMessageError = 'Lỗi kết nối mạng';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessageError = 'Lỗi không xác định';
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Product> getProductById({required String id}) async {
    _isLoading = true;
    notifyListeners();
    String url = '$requestUrl/products/$id';

    try {
      http.Response req = await http.get(
        Uri.parse(url),
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = jsonDecode(req.body);

        _isLoading = false;

        notifyListeners();

        return Product.fromJson(res['data']['product']);
      } else {
        final res = jsonDecode(req.body);
        _isLoading = false;
        _resMessageError = res['data']['message'];
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
    }
    return Product();
  }
}
