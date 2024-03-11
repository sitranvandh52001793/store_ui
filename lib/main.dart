import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/AuthProviders/auth_provider.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme:
                AppBarTheme(color: primaryColor, foregroundColor: white),
            primaryColor: primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
