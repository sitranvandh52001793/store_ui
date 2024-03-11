import 'package:flutter/material.dart';
import 'package:store_ui/Screens/Auth/register_page.dart';
import 'package:store_ui/Utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Center(
        child: FlutterLogo(),
      ),
    ));
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 2), () {
      PageNavigator(ctx: context).nextPage(page: const RegisterPage());
    });
  }
}
