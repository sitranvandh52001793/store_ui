import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {
  List _posts = [];
  int _page = 1;
  bool _isLoading = false;
  int get page => _page;
  bool get isLoading => _isLoading;
  List get posts => _posts;

  Future<void> fetchPosts() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final url =
        'https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=12&page=$_page';
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      _posts.addAll(json);
      _page++;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
