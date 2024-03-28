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
  String _active = 'active_order';
  String get active => _active;
  int get page => _page;
  String _status = '';
  String _statusIndex = '';
  String get statusIndex => _statusIndex;
  String get status => _status;
  bool get isLoading => _isLoading;
  List get products => _products;

// set status
  void setStatus(String status) {
    _status = status;
    notifyListeners();
  }

  void setStatusIndex(String index) {
    _statusIndex = index;
    notifyListeners();
  }

  // set active
  void setActive(String act) {
    _active = act;
    notifyListeners();
  }

  Future<void> getAllProduct(
      {String? keyword, String? sortBy, String? order, String? brand}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    String url = '';

    if (_status.isEmpty) {
      url = '$requestUrl/products?page=$_page';
    } else if (_status == 'sold') {
      url = '$requestUrl/products?page=$_page&sort_by=$_status';
    } else if (_status == 'desc') {
      url = '$requestUrl/products?page=$_page&order=$_status';
    } else if (_status == 'name') {
      url = '$requestUrl/products?page=$_page&name=$keyword';
    } else if (_statusIndex != 'null') {
      url = '$requestUrl/products?page=$_page&brand=$_statusIndex';
    }
    if (keyword != null && keyword.isNotEmpty) {
      setStatus('name');
      _page = 1;
      url = '$requestUrl/products?page=$_page&name=$keyword';
      products.clear();
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      setStatus('sold');
      setActive('active_sort_by');
      _page = 1;

      url = '$requestUrl/products?page=$_page&sort_by=$sortBy';
      products.clear();
    }
    if (order != null && order.isNotEmpty) {
      setStatus('desc');
      setActive('active_order');

      _page = 1;
      url = '$requestUrl/products?page=$_page&order=$order';
      products.clear();
    }
    if (brand != null && brand.isNotEmpty) {
      setStatusIndex(brand);
      _page = 1;
      url = '$requestUrl/products?page=$_page&brand=$_statusIndex';

      products.clear();
    } else {
      url = '$requestUrl/products?page=$_page&brand=$_statusIndex';
    }
    if (_statusIndex == 'null') {
      url = '$requestUrl/products?page=$_page';
    }
    if (kDebugMode) {
      print(url);
    }

    try {
      http.Response req = await http.get(
        Uri.parse(url),
      );

      final res = jsonDecode(req.body);
      final data = res['data']['products'];
      // final pagination = res['data']['pagination'];

      _products.addAll(data); // Thêm dữ liệu mới vào danh sách hiện tại

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
