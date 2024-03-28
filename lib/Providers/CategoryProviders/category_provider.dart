import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_ui/Constants/url.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  final requestUrl = ApiUrl.baseUrl;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<dynamic> getAllCategory() async {
    String url = '$requestUrl/categories';
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    try {
      http.Response req = await http.get(
        Uri.parse(url),
      );
      final res = jsonDecode(req.body);
      notifyListeners();
      return res['data'];
    } on SocketException {
      _isLoading = false;

      notifyListeners();
    } catch (e) {
      _isLoading = false;

      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
