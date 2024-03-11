import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({this.ctx});
  BuildContext? ctx;

  ///Navigator to next page
  Future nextPage({Widget? page}) {
    // CupertinoPageRoute là một loại route dành cho iOS app (có thể sử dụng cho cả Android)
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: ((context) => page!)));
  }

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, MaterialPageRoute(builder: (context) => page!), (route) => false);
  }
}
